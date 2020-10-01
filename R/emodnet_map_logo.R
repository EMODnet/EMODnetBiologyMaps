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
#' data <- eurobis::getEurobisGrid(aphiaid = 107451, gridsize = '30m')
#' plot <- emodnet_map_plot(data, fill = data$RecordCount,
#' title = "Eriocheir sinensis", subtitle = "107451", legend = "Abundance")
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
