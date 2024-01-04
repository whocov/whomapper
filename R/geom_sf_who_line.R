#' wrapper function over geom_sf with defaults for showing adm0 country lines
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details wrapper function to add all components to who map
#' @param mapping - passed down to mapping in geom_sf()
#' @param data - passed down to data in geom_sf()
#' @param col - passed down to col in geom_sf()
#' @param size - passed down to size in geom_sf()

#' @export


geom_sf_who_line <- function(mapping = aes(),
                             data = NULL,
                             col = who_map_col("border"),
                             size = 0.1,
                             ...) {

  geom_sf(mapping = mapping, data = data, col = col, size = size, ...)


}
