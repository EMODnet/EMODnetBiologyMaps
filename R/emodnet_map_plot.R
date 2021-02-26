#' Plot your spatial data following the EMODnet style
#'
#' @param data sf, RasterLayer, "SpatialPolygonsDataFrame", "SpatialPointsDataFrame", "SpatialLinesDataFrame"
#' @param fill vector
#' @param title character
#' @param subtitle character
#' @param legend character
#' @param crs integer
#' @param xlim vector
#' @param ylim vector
#' @param direction integer
#' @param option character
#' @param zoom boolean
#' @param plot_polygon_border boolean
#' @param ... params to be passed to emodnet_map_basic
#'
#' @return ggplot
#' @export
#'
#' @examples
#' aphiaid <- 107451
#' specname <- "Eriocheir sinensis"
#' Esgrid <- sf::st_read(paste0("http://geo.vliz.be/geoserver/wfs/ows?", "service=WFS&version=1.3.0&",
#' "request=GetFeature&", "typeName=Dataportal%3Aeurobis_grid_1d",
#' "-obisenv&", "viewParams=aphiaid%3A", aphiaid, "&", "outputFormat=json", "&maxFeatures=10"))
#' emodnet_map_plot(Esgrid, fill = Esgrid$RecordCount,  title = specname,
#' subtitle = paste("Aphiaid =",aphiaid), legend = "Abundance",plot_polygon_border=TRUE)
emodnet_map_plot <- function(data, fill = NULL, title = NULL, subtitle = NULL, legend = NULL,
                             crs = 3035, xlim = c(2426378.0132, 7093974.6215),
                             ylim = c(1308101.2618, 5446513.5222), direction = 1,
                             option = "viridis", zoom = FALSE,plot_polygon_border=TRUE, ...){
  # Quality check
  stopifnot(class(data)[1] %in% c("sf", "RasterLayer", "SpatialPolygonsDataFrame", "SpatialPointsDataFrame", "SpatialLinesDataFrame"))

  # Basic map
  emodnet_map_basic <- emodnet_map_basic(...) + ggplot2::ggtitle(label = title, subtitle = subtitle)

  # Logic
  # If data is raster
  if(class(data)[1] == "RasterLayer"){
    message("Transforming RasterLayer to sf vector data")
    data <- sf::st_as_sf(raster::rasterToPolygons(data))
    fill <- sf::st_drop_geometry(data)[, 1]
  }

  # If data is sp
  if(class(data)[1] %in% c("SpatialPolygonsDataFrame", "SpatialPointsDataFrame", "SpatialLinesDataFrame")){
    message("Transforming sp to sf")
    data <- sf::st_as_sf(data)
  }

  # if data are sf points
  if(sf::st_geometry_type(data, FALSE) == "POINT"){
    emodnet_map_plot <- emodnet_map_basic +
      ggplot2::geom_sf(data = data,
                       color = emodnet_colors()$yellow)
  }

  # if data are sf polygons
  if(sf::st_geometry_type(data, FALSE) == "POLYGON"){
    if(plot_polygon_border){
      emodnet_map_plot <- emodnet_map_basic +
        ggplot2::geom_sf(data = data, ggplot2::aes(fill = fill), size = 0.05) +
        ggplot2::scale_fill_viridis_c(alpha = 0.8, name = legend, direction = direction, option = option)
    }else{
      emodnet_map_plot <- emodnet_map_basic +
        ggplot2::geom_sf(data = data, ggplot2::aes(fill = fill), size = 0.05,color=NA) +
        ggplot2::scale_fill_viridis_c(alpha = 0.8, name = legend, direction = direction, option = option)
    }
  }

  # Projection and zoom
  if(zoom == TRUE){
    bbox <- sf::st_bbox(sf::st_transform(data, crs))
    xlim <- c(bbox$xmin, bbox$xmax)
    ylim <- c(bbox$ymin, bbox$ymax)
  }

  emodnet_map_plot <- emodnet_map_plot + ggplot2::coord_sf(crs = crs, xlim = xlim, ylim = ylim)

  # End
  return(emodnet_map_plot)

}

