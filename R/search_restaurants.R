library(httr)        # For making API requests to Yelp
library(jsonlite)    # For parsing JSON responses
library(dplyr)       # For data wrangling
library(ggplot2)     # For data visualization


#' Search for Restaurants with Exact Type Enforcement
#'
#' Queries the Yelp API to retrieve restaurant details based on location and filters.
#' Ensures that all results match the specified type if `limit = 10` by modifying the `term` parameter.
#'
#' @param location A string specifying the city or address (default: "Vancouver, BC").
#' @param term Optional. A string specifying restaurant type (e.g., "sushi", "Italian").
#' @param limit An integer indicating the number of results to return (default: 10, max: 50).
#' @param sort_by Sorting parameter: "best_match", "rating", "review_count", "distance".
#' @param min_price Minimum price level ($ to $$$$).
#' @param max_price Maximum price level ($ to $$$$).
#' @param price_sort Sort by price ("asc" or "desc").
#' @return A tibble containing restaurant details.
#' @export
search_restaurants <- function(location = "Vancouver, BC", term = "restaurant", limit = 10,
                               sort_by = "rating", min_price = NULL, max_price = NULL, price_sort = NULL) {

  api_key <- get_yelp_api_key()  # Retrieve the API key
  url <- "https://api.yelp.com/v3/businesses/search"  # Yelp API endpoint

  # Adjust term when limit is 10 (to enforce exact type filtering)
  if (term != "restaurant") {
    query_term <- term  # Use the specified type directly
  } else {
    query_term <- "restaurant"  # Default term for general searches
  }

  # Construct query parameters for the API request
  query_params <- list(
    term = query_term,  # Set the search term dynamically
    location = location,  # Search location (city, state, or specific address)
    limit = limit,  # Number of results to return (max 50)
    sort_by = sort_by  # Sorting option: "best_match", "rating", "review_count", or "distance"
  )

  # Yelp price level mapping: "$"=1, "$$"=2, "$$$"=3, "$$$$"=4
  price_levels <- c("$" = 1, "$$" = 2, "$$$" = 3, "$$$$" = 4)

  # Convert price symbols to numeric values
  min_price_numeric <- if (!is.null(min_price)) unname(price_levels[min_price]) else NULL
  max_price_numeric <- if (!is.null(max_price)) unname(price_levels[max_price]) else NULL

  # Ensure valid price range
  if (!is.null(min_price_numeric) && !is.null(max_price_numeric) && min_price_numeric > max_price_numeric) {
    stop("Invalid price range: `min_price` must be lower than or equal to `max_price`.")
  }

  # Construct price filter for Yelp API (supports values like "1,2,3,4")
  if (!is.null(min_price_numeric) || !is.null(max_price_numeric)) {
    valid_prices <- price_levels[price_levels >= min_price_numeric & price_levels <= max_price_numeric]
    query_params$price <- paste(valid_prices, collapse = ",")
  }

  # Send GET request to Yelp API
  response <- GET(url,
                  add_headers(Authorization = paste("Bearer", api_key)),
                  query = query_params)

  # Handle API errors
  if (http_status(response)$category != "Success") {
    stop("API request failed: ", http_status(response)$message)
  }

  # Parse JSON response
  data <- content(response, as = "parsed", type = "application/json")
  businesses <- data$businesses

  # Convert extracted data to a tidy dataframe
  df <- tibble(
    name = sapply(businesses, function(x) x$name),  # Restaurant name
    rating = sapply(businesses, function(x) x$rating),  # Yelp rating (1-5)
    review_count = sapply(businesses, function(x) x$review_count),  # Number of reviews
    price = sapply(businesses, function(x) ifelse(is.null(x$price), NA, x$price)),  # Price level ($ to $$$$)
    address = sapply(businesses, function(x) paste(x$location$display_address, collapse = ", ")),  # Full address
    latitude = sapply(businesses, function(x) x$coordinates$latitude),  # Latitude for mapping
    longitude = sapply(businesses, function(x) x$coordinates$longitude),  # Longitude for mapping
    categories = sapply(businesses, function(x) paste(sapply(x$categories, function(y) y$title), collapse = ", ")),  # Cuisine types
    url = sapply(businesses, function(x) x$url)  # Yelp business page URL
  )

  # Sorting by price if specified
  if (!is.null(price_sort) && !is.null(df$price)) {
    df <- df %>%
      mutate(price_numeric = unlist(price_levels[price])) %>%  # Convert price to numeric
      filter(!is.na(price_numeric))  # Remove NA prices for sorting

    if (price_sort == "asc") {
      df <- df %>% arrange(price_numeric)  # Sort by ascending price
    } else if (price_sort == "desc") {
      df <- df %>% arrange(desc(price_numeric))  # Sort by descending price
    }

    df <- df %>% select(-price_numeric)  # Remove temporary numeric price column
  }

  return(df)  # Return the cleaned and structured dataframe
}
