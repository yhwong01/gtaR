library(httr)        # For making API requests to Yelp
library(jsonlite)    # For parsing JSON responses
library(dplyr)       # For data wrangling
library(ggplot2)     # For data visualization
library(ggmap)       # For mapping restaurant locations
library(ggrepel)     # For avoiding label overlap in plots
library(stringdist)  # For fuzzy text matching
#' Find the Best Cuisine in a Specified Area
#'
#' Aggregates restaurant ratings to identify the highest-rated cuisines in a location.
#' @param location A string specifying the city (default: "Vancouver, BC").
#' @param limit An integer specifying the number of restaurants to retrieve.
#' @return A tibble containing cuisine categories, average ratings, and restaurant counts.
#' @export
best_cuisine_in_area <- function(location = "Vancouver, BC", limit = 10) {
  df <- search_restaurants(location = location, limit = limit, sort_by = "rating")

  best_cuisine <- df %>%
    group_by(categories) %>%
    summarize(avg_rating = mean(rating, na.rm = TRUE), restaurant_count = n()) %>%
    arrange(desc(avg_rating), desc(restaurant_count))

  return(best_cuisine)
}

