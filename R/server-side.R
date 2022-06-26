#' Update video.js Server-Side
#'
#' @description
#' Change the state of the video player from the server.
#'
#' \code{playVideo}, \code{pauseVideo} and \code{stopVideo} will all be applied to the current track.
#'
#' \code{changeTrack} will update the track to the file specified. This file must be included when the player
#' is initialised, otherwise it won't change the track.
#'
#' \code{addTrack} will add a new track to the specified player.
#'
#' @param session Shiny session
#' @param id ID of the \code{video} to update
#'
#' @examples
#' if (interactive()) {}
#'
#' @return
#' Updates the the state of the specified \code{video} in the shiny application.
#'
#' @name video-server
#' @rdname video-server
#' @export
playVideo <- function(id, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage("playVideo", id)
}

#' @rdname video-server
#' @export
pauseVideo <- function(id, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage("pauseVideo", id)
}

#' @rdname video-server
#' @export
stopVideo <- function(id, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage("stopVideo", id)
}

#' @param seek Time (in seconds) to set the position of the track
#' @rdname video-server
#' @export
seekVideo <- function(id, seek, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage("seekVideo", list(id = id, seek = seek))
}

#' @param files A vector of file paths or URLs pointing
#' @param format An optional list of formats of \code{video}
#' @rdname video-server
#' @export
changeVideo <- function(id, files, format = NULL, session = getDefaultReactiveDomain()) {
  if (is.null(format)) {
    format <- guessVideoFormat(files)
  } else if (length(format) != length(files)) {
    stop("Files is not the same length as format")
  }
  sources <- lapply(seq(files), function(x) list(src = files[x], type = format[x]))
  session$sendCustomMessage("changeVideo", list(id = id, src = sources))
}
