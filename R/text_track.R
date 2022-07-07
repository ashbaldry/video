#' Add Text Tracks to Video
#'
#' @description
#' video.js contains the ability to include tracks with the video, including subtitles,
#' captions and descriptions. \code{includeTextTracks} will make sure that they are
#' included on load, and find the defaults to embed with the video.
#'
#' @param video A \code{\link{video}()}
#' @param files A vector of WebVTT files that contain "cues" of when text should appear,
#' hide and what text to display
#' @param language The valid BCP 47 code for the language of the text track,
#' e.g. "en" for English or "es" for Spanish.
#' @param label Short descriptive text for the track that will used in the user interface.
#' For example, in a menu for selecting a captions language.
#' @param kind An optional vector to match the type of text tracks in \code{files}:
#' \describe{
#' \item{subtitles}{(default): Translations of the dialogue in the video for when audio is
#' available but not understood. Subtitles are shown over the video.}
#' \item{captions}{Transcription of the dialogue, sound effects, musical cues, and other
#' audio information for viewer who are deaf/hard of hearing, or the video is muted.
#' Captions are also shown over the video.}
#' \item{chapters}{Chapter titles that are used to create navigation within the video.
#' Typically, these are in the form of a list of chapters that the viewer can use to
#' navigate the video.}
#' \item{descriptions}{Text descriptions of the action in the content for when the video portion
#' isn't available or because the viewer is blind or not using a screen. Descriptions are
#' read by a screen reader or turned into a separate audio track.}
#' \item{metadata}{Tracks that have data meant for JavaScript to parse and do something with.
#' These aren't shown to the user.}
#' }
#' @param default The boolean \code{default} attribute can be used to indicate that a track's
#' mode should start as "showing". Otherwise, the viewer would need to select their language
#' from a captions or subtitles menu.
#'
#' @details
#' All vectors must either be the same length as \code{files} or of length 1. In the latter,
#' they will be applied to all \code{files} supplied.
#'
#' @return
#' An updated \code{video} with text tracks included
#'
#' @examples
#' vid <- video("https://vjs.zencdn.net/v/oceans.mp4")
#' includeTextTracks(vid, "url/to/subtitles.vtt")
#'
#' @export
includeTextTracks <- function(video, files, language = "en", label = "English",
                             kind = "subtitles", default = FALSE) {
  if (length(files) == 0) {
    stop("No text tracks provided to add")
  }

  n_files <- length(files)

  language <- checkLength(language, n_files, "language")
  label <- checkLength(label, n_files, "label")
  kind <- checkLength(kind, n_files, "kind")
  default <- checkLength(default, n_files, "default")

  remote_tracks <- lapply(seq(files), function(x) {
    track_info <- list(
      src = files[x],
      kind = kind[x],
      srclang = language[x],
      label = label[x]
    )
    if (isTRUE(default[x])) {
      track_info$default <- NA
    }
    track_info
  })

  video$x$options$tracks <- remote_tracks
  video
}

checkLength <- function(x, n, label) {
  if (length(x) == 1) {
    rep(x, n)
  } else if (length(x) != n) {
    stop("The size of `", label, "` must either be 1 or number of files (", n, ")")
  } else {
    x
  }
}
