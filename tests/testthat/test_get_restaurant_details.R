library(testthat)
library(httr)
library(dplyr)
test_that("get_restaurant_details() returns valid details", {
  df <- get_restaurant_details(query = "Miku", location = "Vancouver, BC")
  expect_s3_class(df, "tbl_df")
  expect_true(nrow(df) > 0)
})
