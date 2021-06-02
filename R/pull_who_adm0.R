#' function to read SHP files for WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read SHP files for WHO map
#' @return a list of all shapefiles needed for mapping WHO maps at ADM0
#' @example
#' who_shp <- pull_who_adm0();
#' @export

pull_who_adm0 <- function() {

  out <- readr::read_rds(system.file("extdata", "adm0.rds", package="whomapper"))

  return(out)

}
