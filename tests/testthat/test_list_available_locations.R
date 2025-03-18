library(testthat)
library(tibble)

test_that("list_available_locations() returns expected locations", {
  df <- list_available_locations()
  expect_s3_class(df, "tbl_df")
  expect_true(nrow(df) > 0)
})
