context("Dataset check")

test_that("Dimension of dataset. Should be 30202 by 50", {
  expect_equal(dim(demo_accident_2013)[1], 30202)
  expect_equal(dim(demo_accident_2013)[2], 50)
})

test_that("Count of accidents where MONTH = 2 year = 2013. Should be 1952", {
  library(dplyr)

  year <- 2013
  t <- dplyr::mutate(demo_accident_2013, year = year) %>%  dplyr::select(MONTH, year) %>% count(MONTH) %>% filter(MONTH==2)

  expect_equal(t$n, 1952)

})

