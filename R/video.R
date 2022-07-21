#' Video Player
#'
#' @description
#' A video player that can be embedded in HTML pages.
#'
#' @param files A vector of file paths or URLs pointing
#' @param format An optional list of formats of \code{video}
#' @param options A named list of options to apply to the video. List of available options
#' available in Details
#' @param seek_ping_rate Number of milliseconds between each update of `input$\{id\}_seek` while playing. Default is
#' set to 1000. If set to 0, then `input$\{id\}_seek` will not exist.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended. Use \code{NA} for it to use
#'   the original video width/height.
#' @param elementId HTML id tag to be given to the video player element
#'
#' @return
#' A shiny.tag containing all of the required options for a \code{videojs} JS object to be initialised in a shiny application.
#'
#' On the server side there will be up to four additional objects available as inputs:
#' \describe{
#' \item{\code{\{id\}_playing}}{A logical value as to whether or not the \code{video} is playing audio}
#' \item{\code{\{id\}_seek}}{(If \code{seek_ping_rate > 0}) the current time of the track loaded}
#' \item{\code{\{id\}_duration}}{The duration of the track loaded}
#' }
#'
#' @details
#' Here are some more common options to implement:
#' \describe{
#' \item{autoplay}{
#'   Whether or not the video will autoplay on load. NOTE: There is not a guarantee autoplay will work in the browser.
#'   \describe{
#'   \item{\code{FALSE}}{Default: Video won't autoplay}
#'   \item{\code{TRUE}}{Video will use browser's autoplay}
#'   \item{\code{"muted"}}{Will mute the video and then manually call \code{play()} on \code{loadstart()}. Likely to work on browsers}
#'   \item{\code{"play"}}{Will call \code{play()} on \code{loadstart()}, similar to browser autoplay}
#'   }
#' }
#' \item{controls}{
#'   Determines whether or not the player has controls that the user can interact with. By default
#'   \code{video} will include controls even if not specified in the options.
#' }
#' \item{poster}{
#'   A URL to an image that displays before the video begins playing.
#'   This is often a frame of the video or a custom title screen.
#' }
#' }
#'
#' For a full list of available options check out \url{https://videojs.com/guides/options/}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     video("https://vjs.zencdn.net/v/oceans.mp4")
#'   )
#'
#'   server <- function(input, output) {
#'   }
#'
#'   runShiny(ui, server)
#' }
#'
#' @import shiny
#' @import htmlwidgets
#'
#' @export
video <- function(files, format = NULL, options = list(), seek_ping_rate = 1000,
                  width = NULL, height = NULL, elementId = NULL) {
  if (is.null(format)) {
    format <- guessVideoFormat(files)
  } else if (length(format) != length(files)) {
    stop("Files is not the same length as format")
  }
  sources <- lapply(seq(files), function(x) list(src = files[x], type = format[x]))

  options <- append(
    options, list(sources = sources)
  )

  if (!"controls" %in% names(options)) {
    options$controls <- TRUE
  }

  settings <- list(
    options = options,
    seek_ping_rate = seek_ping_rate
  )

  htmlwidgets::createWidget(
    name = "video",
    x = settings,
    width = width,
    height = height,
    package = "video",
    elementId = elementId
  )
}

#' Shiny bindings for video
#'
#' Output and render functions for using video within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a video
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @return
#' An output or render function that enables the use of the widget within Shiny applications.
#'
#' @name video-shiny
#' @export
videoOutput <- function(outputId, width = "100%", height = "400px"){
  htmlwidgets::shinyWidgetOutput(outputId, "video", width, height, package = "video")
}

#' @rdname video-shiny
#' @export
renderVideo <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, videoOutput, env, quoted = TRUE)
}

widget_html.video <- function(id, style, class, ...) {
  tags$video(
    id = id,
    style = style,
    class = paste("video-js", class),
    ...,
    tags$p(
      class = "vjs-no-js",
      "To view this video please enable JavaScript, and consider upgrading to a web browser that",
      tags$a(
        href = "https://videojs.com/html5-video-support/",
        target = "_blank",
        "supports HTML5 video"
      )
    )
  )
}
