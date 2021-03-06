library(testthat)

context("R62Fun")

test_that("no generic",{
  expect_silent(R62Fun(R62Fun_NoGeneric, assignEnvir = topenv(), exclude = "excluder", scope = c("public","active")))
  expect_equal(R62Funprinter(R62Fun_NoGeneric$new(), "Hello World"), "Hello World")
  expect_error(excluder(R62Fun_NoGeneric$new()))
  expect_equal(R62FunStatusC(R62Fun_NoGeneric$new()), "Printing")
  expect_true(length(methods::.S4methods("R62Funprinter")) == 0)
  expect_error(utils::isS3stdGeneric("R62Funprinter"))
})

plotter <- R6::R6Class("plotter", public = list(acos = function() return("I am plotting")))

test_that("detect = TRUE, mask = FALSE",{
  expect_silent(R62Fun(plotter, detectGeneric = TRUE, mask = FALSE, assignEnvir = topenv()))
  expect_equal(acos(plotter$new()), "I am plotting")
  expect_equal(find("acos"), "package:base")
})

test_that("detect = FALSE, mask = TRUE",{
  expect_silent(R62Fun(plotter, detectGeneric = FALSE, assignEnvir = topenv(), mask = TRUE))
  expect_equal(acos(plotter$new()), "I am plotting")
  expect_equal(names(formals(acos))[[1]], "object")
})
