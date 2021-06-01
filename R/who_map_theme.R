#' theme for WHO maps
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details theme for WHO maps
#' @export


who_map_theme <- function() {
  list(
    coord_sf(expand = FALSE),
    expand_limits(x = c(0, 0), y = c(-90, 100)),
    guides(fill = guide_legend(override.aes = list(col = "black"))),
    theme(
      # Background
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),

      # Margin around the map
      # plot.margin = unit(c(3,0,5,0), "lines"),

      # Title
      plot.title = element_text(color = "#0093D5", size = 16,
                                face = "bold", hjust = 0),
      plot.caption = element_text(hjust = 0, size = 8),

      # Legend
      legend.position = c(0.16, 0.13),
      legend.title = element_text(size = 10, face = "bold"),
      legend.text = element_text(size = 10),
      legend.box = "horizontal",
      legend.background = element_rect(fill = "#EBEBEB"),
      legend.key.size = unit(0.5, 'cm')
    )
  )
}
