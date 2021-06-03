#' function to add annotations to WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to add annotations to WHO map
#' @param region - user defined region for logo and disclaimer text
#' @param data_source - user defined data source
#' @export


who_map_annotate <- function(region = "HQ", data_source) {

  # 2. Data source (modify accordingly)

  if (missing(data_source)) {
    data_source <- glue::glue("Data Source: World Health Organization
                              Map Production: WHO Health Emergencies Programme
                              \u00A9 WHO {format(Sys.Date(), '%Y')}. All rights reserved.")
  }


  logo <-  pull_who_logo(region)

  # 4. Disclaimer
  text_disc <-
    glue::glue("The designations employed and the presentation of the material in this publication do not imply the expression of any opinion whatsoever on the part of WHO
               concerning the legal status of any country, territory, city or area or of its authorities, or concerning the delimitation of its frontiers or boundaries.
               Dotted and dashed lines on maps represent approximate border lines for which there may not yet be full agreement.")

  y_logo <- case_when(
    grepl("hq|global", region, ignore.case = T) ~ "WHO_logo.png",
    grepl("^sea", region, ignore.case = T) ~ "SEARO_logo.png",
    TRUE ~ NA_character_
  )

  if (grepl("hq|global", region, ignore.case = T)) {
    logo_y <- 1.06
    logo_x <- 0.91
    logo_width <- 0.18
  } else if (grepl("^sea", region, ignore.case = T)) {
    logo_y <- 1.07
    logo_x <- 0.92
    logo_width <- 0.16
  }

  list(
    annotation_custom(grobTree(rasterGrob(
      logo, x = unit(logo_x, "npc"), y = unit(logo_y,"npc"), width = logo_width)
    )),
    # annotation_custom(rasterGrob(logo), xmin = 125, xmax = 175, ymin = 70, ymax = 100),
    labs(caption = glue::glue("{text_disc}\n\n{data_source}"))
  )

}


