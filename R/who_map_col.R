#' function to get default who map colours
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to get default who map colours
#' @param x which colour index should be used
#' @param new_scale - should a new scale be added?
#' @export


who_map_col <- function(x = c("no_data", "not_applicable", "background", "lakes", "border", "title", "adm0_mask")) {

  x <- match.arg(x)

  case_when(x == "no_data" ~ "#FFFFFF",
            x == "not_applicable" ~ "#cccccc",
            x == "background" ~ "#E6E7E8",
            x == "lakes" ~ "#E6E7E8",
            x == "border" ~ "#9c9c9c",
            x == "title" ~ "#0093D5",
            x == "adm0_mask" ~ "#808080")


}
