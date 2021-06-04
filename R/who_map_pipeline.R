#' wrapper function to add all components to who map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details wrapper function to add all components to who map
#' @param sf - list of shapefiles to be used
#' @param region - user defined region for logo and disclaimer text
#' @param data_source - user defined data source
#' @export

who_map_pipeline <- function(sf = pull_who_adm0(), region = "HQ", data_source = "World Health Organization") {

  list(
    geom_sf_who_line(data = sf[[grep("_line$", names(sf))]]),
    who_map_disp(sf),
    who_map_annotate(region = region, data_source = data_source),
    who_map_theme()
  )

}
