#' function to read SHP files for WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read SHP files for WHO map
#' @returns a list of all shapefiles needed for mapping WHO maps at ADM0
#' @example
#' who_shp <- pull_who_adm0();
#' @export

pull_who_adm0 <- function() {


  adm0 <-
    sf::read_sf(system.file("extdata", "GLOBAL_ADM0.shp", package="whomapper"))
    janitor::clean_names() %>%
    dplyr::select("who_region", "iso_2_code", "adm0_name", "enddate","iso_3_code", "center_lon", "center_lat", "adm0_viz_n", "geometry")


  # WHO ADM0 lines (1.3MB)
  adm0_line <-
    sf::read_sf(system.file("extdata", "GLOBAL_ADM0_L.shp", package="whomapper"))
    janitor::clean_names() %>%
    dplyr::select("who_region", "iso_2_code", "adm0_name", "enddate","iso_3_code", "center_lon", "center_lat", "adm0_viz_n", "geometry")

  # Disputed areas
  disp_area <-
    sf::read_sf(system.file("extdata", "DISPUTED_AREAS.shp", package="whomapper"))
    janitor::clean_names()

  # Disputed borders
  disp_border <-
    sf::read_sf(system.file("extdata", "DISPUTED_BORDERS.shp", package="whomapper"))
    janitor::clean_names()

  return(list(
    "adm0" = adm0,
    "adm0_line" = amd0_line,
    "disp_area" = disp_area,
    "disp_border" = disp_border
  ))

}
