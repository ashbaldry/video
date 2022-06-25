#' Video Player
#'
#' @description
#' A video player that can be embedded in HTML pages.
#'
#' @param files A vector of file paths or URLs pointing
#' @param format An optional list of formats of \code{video}
#' @param options A named list of options to apply to the video. List of available options
#' available in Details
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId HTML id tag to be given to the video player element
#'
#' @export
video <- function(files, format = NULL, options = list(), width = NULL, height = NULL, elementId = NULL) {
  if (is.null(format)) {
    sources <- lapply(files, function(x) list(src = x, type = "video/mp4"))
  } else {
    if (length(format) != length(files)) {
      stop("Files is not the same length as format")
    }
    sources <- lapply(seq(files), function(x) list(src = files[x], type = format[x]))
  }

  settings <- append(
    options, list(sources = sources)
  )

  if (!"controls" %in% names(settings)) {
    settings$controls <- TRUE
  }

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
#' @name video-shiny
#'
#' @export
videoOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'video', width, height, package = 'video')
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
