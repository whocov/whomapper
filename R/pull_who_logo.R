#' function to read the WHO logo for mapping puroses
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to read the WHO logo for mapping puroses
#' @param region - which regional logo should be taken - defaults to HQ
#' @return a PNG of the WHO logo
#' @export


pull_who_logo <- function(region = "HQ") {

  filename <- case_when(
    # Logos downloaded from the WHO brand portal: https://who.canto.global/v/P1HJAOLE6L/folder/OD2AP?display=list&viewIndex=0&referenceTo=&from=list
    grepl("hq|global", region, ignore.case = T) ~ "WHO_logo.png",
    grepl("^sea", region, ignore.case = T) ~ "SEARO_logo.png",
    grepl("^eur", region, ignore.case = T) ~ "EURO_logo.png",
    grepl("^wpr", region, ignore.case = T) ~ "WPRO_logo.png",
    grepl("^afr", region, ignore.case = T) ~ "AFRO_logo.png",
    grepl("^pah|^amr", region, ignore.case = T) ~ "AMRO_logo.png",
    grepl("^emr", region, ignore.case = T) ~ "EMRO_logo.png",
    TRUE ~ NA_character_
  )

  if (!is.na(filename)) {
    png::readPNG(system.file("extdata", filename, package="whomapper"))
  } else {
    NULL
  }

}
