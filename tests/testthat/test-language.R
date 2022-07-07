test_that("addVideoLanguages works for available languages", {
  vid <- video("video.mp4")
  testthat::expect_error(addVideoLanguages(vid, "fr"), NA)

  vid2 <- addVideoLanguages(vid, "fr")
  testthat::expect_match(names(vid2$x$options), "languages", all = FALSE)
  testthat::expect_length(vid2$x$options$languages, 1)
  testthat::expect_type(vid2$x$options$languages$fr, "list")
  testthat::expect_match(sapply(vid2$x$options$languages$fr, "class"), "character")
})

test_that("addVideoLanguages works for multiple languages", {
  vid <- video("video.mp4")
  testthat::expect_error(addVideoLanguages(vid, c("fr", "es")), NA)

  vid2 <- addVideoLanguages(vid, c("fr", "es"))
  testthat::expect_match(names(vid2$x$options), "languages", all = FALSE)
  testthat::expect_length(vid2$x$options$languages, 2)
  testthat::expect_type(vid2$x$options$languages$es, "list")
  testthat::expect_match(sapply(vid2$x$options$languages$es, "class"), "character")
})

test_that("addVideoLanguages errors with unavailable language", {
  vid <- video("video.mp4")
  testthat::expect_error(addVideoLanguages(vid, "lu"))
})
