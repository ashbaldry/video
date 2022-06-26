#' Guess Video Format Type
#'
#' @description
#' If no type is provided when generating a video.js video, then the format needs to
#' be guessed. Included in the package is a dataset of the default type of each
#' video. This will give the default type of each file provided.
#'
#' @param files A vector of URL paths (relative or absolute) to videos
#'
#' @return
#' A vector the same length as \code{files} of the video types.
#'
#' @examples
#' guessVideoFormat("video.mp4")
#'
#' @export
guessVideoFormat <- function(files) {
  extensions <- tolower(tools::file_ext(files))
  types <- video_formats[match(extensions, tolower(video_formats$extension)), "type"]
  if (any(is.na(types))) {
    message(
      "Unable to guess file format types for the following files:\n",
      paste("  -", files[is.na(types)], "\n"),
      "  Use `video_formats` to find the relevant type"
    )
  }
  types
}
