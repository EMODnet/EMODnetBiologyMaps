#' Load colors of EMODnet
#'
#' This function returns a list with the six colors palette of EMODnet Biology, and white
#'
#' @return list
#' @export
#'
#' @examples emodnet_colors()$blue
#' @examples emodnet_colors()$darkblue
emodnet_colors <- function(){
  colors <- list(
    # First palette
    blue = "#0A71B4",
    yellow = "#F8B334",
    darkgrey = "#333333",
    # Secondary palette,
    darkblue = "#012E58",
    lightblue = "#61AADF",
    white = "#FFFFFF",
    lightgrey = "#F9F9F9"
  )
  return(colors)
}
