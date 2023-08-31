#' function to add annotations to WHO map
#' @details function to determine coordinates for WHO logo based on predefined location
#' @param location - user defined location - one of c("topright", "bottomright", "topleft", "bottomleft")
#' @param outside_panel - should the logo sit outside the panel? TRUE or FALSE


logo_coords <- function(location = c("topright", "bottomright", "topleft", "bottomleft"),
                        outside_panel = TRUE) {

  location <- match.arg(location)

  x_coords <- dplyr::case_when(
    grepl("right$", location) ~ c(0.85, 1),
    grepl("left$", location) ~ c(0, 0.15)
  ) %>%
    purrr::set_names("l", "r")

  y_coords <- dplyr::case_when(
    outside_panel & grepl("^top", location) ~ c(1, 1.1),
    !outside_panel & grepl("^top", location) ~ c(0.9, 1),
    outside_panel & grepl("^bottom", location) ~ c(-0.1, 0),
    !outside_panel & grepl("^bottom", location) ~ c(0, 0.1),
  ) %>%
    purrr::set_names("b", "t")

  return(c(x_coords, y_coords))

}
