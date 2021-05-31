#' function to add annotations to WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to add annotations to WHO map
#' @param data_source - user defined data source
#' @export


who_map_annotate <- function(data_source) {

  # 2. Data source (modify accordingly)

  if (missing(data_source)) {
    data_source <- glue::glue("Data Source: World Health Organization,
                              Map Production: WHO Health Emergencies Programme
                              \u00A9 WHO 2020. All rights reserved.")
  }


  logo <-  pull_who_logo()

  # 4. Disclaimer
  text_disc <- glue::glue("The designations employed and the presentation of the material in this publication do not imply the expression of any opinion whatsoever on the part of WHO concerning the legal status of any country, territory, city or area
                          or of its authorities, or concerning the delimitation of its frontiers or boundaries. Dotted and dashed lines on maps represent approximate border lines for which there may not yet be full agreement.[1] All references to Kosovo
                          in this document should be understood to be in the context of the United Nations Security Council resolution 1244 (1999). Data for Serbia and Kosovo (UNSCR 1244, 1999) have been aggregated for visualization purposes.")

  # list(
  #   annotation_custom(rasterGrob(logo), xmin = 150, xmax = 180, ymin = 70, ymax = 100),
  #   annotate("text", x = -60, y = -70, label = text_disc, size = 3, hjust = 0),
  #   annotate("text", x = -40, y = -80, label = data_source, size = 3, hjust = 0)
  # )

  list(
    annotation_custom(rasterGrob(logo), xmin = 125, xmax = 175, ymin = 70, ymax = 100),
    labs(caption = glue::glue("{text_disc}\n\n{data_source}"))
  )

}


