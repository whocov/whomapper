#' wrapper function to add all components to who map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details wrapper function to add all components to who map
#' @param sf - list of shapefiles to be used
#' @export

who_map_pipeline <- function(sf = pull_who_adm0()) {

  list(
    who_map_disp(sf),
    who_map_annotate(),
    who_map_theme()
  )

}
