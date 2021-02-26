test_that("Data points and grid polygons from EMODnet Biology can be plot", {
 skip_on_cran()
 skip_on_travis()
 aphiaid <- 107451
 specname <- "Eriocheir sinensis"
 Esgrid <- sf::st_read(paste0("http://geo.vliz.be/geoserver/wfs/ows?", "service=WFS&version=1.3.0&",
   "request=GetFeature&", "typeName=Dataportal%3Aeurobis_grid_1d",
   "-obisenv&", "viewParams=aphiaid%3A", aphiaid, "&", "outputFormat=json", "&maxFeatures=10"))
 map <- emodnet_map_plot(Esgrid, fill = Esgrid$RecordCount,  title = specname,
  subtitle = paste("Aphiaid =",aphiaid), legend = "Abundance",plot_polygon_border=TRUE)
expect_identical(class(map), c("gg", "ggplot"))
})
