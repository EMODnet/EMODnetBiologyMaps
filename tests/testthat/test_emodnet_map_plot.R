test_that("Data points and grid polygons from EMODnet Biology can be plot", {
 skip_on_cran()
 skip_on_travis()
  points <- eurobis::getEurobisGrid(aphiaid = 107451, gridsize = '30m')
  map <- emodnet_map_plot(points, fill = points$RecordCount,  title = "Eriocheir sinensis", subtitle = "107451", legend = "Abundance")
  expect_identical(class(map), c("gg", "ggplot"))
})
