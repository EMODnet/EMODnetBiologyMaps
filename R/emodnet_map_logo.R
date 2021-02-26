#' Add the EMODnet logo to your ggplot
#'
#' @param plot ggplot
#' @param path character
#' @param gravity character
#' @param offset character
#' @param color boolean
#' @param ... params to be passed to ggplot2::ggsave()
#'
#' @return png
#' @export
#'
#' @examples
#' aphiaid <- 107451
#' specname <- "Eriocheir sinensis"
#' Esgrid <- sf::st_read(paste0("http://geo.vliz.be/geoserver/wfs/ows?", "service=WFS&version=1.3.0&",
#' "request=GetFeature&", "typeName=Dataportal%3Aeurobis_grid_1d",
#' "-obisenv&", "viewParams=aphiaid%3A", aphiaid, "&", "outputFormat=json", "&maxFeatures=10"))
#' plot <- emodnet_map_plot(Esgrid, fill = Esgrid$RecordCount,  title = specname,
#' subtitle = paste("Aphiaid =",aphiaid), legend = "Abundance",plot_polygon_border=TRUE)
#' emodnet_map_logo(plot, path = paste0(tempfile(), ".png"),
#' width = 198, height = 121, dpi = 300, units = "mm")
emodnet_map_logo <- function(plot, path = NULL, gravity = "northeast", offset = "+0+0", color = TRUE, ...){
  plot
  # Map
  temppath <- paste0(tempfile(), ".png")
  ggplot2::ggsave(filename = temppath, ...)
  plot <- magick::image_read(temppath)

  # Logo
  if(color){
    logo <- "logo_col_no_bg.png"
  }else if(color == FALSE){
    logo <- "logo_bw_no_bg.png"
  }else(stop("Argument color is not boolean"))

  logo <- system.file("extdata", logo, package = "EMODnetBiologyMaps", mustWork = TRUE)
  logo <- magick::image_read(logo)
  logo <- magick::image_scale(logo, "200")

  # Combine
  plot_logo <- magick::image_composite(plot, logo, gravity = gravity, offset = offset)

  # Save
  magick::image_write(plot_logo, path)

}
