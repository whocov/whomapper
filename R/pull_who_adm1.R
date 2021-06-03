#' function to read SHP files for WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read SHP files for WHO map ADM1 level
#' @return a list of all shapefiles needed for mapping WHO maps at ADM1
#' @example
#' who_shp <- pull_who_adm1();
#' @export

pull_who_adm1 <- function() {

  out <- readr::read_rds(system.file("extdata", "adm1.rds", package="whomapper")) %>%
    janitor::clean_names()

  return(out)
}
