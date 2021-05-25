# whomapper

Authors: Yurie Izawa & Henry Laurenson-Schafer

This is an experiemental package to house WHO shapefiles and create WHO legal maps. *Please note that the user of this package is responsible for ensuring that any maps they produce fuffil WHO legal standards.*

To install this package for the first time: 

```
devtools::install_github("whocov/whomapper", auth_token = "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", force = TRUE, dependencies = TRUE)
```

The user can read all who admin0 shapefiles using the following command:

```
# read shp files
who_shp <- whomapper::pull_who_adm0()
```

Please note that no shapefiles beyond Admin 0 are currently packaged - this may be added as a feature if there is demand in the future. 
