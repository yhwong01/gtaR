# GTA: Greater Vancouver's Taste Analytics
  
![Build Status](https://github.com/yhwong01/gtaR/actions/workflows/r-ci.yml/badge.svg)

### Team Members:
- Yin Hei Ernest Wong
- Shiqi Zhang
- Jiakun Li

## Overview
GTA (Greater Vancouver's Taste Analytics) is an R package that simplifies access to restaurant-related data for the cities within the Greater Vancouver Area, such as Vancouver, Burnaby, Richmond, Surrey, and Coquitlam. The package provides structured data retrieval, filtering, and visualization capabilities, making it easy to analyze restaurant details such as names, addresses, ratings, categories, and more.

### API Chosen:
For this project, we have chosen to wrap the [Yelp Fusion API](https://docs.developer.yelp.com). Yelp Fusion API provides extensive and detailed restaurant data that perfectly aligns with our academic and personal interest in gourmet exploration within the Greater Vancouver Area. Yelp’s API is robust and well-documented, offering detailed business information including restaurant names, addresses, ratings, user reviews, hours of operation, photos, reservation availability, and more. These comprehensive features allow us to achieve our analytical and visualization objectives effectively.

## Installation
To install the GTA package from GitHub, use:

```r
library(remotes)  
install_github("yhwong01/gtaR")  
```

Load the package after installation:
```r
library(gtaR)
```

## API Key Setup
Before using the package, you need to set your Yelp API key in your `.Renviron` file:
```r
Sys.setenv(YELP_API_KEY = "your_api_key_here")  
```
Ensure you restart your R session for the changes to take effect.

### API Key Handling

The function `get_yelp_api_key()` is a helper function used internally by other package functions to securely retrieve the API key. Users do not need to call this function directly. Instead, ensure that the API key is set up correctly in your environment before using any package functions that interact with the Yelp API.

---

## Functions and Usage

### 1. best_cuisine_in_area  
This function aggregates restaurant ratings to identify the highest-rated cuisines in a specified location.

**Function Signature:**  
```r
best_cuisine_in_area(location = "Vancouver, BC", limit = 10)
```

**Parameters:**  
- location: A string specifying the city (default: "Vancouver, BC").  
- limit: An integer specifying the number of restaurants to retrieve.  

**Returns:**  
A tibble containing:  
- categories: The cuisine categories.  
- avg_rating: The average rating of restaurants in that category.  
- restaurant_count: The number of restaurants in that category.  

**Example Usage:**  
```r
best_cuisine <- best_cuisine_in_area("Burnaby, BC", limit = 15)  
print(best_cuisine)
```

---

### 2. find_closest_cuisine_match  
Uses fuzzy string matching to suggest the closest known cuisine type.

**Function Signature:**  
```r
find_closest_cuisine_match(input_text)
```

**Parameters:**  
- input_text: A string representing the cuisine type to search.  

**Returns:**  
The best-matching cuisine type from the predefined list.  

**Example Usage:**  
```r
best_match <- find_closest_cuisine_match("Italien")  
print(best_match)
```

---

### 3. get_restaurant_details  
Retrieves detailed information about a restaurant based on a name or address search.

**Function Signature:**  
```r
get_restaurant_details(query, location = "Vancouver, BC")
```

**Parameters:**  
- query: A string representing the restaurant name or address.  
- location: A string specifying the city or area (default: "Vancouver, BC").  

**Returns:**  
A tibble containing restaurant details such as:  
- name  
- rating  
- review_count  
- price  
- address  
- latitude  
- longitude  
- categories  
- url  

**Example Usage:**  
```r
restaurant_info <- get_restaurant_details("Sushi Yama", "Vancouver, BC")  
print(restaurant_info)
```

---

### 4. search_restaurants  
Queries the Yelp API to retrieve restaurant details based on location and filters.

**Function Signature:**  
```r
search_restaurants(location = "Vancouver, BC", term = "restaurant", limit = 10,  
sort_by = "rating", min_price = NULL, max_price = NULL, price_sort = NULL)
```

**Parameters:**  
- location: The city or address for search.  
- term: Type of restaurant (e.g., "sushi", "Italian").  
- limit: Number of results to return (default: 10, max: 50).  
- sort_by: Sorting criteria: "best_match", "rating", "review_count", "distance".  
- min_price, max_price: Minimum and maximum price levels ($ to $$$$).  
- price_sort: Sorting preference for price ("asc" or "desc").  

**Returns:**  
A tibble containing:  
- name  
- rating  
- review_count  
- price  
- address  
- latitude  
- longitude  
- categories  
- url  

**Example Usage:**  
```r
restaurants <- search_restaurants(location = "Richmond, BC", term = "ramen", limit = 5)  
print(restaurants)
```

---

### 5. plot_best_restaurants  
Creates a visualization of the best restaurants based on ratings and review count.

**Function Signature:**  
```r
plot_best_restaurants(df, top_n = 10)
```

**Parameters:**  
- df: A tibble containing restaurant data.  
- top_n: The number of top restaurants to display.  

**Returns:**  
A ggplot object displaying the top restaurants.  

**Example Usage and Output:**  
```r
restaurants <- search_restaurants(location = "Vancouver, BC", term = "Sushi", limit = 10)  
plot_best_restaurants(restaurants, top_n = 10)
```
<img width="652" alt="plot_restaurants" src="https://github.com/user-attachments/assets/5e7f1d5c-95d5-4696-85de-d33ca03867a7" />


---

### 6. list_available_locations  
Returns a list of predefined cities available for restaurant searches.

**Function Signature:**  
```r
list_available_locations()
```

**Returns:**  
A tibble containing city names.  

**Example Usage:**  
```r
locations <- list_available_locations()  
print(locations)
```

---


## Contributions  
Contributions are welcome! Feel free to submit issues and pull requests on [GitHub](https://github.com/yhwong01/gtaR).

## License  
This package is licensed under the MIT License.

---

Developed for DATA 534 Group Project.

