library(httr)        # For making API requests to Yelp
library(jsonlite)    # For parsing JSON responses
library(dplyr)       # For data wrangling
library(ggplot2)     # For data visualization
library(ggmap)       # For mapping restaurant locations
library(ggrepel)     # For avoiding label overlap in plots
library(stringdist)  # For fuzzy text matching
#' Plot Top-Rated Restaurants
#'
#' Visualizes the best restaurants based on rating and review count.
#' @param df A tibble containing restaurant data.
#' @param top_n The number of top restaurants to display.
#' @return A ggplot object visualizing top restaurants.
#' @export
plot_best_restaurants <- function(df, top_n = 10) {
  if (nrow(df) == 0) {
    stop("No data available for visualization.")
  }

  top_restaurants <- df %>%
    arrange(desc(rating), desc(review_count)) %>%
    head(top_n)

  ggplot(top_restaurants, aes(x = review_count, y = rating, color = rating, size = review_count)) +
    geom_point(alpha = 0.9) +
    geom_text_repel(aes(label = name),
                    box.padding = 0.5,
                    point.padding = 0.5,
                    segment.color = "gray50",
                    direction = "both",
                    max.overlaps = Inf,
                    size = 5, fontface = "bold", color = "black") +
    scale_color_gradient(low = "blue", high = "red") +
    labs(title = paste("Top", top_n, "Best Restaurants: Rating vs. Review Count"),
         x = "Number of Reviews",
         y = "Rating",
         color = "Rating",
         size = "Review Count") +
    theme_minimal()
}
