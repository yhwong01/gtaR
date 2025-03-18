library(testthat)
library(tibble)
library(httr)
library(dplyr)

test_that("best_cuisine_in_area() returns valid data", {
  df <- best_cuisine_in_area(location = "Vancouver, BC", limit = 10)

  expect_s3_class(df, "tbl_df")
  expect_true(nrow(df) > 0)
  expect_true(all(c("categories", "avg_rating", "restaurant_count") %in% colnames(df)))
})
