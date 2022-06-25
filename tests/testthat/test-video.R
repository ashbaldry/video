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
