#' function to read SHP files for WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read SHP files for WHO map
#' @return a list of all shapefiles needed for mapping WHO maps at ADM0
#' @export

pull_who_adm0 <- function() {

  warning("THIS FUNCTION IS NOW DEPRECATED AND WILL NOT BE SUPPORTED IN FUTURE VERSIONS, please use pull_sfs()")
  out <- readr::read_rds(system.file("extdata", "adm0.rds", package="whomapper"))

  return(out)

}
