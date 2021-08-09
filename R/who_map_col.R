#' function to get default who map colours
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to get default who map colours
#' @param x which colour index should be used
#' @param new_scale - should a new scale be added?
#' @export


who_map_col <- function(x = "no_data") {

  case_when(x == "no_data" ~ "#FFFFFF",
            x == "not_applicable" ~ "#cccccc",
            x == "background" ~ "#BEEBF5",
            x == "lakes" ~ "#BEEBF5",
            x == "border" ~ "#9c9c9c",
            x == "title" ~ "#0093D5",
            x == "adm0_mask" ~ "#808080")


}
