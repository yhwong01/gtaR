library(testthat)
library(stringdist)


test_that("find_closest_cuisine_match() finds reasonable matches", {
  expect_equal(find_closest_cuisine_match("Ita"), "Italian")
  expect_equal(find_closest_cuisine_match("Japa"), "Japanese")
  expect_equal(find_closest_cuisine_match("Mexi"), "Mexican")
})

