
# EMODnetBiologyMaps

<!-- badges: start -->
[![R build
status](https://github.com/EMODnet/EMODnetBiologyMaps/workflows/R-CMD-check/badge.svg)](https://github.com/EMODnet/EMODnetBiologyMaps/actions)
<!-- badges: end -->

The goal of EMODnetBiologyMaps is to create ggplot2 maps of using the EMODnet style:

* Colors follow the EMODnet guidelines
* The default projection is [EPGS:3035](https://epsg.io/3035): ETRS89-extended / LAEA Europe
* When the map is saved as .png, the EMODnet logo is pasted in the final map.

## Installation

You can install the development version of EMODnetBiologyMaps with:

``` r
devtools::install_github("EMODnet/EMODnetBiologyMaps")
```

## Example

1. Export a gridded abundance map of anchovies ([*Engraulis encrasicolus*](https://www.marinespecies.org/aphia.php?p=taxdetails&id=126426)):

``` r
# devtools::install_github("lifewatch/eurobis")
library(EMODnetBiologyMaps)
library(eurobis)

# Retrieve grid data for "Eriocheir sinensis" (AphiaID = 126426) using the eurobis package
points <- getEurobisGrid(aphiaid = 126426, gridsize = '1d')

# Render ggplot2 map
map <- emodnet_map_plot(points, fill = points$RecordCount,  title = "Engraulis encrasicolus", subtitle = "AphiaID 126426", legend = "Abundance", zoom = FALSE, option = "viridis")

# Save with EMODnet logo
emodnet_map_logo(map, path = "./data-raw/map1.png", width = 198, height = 121, dpi = 300, units = "mm", gravity = "northeast", offset = "+650+200", color = TRUE)


```

<img src=".\data-raw\map1.png" alt="map1" />
