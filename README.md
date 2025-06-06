# whomapper

Authors: Yurie Izawa & Henry Laurenson-Schafer

## Preamble

This is an experiemental package to house WHO shapefiles and create WHO legal maps. ***Please note that the user of this package is responsible for ensuring that any maps they produce fuffil WHO legal standards.*** Please read the WHO map SOP before using [here](http://gamapserver.who.int/gho/gis/training/DMF_GIS2010_2_SOPSforWHOMaps.pdf).

***AS OF 5th September 2023, this package has undergone extensive rewrites. For up to date information run the vignette***

## Installation

To install this package for the first time (note that a users PAT can be used): 

```
devtools::install_github("whocov/whomapper", 
                          force = TRUE, 
                          dependencies = TRUE)
```
## Reading shapefiles

The user can now read all WHO Admin 0, 1, 2, or 3 shapefiles using the following function. Admin 0 and 1 are prepackaged (although may be out of date), and do not require an internet connection to read. For up to date shapefiles, please query the WHO servers.

```
library(whomapper)

# read shp files using prepackaged files
who_adm0 <- whomapper::pull_sfs(adm_level = 0, query_server = FALSE)

# read shp files for all admin 1 regions of France by querying server
fra_adm1 <- whomapper::pull_sfs(adm_level = 1, iso3 = "FRA", query_server = TRUE)

```

Note that adm0 shapefiles are packages alongside disputed regions and borders, and a custom border layer that does not include coastlines. This is used to make cleaner maps where only land borders are shown with lines.

## Making maps

This package has been set up to allow for flexible use of `ggplot2` for mapping and is designed to be used generally with the tidyverse family of packages. The basic workflow for using this package is:

1. Read in shapefiles (packaged with `whomapper`)
2. Merge data of interest with the `adm0` list element of the shapefiles (the polygons)
3. Begin a standard ggplot:
    1. Plot shapefiles with `geom_sf_who_poly()`
    2. Define legend aesthetics with `scale_...()`
    3. Define labels for the plot
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
library(ggplot2)

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

## we use WHO vaccine data to visualise on a map
vaccine_data <- whomapper:::vaccine_data

## join the vaccine data to the country boundary sf object
vaccine_sf <- left_join(
  sfs$adm0,
  vaccine_data %>% select(-report_country, -who_region),
  by = c("iso_3_code" = "iso3")
) %>%
  mutate(persons_fully_vaccinated_per100 =
           ifelse(persons_fully_vaccinated_per100 > 100, 100, persons_fully_vaccinated_per100))

## plot
ggplot() +
  geom_sf_who_poly(data = vaccine_sf, aes(fill = persons_fully_vaccinated_per100)) +
  scale_fill_fermenter(name = "Fully vaccinated per 100",
                       palette = "RdYlGn", limits = c(0, 100),
                       direction = 1, na.value = who_map_col("no_data")) +
  labs(title ="Persons fully vaccined per 100, COVID-19",
       subtitle = str_glue("as of {format(max(vaccine_sf$date_updated, na.rm = TRUE), '%d %B %y')}")) +
  who_map_pipeline(sf = sfs)

who_map_save(glue::glue("who_covid_vaccine_map.png"), dpi = 700)


```

This code produces these plots:
![who_region_map](https://user-images.githubusercontent.com/38218241/120607542-90298500-c450-11eb-919f-9b255a946bd8.png)


![covid_vaccine](https://github.com/user-attachments/assets/983da949-9f14-46fb-996d-fd9792f7d5aa)

