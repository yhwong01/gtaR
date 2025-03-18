library(httr)        # For making API requests to Yelp
library(jsonlite)    # For parsing JSON responses
library(dplyr)       # For data wrangling
library(ggplot2)     # For data visualization
library(ggmap)       # For mapping restaurant locations
library(ggrepel)     # For avoiding label overlap in plots
library(stringdist)  # For fuzzy text matching
#' Get Restaurant Details by Name or Address
#'
#' Retrieves detailed information about a restaurant based on a name or address search.
#' @param query A string representing the restaurant name or address.
#' @param location A string specifying the city or area (default: "Vancouver, BC").
#' @return A tibble containing restaurant details such as rating, address, phone, and Yelp URL.
#' @export
get_restaurant_details <- function(query, location = "Vancouver, BC") {
  df <- search_restaurants(term = query, location = location, limit = 1)

  if (nrow(df) == 0) {
    stop("No restaurant found. Please check the name or address and try again.")
  }

  return(df)
}
