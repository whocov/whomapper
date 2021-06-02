#' wrapper function around ggsave to save map in correct dimensions
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details wrapper function around ggsave to save map in correct dimensions
#' @param name the name of the plot to be saved
#' @param plot the plot object to be saved. defaults to ggplot2::last_plot()
#' @export


who_map_save <- function(name, plot = ggplot2::last_plot(), dpi = 700, ...) {

  ggsave(name, plot, width = 300, height = 183, units = "mm", dpi = dpi, ...)

}
