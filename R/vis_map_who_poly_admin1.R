#' function to read SHP files for WHO map
#' code by IZAWA, Yurie & LAURENSON-SCHAFER Henry, JINNAI, YUKA
#' @details function to create a map for selected countries with admin 1 colored by user-defied epi indicator
#' @return a map of selected country with admin 1 colored by user-defined epi indicator
#' @param country - country name
#' @param epi_indicator - selected epi indictaors in categorical variable
#' @param fill_pal - color of pallete   
#' @param logo_region - chose logo 
#' @param map_data   who_shp_1 <- whomapper::pull_who_adm1() and join with epi indicator data 
#' @example
#' map_myn<-vis_map_who_poly_admin1(country="Myanmar", epi_indicator=case_cat, ind_name="Weekly case incidnece \n per 100,000", map_dat=map_data)
#'
#' @export

vis_map_who_poly_admin1<-function(country, 
                                  epi_indicator, 
                                  ind_name, 
                                  fill_pal="Blues",
                                  logo_region="SEARO",
                                   map_dat) {

who_shp_0 <-whomapper::pull_who_adm0()

map_who_admi1<-ggplot() +
  geom_sf_who_poly(data = who_shp_0$adm0%>% filter(adm0_viz_n %in% country)) +
  geom_sf_who_poly(data = map_dat %>% filter(adm0_viz_n %in% country), col = who_map_col("border"), size = 0.1, aes(fill = .data[[epi_indicator]])) +
  scale_fill_brewer(palette= fill_pal,  
  na.value = who_map_col("no_data"),
  name = ind_name)+
  geom_text(data = map_dat,aes(x=center_lon, y=center_lat, label=adm1_viz_n),
              color = "Black",size=2, check_overlap = TRUE) +
  labs(title = country, subtitle = glue::glue("as of {format(Sys.Date(), '%d %b %y')}")) +
  who_map_theme_admin1()+
  who_map_annotate_admin1(region=logo_region)

return(map_who_admi1)

}

