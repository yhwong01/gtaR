# GTA: Greater Vancouver's Taste Analytics

### Team Members:
- Yin Hei Ernest Wong
- Shiqi Zhang
- Jiakun Li

### API Chosen:
For this project, we have chosen to wrap the [Yelp Fusion API](https://docs.developer.yelp.com). Yelp Fusion API provides extensive and detailed restaurant data that perfectly aligns with our academic and personal interest in gourmet exploration within the Greater Vancouver Area (GVA). Yelp’s API is robust and well-documented, offering detailed business information including restaurant names, addresses, ratings, user reviews, hours of operation, photos, reservation availability, and more. These comprehensive features allow us to achieve our analytical and visualization objectives effectively.

### Intended Outcomes:
The primary outcome of this project is an R package named **GTA (Greater Vancouver's Taste Analytics)**. This package will simplify the process of accessing and analyzing Yelp restaurant data specifically for cities within the GVA, such as Vancouver, Burnaby, Richmond, Surrey, and Coquitlam. Through GTA, users will easily retrieve key restaurant information including names, addresses, ratings, cuisine types, operational hours, phone numbers, reviews, and Yelp profile links. Users will also have the flexibility to search restaurants by cuisine types, cities within the GVA, and sort results by ratings, thus providing a highly customized exploration experience.

Data returned by the GTA package will be automatically cleaned and structured into tidy data frames suitable for immediate statistical analysis or exploration. Additionally, built-in visualization tools will be available to users, providing quick and intuitive assessments of restaurant ratings, geographic distributions, and cuisine-specific trends across the GVA.

### Example Use:
Below is a practical example demonstrating how users can easily retrieve sushi restaurant data in Burnaby using our package:

```r
library(GTA)
restaurants <- get_gta_restaurants(city="Burnaby", category="Sushi")
head(restaurants)
```

### Sample output:

| name          | address     | category | rating | reviews | is_closed |
|---------------|-------------|----------|--------|---------|-----------|
| Sushi Garden  | 123 Main St | Sushi    | 4.5    | 220     | FALSE     |
| Sushi House   | 456 Elm St  | Sushi    | 4.4    | 184     | FALSE     |

For visualization, users can execute a command such as:

```r
plot_top_restaurants(city="Richmond", category="Dim Sum")
# Produces an intuitive bar chart of top-rated Dim Sum restaurants.
```
