#' function to add disputed territories to WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry
#' @details function to add disputed territories to WHO map
#' @param sf list of shapefiles to be used
#' @param na_scale - should a new scale for not applicable be added?
#' @param no_data_scale - should a new scale for no data be added?
#' @export


who_map_disp <- function(sf = pull_who_adm0(), na_scale = TRUE, no_data_scale = TRUE) {

  disp_area <- sf$disp_area
  disp_border <- sf$disp_border

  vals_disp <- c()

  if (na_scale) {
    vals_disp <- append(vals_disp, c("Not applicable" = who_map_col("not_applicable")))
  }
  if (no_data_scale) {
    vals_disp <- append(vals_disp, c("No data" = who_map_col("no_data")))
  }

  if (length(vals_disp) > 0) {
    geoms_out <- list(
      ggnewscale::new_scale_fill(),
      scale_fill_manual(values = vals_disp,
                        name = NULL,
                        breaks = names(vals_disp),
                        drop = FALSE,
                        limits = names(vals_disp),
                        labels = names(vals_disp))
    )
  } else {
    geoms_out <- list()
  }



  geoms_out <- append(
    geoms_out,
    list(
      geom_sf(data = disp_area[disp_area$name == "Western Sahara",], aes(fill = "Not applicable"), color = NA),

      # Disputed areas
      # 1) Aksai Chin
      ggpattern::geom_sf_pattern(data = disp_area[disp_area$name == "Aksai Chin",],
                                 pattern = 'stripe',
                                 pattern_spacing = 0.0015,
                                 pattern_angle = 50,
                                 #pattern_density = 0.3, # Value from 0-1 (1 being very dense)
                                 pattern_colour = "#cccccc",
                                 pattern_fill = "#cccccc",
                                 pattern_size = 0.2,
                                 size = 0.2,
                                 color = NA,
                                 fill = NA),

      geom_sf(data = disp_area[disp_area$name == "Aksai Chin",],
              fill = NA, color = "#9c9c9c", size = 0.2),

      # 2) Jammu and Kashmir
      # Fill: grey 20%, Outline: same as ADM0 lines
      geom_sf(data = disp_area[disp_area$name == "Jammu and Kashmir",],
              fill = "#cccccc", color = "#9c9c9c", size = 0.2),

      geom_sf(data = disp_border[disp_border$name %in% c("J&K (IND Claim)", "J&K (PAK Claim)"),],
              color="#ECECEC", linetype = "dotted", size = 0.2),
      geom_sf(data = disp_border[disp_border$name =="J&K Line of Control",],
              color = "#9c9c9c", linetype = "dotted", size = 0.2),
      # 4) Sudan - South Sudan (Abyei)
      # Fill & outline: grey 20%
      geom_sf(data = disp_area[disp_area$name == "Abyei",], fill = "#cccccc", color = "#9c9c9c",
              size = 0.2),
      geom_sf(data = disp_border[disp_border$name == "Abyei (SSD Claim)",],
              color = "#ECECEC", linetype = "dotted", size = 0.2),
      geom_sf(data = disp_border[disp_border$name %in% c("Abyei (SDN Claim)", "Sudan-South Sudan"),],
              color = "#ECECEC", linetype = "dotted", size = 0.2),

      # 5) Arunachal Pradesh: same as ADM0 lines
      geom_sf(data = disp_border[disp_border$name =="Arunachal Pradesh",],
              color="#9c9c9c", size = 0.2),

      # 6) Egypt-Sudan
      geom_sf(data = disp_border[disp_border$name %in% c("Bir Tawil 1", "Halayib Triangle (EGY Claim)"),],
              color = "#9c9c9c", size = 0.2),
      geom_sf(data = disp_border[disp_border$name %in% c("Bir Tawil 2", "Halayib Triangle (SDN Claim)"),],
              color = "#ECECEC", linetype = "dotted", size = 0.2),

      # 7) South Sudan - Kenya
      geom_sf(data = disp_border[disp_border$name == "Ilemi Triangle",],
              color = "#9c9c9c", linetype = "dotted", size = 0.2),

      # 8) North - South Korea: grey 10%
      geom_sf(data = disp_border[disp_border$name == "Korean DMZ",],
              color = "#ECECEC", linetype = "dotted", size = 0.2),

      # 9) Kosovo
      geom_sf(data = disp_border[disp_border$name == "Kosovo",],
              color = "#9c9c9c", linetype = "dotted", size = 0.2),

      # 10) oPt: grey 10%
      geom_sf(data = disp_border[disp_border$name=="West Bank",],
              color = "#ECECEC", linetype = "dotted", size = 0.2),

      # Lakes
      geom_sf(data = disp_area[disp_area$name=="Lakes",], col = who_map_col("lakes"), fill = who_map_col("lakes"), size = 0.2),

      ggsn::scalebar(sf$adm0, dist = 1000, dist_unit = "km",
                     transform = TRUE, model = "WGS84", anchor = c("x" = 140, "y" = -60), st.size = 3)

    )
  )


  geoms_out
}
