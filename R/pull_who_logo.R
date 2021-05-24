#' function to read the WHO logo for mapping puroses
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read the WHO logo for mapping puroses
#' @return a PNG of the WHO logo
#' @export


pull_who_logo <- function() {
  png::readPNG(system.file("extdata", "WHO-EN-C-H.png", package="whomapper"))
}
