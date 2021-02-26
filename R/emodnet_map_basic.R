#' Creates a ggplot map using EMODnet colors
#'
#' @param seaColor character HEX code color
#' @param landColor character HEX code color
#' @param crs integer or characnter. EPGS code or projection linestring
#' @param xlim vector with minimum and maximum longitude
#' @param ylim vector with minimum and maximum latitude
#'
#' @return basic ggplot2 map
#' @export
#'
#' @examples
#' emodnet_map_basic()
#' emodnet_map_basic(crs = 3035, xlim = c(2426378, 7093974), ylim = c(1308101, 5446513))
emodnet_map_basic <- function(seaColor = emodnet_colors()$darkgrey,
                              landColor = emodnet_colors()$lightgrey,
                              crs = NULL,
                              xlim = NULL,
                              ylim = NULL){
  # Quality Check
  if(is.null(xlim) == FALSE & is.null(ylim) & is.null(crs) ||
     is.null(xlim) & is.null(ylim) == FALSE & is.null(crs) ||
     is.null(xlim) & is.null(ylim) & is.null(crs) == FALSE ||
     is.null(xlim) == FALSE & is.null(ylim) == FALSE & is.null(crs) ||
     is.null(xlim) == FALSE & is.null(ylim) & is.null(crs) == FALSE ||
     is.null(xlim) & is.null(ylim) == FALSE & is.null(crs) == FALSE) {
    warning("All arguments crs, xlim and ylim must be provided together. Otherwise ignored.")
    }

  # Start map
  emodnet_map_basic <- ggplot2::ggplot() +
    ggplot2::geom_sf(data = EMODnetBiologyMaps::world,
                     fill = landColor,
                     color = seaColor,
                     size = 0.1) +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = seaColor),
      plot.title = ggplot2::element_text(color= emodnet_colors()$darkgrey, size = 14, face="bold.italic", hjust = 0.5),
      plot.subtitle = ggplot2::element_text(color= emodnet_colors()$darkgrey, face="bold", size=10, hjust = 0.5)
    )

  # If projection is provided
  if(is.null(xlim) == FALSE & is.null(ylim) == FALSE & is.null(crs) == FALSE){
    emodnet_map_basic <- emodnet_map_basic + ggplot2::coord_sf(crs = crs, xlim = xlim, ylim = ylim)
  }

  return(emodnet_map_basic)
}
