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
playHowl <- function(session, id) {
  message_name <- paste0("playHowler_", session$ns(id))
  session$sendCustomMessage("playVideo", id)
}

#' @rdname video-server
#' @export
pauseHowl <- function(session, id) {
  message_name <- paste0("pauseHowler_", session$ns(id))
  session$sendCustomMessage("pauseVideo", id)
}

#' @rdname video-server
#' @export
stopHowl <- function(session, id) {
  message_name <- paste0("stopHowler_", session$ns(id))
  session$sendCustomMessage("stopVideo", id)
}

#' @param seek Time (in seconds) to set the position of the track
#' @rdname video-server
#' @export
seekVideo <- function(session, id, seek) {
  session$sendCustomMessage("seekVideo", list(id = id, seek = seek))
}
