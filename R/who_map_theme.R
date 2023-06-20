#' theme for WHO maps
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details theme for WHO maps
#' @param xlim - the coordinate limits of the x axis
#' @param ylim - the coordinate limits of the y axis

#' @export


who_map_theme <- function(xlim = NULL, ylim = NULL) {

  x_exp <- if (!is.null(xlim)) NULL else c(0, 0)
  y_exp <- if (!is.null(ylim)) NULL else c(-80, 100)

  list(
    coord_sf(expand = FALSE, clip = "on", xlim = xlim, ylim = ylim),
    expand_limits(x = x_exp, y = y_exp),
    guides(fill = guide_legend(override.aes = list(col = "black"))),
    theme(
      # Background
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill ="#E6E7E8"),
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
