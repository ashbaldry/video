#' Video Formats
#'
#' @description
#' A dataset containing the format type of all potential video file extensions. Used
#' as the "type" attribute for HTML videos.
#'
#' @format A data frame with 96 rows and 2 variables:
#' \describe{
#' \item{extension}{File extension string}
#' \item{type}{Type attribute to give to a <video> HTML tag}
#' }
#'
#' @source \url{https://developer.mozilla.org/en-US/docs/Web/Media/Formats/Containers}
#' @source \url{https://www.iana.org/assignments/media-types/media-types.xhtml#video}
video_formats <- read.csv("data-raw/video_formats.csv")
usethis::use_data(video_formats, overwrite = TRUE, internal = TRUE)
