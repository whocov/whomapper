#' function to read the WHO logo for mapping puroses
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read the WHO logo for mapping puroses
#' @param region - which regional logo should be taken - defaults to HQ
#' @return a PNG of the WHO logo
#' @export


pull_who_logo <- function(region = "HQ") {

  filename <- case_when(
    grepl("hq|global", region, ignore.case = T) ~ "WHO_logo.png",
    grepl("^sea", region, ignore.case = T) ~ "SEARO_logo.png",
    TRUE ~ NA_character_
  )

  if (!is.na(filename)) {
    png::readPNG(system.file("extdata", filename, package="whomapper"))
  } else {
    NULL
  }

}
