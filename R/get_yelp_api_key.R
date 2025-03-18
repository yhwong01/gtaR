#' Get Yelp API Key
#'
#' Retrieves the Yelp API key from environment variables.
#' @return A string containing the Yelp API key.
#' @export
get_yelp_api_key <- function() {
  api_key <- Sys.getenv("YELP_API_KEY")  # Securely retrieve API key
  
  if (api_key == "") {
    stop("YELP_API_KEY is not set. Please add it to your .Renviron file.")
  }
  
  return(api_key)
}