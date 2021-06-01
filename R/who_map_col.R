#' function to get default who map colours
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to get default who map colours
#' @param x which colour index should be used
#' @param new_scale - should a new scale be added?
#' @export


who_map_col <- function(x = "no_data") {

  case_when(x == "no_data" ~ "#f0f0f0",
            x == "not_applicable" ~ "#cccccc",
            x == "background" ~ "#EBEBEB",
            x == "lakes" ~ "#BEE8FF",
            x == "border" ~ "#9c9c9c")


}
