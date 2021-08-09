#' theme for WHO maps
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details theme for WHO maps
#' @export


who_map_theme <- function() {
  list(
    coord_sf(expand = FALSE, clip = "off"),
    expand_limits(x = c(0, 0), y = c(-80, 100)),
    guides(fill = guide_legend(override.aes = list(col = "black"))),
    theme(
      # Background
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill ="#BEEBF5"),
      axis.text.x = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),

      # Margin around the map
      # plot.margin = unit(c(3,0,5,0), "lines"),

      # Title
      plot.title = element_text(color = who_map_col("title"), size = 16,
                                face = "bold", hjust = 0),
      plot.subtitle = element_text(color = who_map_col("title"), size = 13, hjust = 0),
      plot.caption = element_text(hjust = 0, size = 8),

      # Legend
      legend.position = "right",
      legend.title = element_text(size = 10, face = "bold"),
      legend.text = element_text(size = 10),
      legend.box = "vertical",
      legend.background = element_rect(fill = NA),
      legend.key.size = unit(0.5, 'cm')
    )
  )
}
