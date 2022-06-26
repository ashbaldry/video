testthat::test_that("video fails with no `id`", {
  testthat::expect_error(video())
})

testthat::test_that("video fails with no files", {
  testthat::expect_error(video(elementId = "test"))
})

testthat::test_that("Simple video player can be created", {
  player <- video("http://vjs.zencdn.net/v/oceans.mp4")

  testthat::expect_s3_class(player, "video")
  testthat::expect_s3_class(player, "htmlwidget")
})

testthat::test_that("Video player successfully guesses video formats", {
  files <- c(
    "http://vjs.zencdn.net/v/oceans.mp4",
    "http://vjs.zencdn.net/v/oceans.webm",
    "http://vjs.zencdn.net/v/oceans.ogv"
  )
  formats <- c("video/mp4", "video/webm", "video/ogg")

  player <- video(files = files, format = formats, elementId = "video")
  player2 <- video(files = files, elementId = "video")

  testthat::expect_identical(player, player2)
})
