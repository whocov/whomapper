#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details helper function to convert label names
#' @param x - a label name
#' @export

whp_map_legend_labs <- function(x) {
  replace_na(x, "No data")
}
