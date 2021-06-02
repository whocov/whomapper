#' wrapper function over geom_sf with new defaults for no borders shown
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details wrapper function to add all components to who map
#' @param mapping - passed down to mapping in geom_sf()
#' @param data - passed down to data in geom_sf()
#' @param col - passed down to col in geom_sf()

#' @export


geom_sf_who_poly <- function(mapping = aes(),
                             data = NULL,
                             ...,
                             col = NA) {

  geom_sf(mapping = mapping, data = data, col = col, ...)

}

