# whomapper

Authors: Yurie Izawa & Henry Laurenson-Schafer

## Preamble

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

This package has been set up to allow for flexible use of `ggplot2` for mapping. It's highly recommended that the `tidyverse` is installed before using this package to manipulate maps. The basic workflow for using this package is:

1. Read in shapefiles (packaged with `whomapper`)
2. Merge data of interest with the `adm0` list element of the shapefiles (the polygons)
3. Begin a standard ggplot:
    1.Plot shapefiles with `geom_sf_who_poly()`
    2.Define legend aesthetics with `scale_...()`
    3.Define labels for the plot
4. call `who_map_pipeline()` to define disputed areas, theme, legal text etc.
5. Save the plot using `who_map_save()` - This ensures that dimensions are correct. 


Some basic tips for using this package are:

1. Use the `geom_sf_who_poly()` custom geom to plot shapefile **polygons** with default settings (i.e. no border)
2. Legend aesthetics can be controlled as normal with ggplot - here this should be done before calling `who_map_pipeline()` (as in the below examples).
3. The caption, x-axis, and y-axis labels cannot be defined - only the title and subtitle are available.
4. Use `who_map_col()` to define some colours that must be explicit. For example, where there is no data, use `who_map_col("no_data")`

Note that this package can be used to plot maps with continuous, binned, and categorical data. Some examples are shown below.

Be sure to check out our sister app [phifunc](https://github.com/whocov/phifunc) to run this code!

### Plotting categorical data:

```
library(whomapper)
library(tidyverse)
library(glue)

sfs <- pull_who_adm0()

ggplot() +
  geom_sf_who_poly(data = sfs$adm0, aes(fill = who_region)) +
  scale_fill_brewer(palette = "Set3", 
                    na.value = who_map_col("no_data"),
                    name = "WHO Region") +
  labs(title ="World map by WHO region", 
       subtitle = glue::glue("as of {format(Sys.Date(), '%d %b %y')}")) +
  who_map_pipeline() 

who_map_save(glue::glue("who_region_map.png"), dpi = 700)

```

### Plotting binned data

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
  geom_sf_who_poly(data = cases_sf, aes(fill = case_total / population * 1e5)) +
  scale_fill_fermenter(trans = "pseudo_log",
                       name = "cases/100K pop", 
                       palette = "YlOrRd", 
                       breaks = c(50, 500, 5e3),
                       direction = 1, na.value = who_map_col("no_data")) +
  labs(title ="COVID-19 cases per 100k", subtitle = glue::glue("as of {format(Sys.Date(), '%d %b %y')}")) +
  who_map_pipeline() 


who_map_save(glue::glue("cases_per_100k_{Sys.Date()}.png"))


```

This code produces these plots:
![who_region_map](https://user-images.githubusercontent.com/38218241/120607542-90298500-c450-11eb-919f-9b255a946bd8.png)


![cases_per_100k_2021-06-03](https://user-images.githubusercontent.com/38218241/120607578-991a5680-c450-11eb-8bf1-6428a5f3c967.png)

