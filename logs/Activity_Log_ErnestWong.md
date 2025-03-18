# Activity Log - Ernest Wong

## Date: 2025/03/17  
- Implemented **GitHub Actions CI** for automated testing and package validation.  
- Updated `r-ci.yml` to ensure the correct API key is detected via GitHub Secrets.  
- Fixed CI issues caused by **deprecated `upload-artifact@v3`**, upgrading to `upload-artifact@v4`.  
- Built and successfully installed the package locally.  
- Verified that all functions correctly retrieve and process Yelp API data.  
- Finalize remote repo

## Date: 2025/03/16  
- Structured **all R functions into separate files** (`R/` folder) to maintain modularity in local repo.  
- Created a function (deleted) to **load and test all functions in a single script**.  
- Resolved missing dependencies (`httr`, `stringdist`, `ggrepel`) in the GitHub Actions workflow.  
- Ran `devtools::check()` and `devtools::test()`, resolving function documentation inconsistencies.  

## Date: 2025/03/15  
- Help finalized `find_closest_cuisine_match.R`, implementing **fuzzy string matching** using `stringdist`.  
- Validated that the function correctly suggests cuisine names for **various user inputs**.  
- Investigated in CI (Travis, github actions).  

## Date: 2025/03/14  
- Ensured function handles **missing data and empty results gracefully**.  
- Investigated `stringdist` for string matching.  

## Date: 2025/03/13  
- Verified function outputs were **sorted correctly** by average rating and restaurant count.  

## Date: 2025/03/12  
- Help implemented `get_restaurant_details.R`, retrieving restaurant details **by name or address**.  

## Date: 2025/03/10  
- Improved `search_restaurants.R` by allowing **sorting by price, rating, and review count**.  

## Date: 2025/03/08  
- Designed `search_restaurants.R` by allowing basic searching by location, and type of cusine.  
- Ensured all restaurant searches returned **structured tidy dataframes**.  
 

## Date: 2025/03/07  
- Completed the **API integration strategy**, selecting `httr` for efficient request handling.  
- Implemented **secure API key management**, ensuring it is retrieved safely using `get_yelp_api_key()` and `.Renviron`.  

## Date: 2025/03/06  
- Defined **function architecture and naming conventions** to maintain consistency across the package.  
- Standardized **input parameters and output formats** for all utility functions.  
- Conducted research on **best practices for R package development**, focusing on documentation and usability.  

## Date: 2025/03/05  
- Identified key **business insights** that can be derived from Yelp data for analysis.  
- Analyzed similar **existing R packages** to ensure GTA provides unique and valuable features.  

## Date: 2025/03/03  
- Reviewed the **project scope and requirements**, aligning goals with the team.  
- Explored various **API-based project ideas** before finalizing the Yelp API for implementation.  
- Discussed **statistical analysis techniques** to be incorporated into the package for insightful data exploration.  

