library(httr)        # For making API requests to Yelp
library(jsonlite)    # For parsing JSON responses
library(dplyr)       # For data wrangling
library(ggplot2)     # For data visualization
library(ggmap)       # For mapping restaurant locations
library(ggrepel)     # For avoiding label overlap in plots
library(stringdist)  # For fuzzy text matching
#' Find the Closest Cuisine Match
#'
#' Uses fuzzy string matching to suggest the closest known cuisine type.
#' @param input_text A string representing the cuisine type to search.
#' @return The best-matching cuisine type.
#' @export
find_closest_cuisine_match <- function(input_text) {
  cuisine_types <- c("Afghan", "African", "Senegalese", "South African", "American (New)", "American (Traditional)",
                     "Andalusian", "Arabian", "Arab Pizza", "Argentine", "Armenian", "Asian Fusion", "Asturian",
                     "Australian", "Austrian", "Baguettes", "Bangladeshi", "Barbeque", "Basque", "Bavarian",
                     "Beer Garden", "Beer Hall", "Beisl", "Belgian", "Flemish", "Bistros", "Black Sea", "Brasseries",
                     "Brazilian", "Brazilian Empanadas", "Central Brazilian", "Northeastern Brazilian", "Northern Brazilian",
                     "Rodizios", "Breakfast & Brunch", "Pancakes", "British", "Buffets", "Bulgarian", "Burgers", "Burmese",
                     "Cafes", "Themed Cafes", "Cafeteria", "Cajun/Creole", "Cambodian", "Canadian (New)", "Canteen", "Caribbean",
                     "Dominican", "Haitian", "Puerto Rican", "Trinidadian", "Catalan", "Cheesesteaks", "Chicken Shop",
                     "Chicken Wings", "Chilean", "Chinese", "Cantonese", "Congee", "Dim Sum", "Fuzhou", "Hainan", "Hakka",
                     "Henghwa", "Hokkien", "Hunan", "Pekinese", "Shanghainese", "Szechuan", "Teochew", "Comfort Food",
                     "Corsican", "Creperies", "Cuban", "Curry Sausage", "Cypriot", "Czech", "Czech/Slovakian", "Danish", "Delis",
                     "Diners", "Dinner Theater", "Dumplings", "Eastern European", "Eritrean", "Ethiopian", "Fast Food",
                     "Filipino", "Fischbroetchen", "Fish & Chips", "Flatbread", "Fondue", "Food Court", "Food Stands", "Freiduria",
                     "French", "Alsatian", "Auvergnat", "Berrichon", "Bourguignon", "Mauritius", "Nicoise", "Provencal", "Reunion",
                     "French Southwest", "Galician", "Game Meat", "Gastropubs", "Georgian", "German", "Baden", "Eastern German",
                     "Franconian", "Hessian", "Northern German", "Palatine", "Rhinelandian", "Giblets", "Gluten-Free", "Greek",
                     "Guamanian", "Halal", "Hawaiian", "Heuriger", "Himalayan/Nepalese", "Honduran", "Hong Kong Style Cafe",
                     "Hot Dogs", "Hot Pot", "Hungarian", "Iberian", "Indian", "Indonesian", "International", "Irish", "Island Pub",
                     "Israeli", "Italian", "Abruzzese", "Altoatesine", "Apulian", "Calabrian", "Cucina Campana", "Emilian",
                     "Friulan", "Ligurian", "Lumbard", "Napoletana", "Piemonte", "Roman", "Sardinian", "Sicilian", "Tuscan",
                     "Venetian", "Japanese", "Blowfish", "Conveyor Belt Sushi", "Donburi", "Gyudon", "Oyakodon", "Hand Rolls",
                     "Horumon", "Izakaya", "Japanese Curry", "Kaiseki", "Kushikatsu", "Oden", "Okinawan", "Okonomiyaki", "Onigiri",
                     "Ramen", "Robatayaki", "Soba", "Sukiyaki", "Takoyaki", "Tempura", "Teppanyaki", "Tonkatsu", "Udon", "Unagi",
                     "Western Style Japanese Food", "Yakiniku", "Yakitori", "Jewish", "Kebab", "Kopitiam", "Korean", "Kosher",
                     "Kurdish", "Laos", "Laotian", "Latin American", "Colombian", "Salvadoran", "Venezuelan", "Live/Raw Food",
                     "Lyonnais", "Malaysian", "Mamak", "Nyonya", "Meatballs", "Mediterranean", "Falafel", "Mexican", "Eastern Mexican",
                     "Jaliscan", "Northern Mexican", "Oaxacan", "Pueblan", "Tacos", "Tamales", "Yucatan", "Middle Eastern",
                     "Egyptian", "Lebanese", "Milk Bars", "Modern Australian", "Modern European", "Mongolian", "Moroccan",
                     "New Mexican Cuisine", "New Zealand", "Nicaraguan", "Night Food", "Nikkei", "Noodles", "Norcinerie",
                     "Open Sandwiches", "Oriental", "Pakistani", "Pan Asian", "Parent Cafes", "Parma", "Persian/Iranian",
                     "Peruvian", "PF/Comercial", "Pita", "Pizza", "Polish", "Pierogis", "Polynesian", "Pop-Up Restaurants",
                     "Portuguese", "Alentejo", "Algarve", "Azores", "Beira", "Fado Houses", "Madeira", "Minho", "Ribatejo",
                     "Tras-os-Montes", "Potatoes", "Poutineries", "Pub Food", "Rice", "Romanian", "Rotisserie Chicken",
                     "Russian", "Salad", "Sandwiches", "Scandinavian", "Schnitzel", "Scottish", "Seafood", "Serbo Croatian",
                     "Signature Cuisine", "Singaporean", "Slovakian", "Somali", "Soul Food", "Soup", "Southern", "Spanish",
                     "Arroceria/Paella", "Sri Lankan", "Steakhouses", "Supper Clubs", "Sushi Bars", "Swabian", "Swedish",
                     "Swiss Food", "Syrian", "Tabernas", "Taiwanese", "Tapas Bars", "Tapas/Small Plates", "Tavola Calda",
                     "Tex-Mex", "Thai", "Traditional Norwegian", "Traditional Swedish", "Trattorie", "Turkish", "Chee Kufta",
                     "Gozleme", "Homemade Food", "Lahmacun", "Ottoman Cuisine", "Turkish Ravioli", "Ukrainian", "Uzbek", "Vegan",
                     "Vegetarian", "Venison", "Vietnamese", "Waffles", "Wok", "Wraps", "Yugoslav")
  distances <- stringdistmatrix(input_text, cuisine_types, method = "jaccard")
  best_match <- cuisine_types[which.min(distances)]
  return(best_match)
}
