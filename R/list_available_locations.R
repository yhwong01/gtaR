#' List Available Locations
#'
#' Returns a list of predefined cities available for restaurant searches.
#' @return A tibble containing city names.
#' @export
list_available_locations <- function() {
  locations <- c("Vancouver, BC", "Burnaby, BC", "Richmond, BC", "Surrey, BC", "Coquitlam, BC")
  return(tibble(location = locations))
}