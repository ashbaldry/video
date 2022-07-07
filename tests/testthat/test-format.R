test_that("guessVideoFormat can correctly guess the correct format for common player extensions", {
  testthat::expect_identical(guessVideoFormat("video.mp4"), "video/mp4")
  testthat::expect_identical(guessVideoFormat("video.3gp"), "video/3gpp")
  testthat::expect_identical(guessVideoFormat("video.mpeg"), "video/mpeg")
  testthat::expect_identical(guessVideoFormat("video.ogg"), "video/ogg")
  testthat::expect_identical(guessVideoFormat("video.webm"), "video/webm")
})

test_that("guessVideoFormat returns message on non-video file", {
  testthat::expect_message({
    miss_file <- guessVideoFormat("video.docx")
  })
  testthat::expect_identical(miss_file, NA_character_)
})
