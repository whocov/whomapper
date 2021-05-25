#' function to add disputed territories to WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to add disputed territories to WHO map
#' @param sf list of shapefiles to be used
#' @param new_scale - should a new scale be added?
#' @export


who_map_disp <- function(sf = pull_who_adm0(), add_na_scale = TRUE) {

  disp_area <- sf$disp_area
  disp_border <- sf$disp_border

  geoms_out <- geom_sf(data = disp_area[disp_area$name == "Western Sahara",], aes(fill = "#cccccc"), color = NA) +

    # Disputed areas
    # 1) Aksai Chin
    ggpattern::geom_sf_pattern(data = disp_area[disp_area$name=="Aksai Chin",],
                               pattern = 'stripe',
                               pattern_spacing = 0.0015,
                               pattern_angle = 50,
                               #pattern_density = 0.3, # Value from 0-1 (1 being very dense)
                               pattern_colour = "#cccccc",
                               pattern_fill = "#cccccc",
                               pattern_size = 0.4,
                               size = 0.5,
                               color = NA,
                               fill = NA) +

    geom_sf(data = disp_area[disp_area$name == "Aksai Chin",],
            fill = NA, color = "#9c9c9c") +

    # 2) Jammu and Kashmir
    # Fill: grey 20%, Outline: same as ADM0 lines
    geom_sf(data = disp_area[disp_area$name == "Jammu and Kashmir",],
            fill = "#cccccc", color = "#9c9c9c") +
    geom_sf(data = disp_border[disp_border$name %in% c("J&K (IND Claim)", "J&K (PAK Claim)"),],
            color="#ECECEC", linetype = "dotted") +
    geom_sf(data = disp_border[disp_border$name =="J&K Line of Control",],
            color = "#9c9c9c", linetype = "dotted") +

    # 4) Sudan - South Sudan (Abyei)
    # Fill & outline: grey 20%
    geom_sf(data = disp_area[disp_area$name == "Abyei",], fill = "#cccccc", color = "#9c9c9c") +
    geom_sf(data = disp_border[disp_border$name == "Abyei (SSD Claim)",],
            color = "#ECECEC", linetype = "dotted") +
    geom_sf(data = disp_border[disp_border$name %in% c("Abyei (SDN Claim)", "Sudan-South Sudan"),],
            color = "#ECECEC", linetype = "dotted") +

    # 5) Arunachal Pradesh: same as ADM0 lines
    geom_sf(data = disp_border[disp_border$name =="Arunachal Pradesh",],
            color="#9c9c9c", size=0.5) +

    # 6) Egypt-Sudan
    geom_sf(data = disp_border[disp_border$name %in% c("Bir Tawil 1", "Halayib Triangle (EGY Claim)"),],
            color = "#9c9c9c", size = 0.5) +
    geom_sf(data = disp_border[disp_border$name %in% c("Bir Tawil 2", "Halayib Triangle (SDN Claim)"),],
            color = "#ECECEC", linetype = "dotted") +

    # 7) South Sudan - Kenya
    geom_sf(data = disp_border[disp_border$name == "Ilemi Triangle",],
            color = "#9c9c9c", linetype = "dotted") +

    # 8) North - South Korea: grey 10%
    geom_sf(data = disp_border[disp_border$name == "Korean DMZ",],
            color = "#ECECEC", linetype = "dotted") +

    # 9) Kosovo
    geom_sf(data = disp_border[disp_border$name == "Kosovo",],
            color = "#9c9c9c", linetype = "dotted") +

    # 10) oPt: grey 10%
    geom_sf(data = disp_border[disp_border$name=="West Bank",],
            color = "#ECECEC", linetype = "dotted") +

    # Lakes
    geom_sf(data = disp_area[disp_area$name=="Lakes",], color = "#BEE8FF", fill = "#BEE8FF")

  if (add_na_scale) {
    geoms_out <- geoms_out +
      ggnewscale::new_scale_fill() +
      scale_fill_manual(values="#cccccc",
                        name = NULL,
                        labels = "Not applicable")

  }

  geoms_out
}
