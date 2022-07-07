test_that("includeTextTracks successfully includes subtitle track", {
  vid <- video("video.mp4")
  vid <- includeTextTracks(vid, "captions.vtt")

  testthat::expect_s3_class(vid, "video")
  testthat::expect_match(names(vid$x$options), "tracks", all = FALSE)
  testthat::expect_length(vid$x$options$tracks, 1)
  testthat::expect_named(vid$x$options$tracks[[1]], c("src", "kind", "srclang", "label"))
})

test_that("includeTextTracks errors when no tracks provided", {
  testthat::expect_error(includeTextTracks(vid, c()))
})

test_that("includeTextTracks errors when files and metrics are different length", {
  vid <- video("video.mp4")
  testthat::expect_error(includeTextTracks(vid, "captions.vtt", label = LETTERS))
  testthat::expect_error(
    includeTextTracks(vid, c("captions.vtt", "captions2.vtt"), language = c("en", "fr", "es"))
  )
})

test_that("includeTextTracks passes with multiple tracks and single language", {
  vid <- video("video.mp4")
  testthat::expect_error(includeTextTracks(vid, c("captions.vtt", "captions2.vtt"), language = "en"), NA)
  testthat::expect_error(includeTextTracks(vid, c("captions.vtt", "captions2.vtt"), label = "Captions"), NA)
  testthat::expect_error(includeTextTracks(vid, c("captions.vtt", "captions2.vtt"), kind = "caption"), NA)
  testthat::expect_error(includeTextTracks(vid, c("captions.vtt", "captions2.vtt"), default = TRUE), NA)
})
