library(testthat)
library(tibble)
library(ggplot2)
library(ggrepel)

test_that("plot_best_restaurants() produces a ggplot object", {
  df <- search_restaurants(location = "Vancouver, BC", term = "Sushi", limit = 10)

  plot <- plot_best_restaurants(df, top_n = 5)
  expect_s3_class(plot, "gg")
})

test_that("plot_best_restaurants() handles empty data gracefully", {
  df <- tibble()
  expect_error(plot_best_restaurants(df, top_n = 5))
})
