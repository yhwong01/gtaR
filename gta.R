# Load necessary libraries
library(httr)       # For making HTTP requests to Yelp API
library(jsonlite)   # For handling JSON data returned by API
library(dplyr)      # For data wrangling

# Function to get API Key from environment variables
get_yelp_api_key <- function() {
  api_key <- Sys.getenv("YELP_API_KEY")  
  
  # Check if API key is missing
  if (api_key == "") {
    stop("YELP_API_KEY not set. Please add it to your .Renviron file.")
  }
  return(api_key)
}

# Function to search for restaurants using Yelp API
search_restaurants <- function(term = "restaurant", location = "Vancouver, BC", 
                               categories = NULL, limit = 10, sort_by = "rating") {
  api_key <- get_yelp_api_key()  # Retrieve API key
  url <- "https://api.yelp.com/v3/businesses/search"  # Yelp API endpoint
  
  # Construct query parameters
  query_params <- list(
    term = term,        # Search term (e.g., "sushi", "pizza")
    location = location, # Location of search (city, state, or specific address)
    categories = categories, # Yelp categories (e.g., "chinese", "italian")
    limit = limit,      # Number of results to return (max 50)
    sort_by = sort_by   # Sorting option: "rating", "review_count", etc.
  )
  
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
  businesses <- data$businesses  # Extract business information
  
  # Convert extracted data to a tidy dataframe
  df <- tibble(
    name = sapply(businesses, function(x) x$name),  # Restaurant name
    rating = sapply(businesses, function(x) x$rating),  # Yelp rating
    review_count = sapply(businesses, function(x) x$review_count),  # Number of reviews
    price = sapply(businesses, function(x) ifelse(is.null(x$price), NA, x$price)),  # Price level
    address = sapply(businesses, function(x) paste(x$location$display_address, collapse = ", ")),  # Full address
    latitude = sapply(businesses, function(x) x$coordinates$latitude),  # Latitude for mapping
    longitude = sapply(businesses, function(x) x$coordinates$longitude),  # Longitude for mapping
    categories = sapply(businesses, function(x) paste(sapply(x$categories, function(y) y$title), collapse = ", ")),  # Cuisine types
    url = sapply(businesses, function(x) x$url)  # Yelp business page URL
  )
  
  return(df)  # Return cleaned dataframe
}

#example usage
search_restaurants(term = "sushi", location = "Vancouver, BC", limit = 10)