#' function to add annotations to WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to add annotations to WHO map
#' @param region - user defined region for logo and disclaimer text
#' @param data_source - user defined data source
#' @param production_team - for the caption, define the team that produced the map.
#' Defaults to _WHO Health Emergencies Programme_
#' @param logo_location - user defined logo location - one of c("topright", "bottomright", "topleft", "bottomleft")
#' @param logo_outside_panel - should the logo sit outside the panel? TRUE or FALSE
#' @export


who_map_annotate <- function(region = "HQ",
                             data_source = "World Health Organization",
                             production_team = "WHO Health Emergencies Programme",
                             logo_location = c("topright", "bottomright", "topleft", "bottomleft"),
                             logo_outside_panel = TRUE) {

  # 2. Data source (modify accordingly)

  data_source_out <- glue::glue("Data Source: {data_source}
                              Map Production: {production_team}
                              \u00A9 WHO {format(Sys.Date(), '%Y')}. All rights reserved.")

  logo <-  pull_who_logo(region)

  # 4. Disclaimer
  text_disc <-
    glue::glue("The designations employed and the presentation of the material in this publication do not imply the expression of any opinion whatsoever on the part of WHO
               concerning the legal status of any country, territory, city or area or of its authorities, or concerning the delimitation of its frontiers or boundaries.
               Dotted and dashed lines on maps represent approximate border lines for which there may not yet be full agreement.")


  lc <- logo_coords(location = logo_location, outside_panel = logo_outside_panel)

  list(
    labs(caption = glue::glue("{text_disc}\n\n{data_source_out}")),
    patchwork::inset_element(grid::rasterGrob(logo),
                             left = lc[["l"]],
                             bottom = lc[["b"]],
                             right = lc[["r"]],
                             top = lc[["t"]],
                             align_to = 'panel') +
      theme(rect  = element_rect(fill = "transparent", linetype = "blank"))
    )

}


