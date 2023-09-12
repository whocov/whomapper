#' function to pull sfs from local or server
#' @author HLS
#' @details function to read shapefiles for plotting purposes. cNurrently supports admin levels 0 through 2.
#' Can pull data from WHO servers or from stored offline versions (only to level 1.)
#' Stored data is not guaranteed to be up to date
#' Pulling adm0 data will also pull disputed areas and territories, and lines for plots where borders do not include coastlines.
#' It is recommended to pull country or at most regional data at lower administrative levels due to API limitations.
#' Consider iterating over consecutive areas if more data needed.
#' @param adm_level - which administrative level
#' @param iso3 the iso3 code of the country to pull data from. Defaults to NULL
#' @param region the WHO region to pull data from. Defaults to NULL
#' @param query_server should the data be pulled from the server? defaults to TRUE
#' @return shapefiles as specified
#' @export


pull_sfs <- function(adm_level = 0, iso3 = NULL, region = NULL, query_server = TRUE) {

  # check arguments
  if (!is.null(region)) {
    region <- match.arg(region, c("AFRO", "AMRO", "EMRO", "EURO", "SEARO", "WPRO"))
  }
  # query_server <- match.arg(query_server)
  match.arg(as.character(adm_level), choices = as.character(c(0:2)))


  if (query_server) {

    if (adm_level > 0) {
      dat <- read_geodata(generate_query_url(sf_type = adm_level, iso3 = iso3, who_region = region))
    } else {
      dat <- purrr::map(c("adm0", "disp_area", "disp_border", "adm0_line"),
                        ~read_geodata(generate_query_url(sf_type = .x, iso3 = iso3, who_region = region))) %>%
        purrr::set_names(c("adm0", "disp_area", "disp_border", "adm0_line"))

    }
    return(dat)


  } else {

    if (adm_level %in% c(2, 3)) {
      stop(stringr::str_glue("ADM{adm_level} not available offline, please use query_server = TRUE"))
    }

    ## read from offline data
    if (adm_level == 0) {
      dat <- readr::read_rds(system.file("extdata", "adm0.rds", package="whomapper"))

      if (!is.null(iso3)) dat$adm0 <- filter(dat$adm0, iso_3_code %in% iso3)
      if (!is.null(region)) dat$adm0 <- filter(dat$adm0, who_region %in% region)


    } else if (adm_level == 1) {
      dat <- readr::read_rds(system.file("extdata", "adm1.rds", package="whomapper")) %>%
        janitor::clean_names()


      if (!is.null(iso3))  dat <- dplyr::filter(dat, iso_3_code == iso3)
      if (!is.null(region)) dat <- dplyr::filter(dat, who_region %in% region)

    }

    return(dat)


  }



}

#' @author HLS
#' @details function to generate a url, for use in `pull_sfs()`.


generate_query_url <- function(sf_type, iso3 = NULL, who_region = NULL) {

  sf_type <- as.character(sf_type)

  if (!is.null(iso3)) {
    iso3 <- stringr::str_glue("where=ISO_3_CODE+%3D+%27{str_to_upper(iso3)}%27&")
  }

  if (!is.null(who_region)) {
    who_region <-   stringr::str_glue("where=WHO_REGION+%3D+%27{str_to_upper(who_region)}%27&")
  }

  filter_string <- paste0(iso3, who_region, collapse = "+AND+")

  if (filter_string == "") {
    filter_string <- "where=1%3D1&"
  }

  static_params <- "f=pgeojson&resultRecordCount=100000&outFields=*&returnGeometry=true"

  url <- dplyr::case_when(
    sf_type == "0" | sf_type == "adm0" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/Detailed_Boundary_ADM0/FeatureServer/0/query?{filter_string}{static_params}"),
    sf_type == "1" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/Detailed_Boundary_ADM1/FeatureServer/0/query?{filter_string}{static_params}"),
    sf_type == "2" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/Detailed_Boundary_ADM2/FeatureServer/0/query?{filter_string}{static_params}"),
    sf_type == "3" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/arcgis/rest/services/Detailed_Boundary_ADM3/FeatureServer/0/query?{filter_string}{static_params}"),
    sf_type == "disp_area" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/Detailed_Boundary_Disputed_Areas/FeatureServer/0/query?where=1%3D1&{static_params}"),
    sf_type == "disp_border" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/arcgis/rest/services/Detailed_Boundary_Disputed_Borders/FeatureServer/0/query?where=1%3D1&{static_params}"),
    sf_type == "adm0_line" ~ stringr::str_glue("https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/GLOBAL_ADM0_L/FeatureServer/0/query?where=1%3D1&{static_params}")
  )

  return(url)
}

#' @author HLS
#' @details function to read sfs from server with provided url, for use in `pull_sfs()`.

read_geodata <- function(x) {

  raw <- tryCatch(sf::st_read(x),
                  error = function(error_message){
                    message("failed to pull data")
                    return(NULL)
                  })

  if (is.null(raw)) return(NULL)

  raw %>%
    tibble::as_tibble() %>%
    sf::st_as_sf() %>%
    janitor::clean_names() %>%
    {
      if ("end_date" %in% colnames(raw)) {
        {.} %>%
          mutate(across(contains("date"), ~lubridate::as_datetime(
            . / 1000,
            origin = "1970-01-01",
            tz = "Europe/Zurich"))
          ) %>%
          dplyr::filter(end_date > Sys.Date())
      } else {
        {.}
      }
    } %>%
    dplyr::select(dplyr::contains("adm"),
                  dplyr::contains("name"),
                  dplyr::contains("shape"),
                  dplyr::contains("pcode"),
                  dplyr::any_of(c("iso_3_code", "who_region", "center_lon", "center_lat")),
                  geometry)
}


