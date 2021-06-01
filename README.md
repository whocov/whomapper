# whomapper

Authors: Yurie Izawa & Henry Laurenson-Schafer

This is an experiemental package to house WHO shapefiles and create WHO legal maps. ***Please note that the user of this package is responsible for ensuring that any maps they produce fuffil WHO legal standards.*** Please read the WHO map SOP before using [here](http://gamapserver.who.int/gho/gis/training/DMF_GIS2010_2_SOPSforWHOMaps.pdf).

***THIS APP IS CURRENTLY IN EARLY DEVELOPMENT - PLEASE LOG A GITHUB ISSUE OR CONTACT THE AUTHORS FOR ANY ISSUES***

## Installation

To install this package for the first time: 

```
devtools::install_github("whocov/whomapper", 
                          auth_token = "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", 
                          force = TRUE, 
                          dependencies = TRUE)
```
## Reading shapefiles

The user can read all who admin0 shapefiles using the following command. These are prepackaged, and do not require an internet connection to read:

```
library(whomapper)

# read shp files
who_shp <- whomapper::pull_who_adm0()
```

Please note that no shapefiles beyond Admin 0 are currently packaged - this may be added as a feature if there is demand in the future.

## Making maps

This package has been set up to allow for flexible use of `ggplot2` for mapping. It's highly recommended that the `tidyverse` is installed before using this package to manipulate maps. The easiest way to use this package is:

1. Add `who_map_pipeline()` AFTER the setting up the initial ggplot (to add disputed areas, annotations, theme, etc)
2. Use `who_map_col()` to define some colours that must be explicit. For example, where there is no data, use `who_map_col("no_data")`
3. Save the plot using `who_map_save()` - This ensures that dimensions are correct. 

Be sure to check out our sister app [phifunc](https://github.com/whocov/phifunc) to run this code!

```
library(whomapper)
library(phifunc)
library(tidyverse)
library(glue)

case_death <- pull_phi_data() %>% normalise_date()

cd_latest <- case_death %>% 
  group_by(iso3) %>% 
  filter(report_date == max(report_date)) %>% 
  ungroup()

sfs <- pull_who_adm0()

cases_sf <- left_join(
  sfs$adm0,
  cd_latest,
  by = c("iso_3_code" = "iso3")
)

ggplot() +
  geom_sf(data = cases_sf, aes(fill = case_total / population * 1e5)) +
  scale_fill_fermenter(trans = "pseudo_log",
                       name = "cases/100K pop", 
                       palette = "YlOrRd", 
                       breaks = c(50, 500, 5e3),
                       direction = 1, na.value = who_map_col("no_data")) +
  labs(title ="COVID-19 cases per 100k", subtitle = glue::glue("as of {format(Sys.Date(), '%d %b %y')}")) +
  who_map_pipeline()

who_map_save(glue::glue("cases_per_100k_{Sys.Date()}.png"))


```

This code produces this plot:

![cases_per_100k_2021-06-01](https://user-images.githubusercontent.com/38218241/120302092-d1ddf280-c2cd-11eb-885f-5e6ead88cc6f.png)
