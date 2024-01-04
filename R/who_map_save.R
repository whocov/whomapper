#' wrapper function around ggsave to save map in correct dimensions
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details wrapper function around ggsave to save map in correct dimensions
#' @param name the name of the plot to be saved
#' @param plot the plot object to be saved. defaults to ggplot2::last_plot()
#' @param width width of the plot. Defaults to 11.8in for world maps
#' @param height height of the plot. Defaults to 7.2in for world maps
#' @export


who_map_save <- function(name, plot = ggplot2::last_plot(), width = 11.8, height = 7.2, dpi = 250, ...) {

  ggsave(name, plot, width = width, height = height, dpi = dpi, ...)

}
