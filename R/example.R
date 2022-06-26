#' Run \code{\{video\}} Example Applications
#'
#' @param example Name of the example to load. Current examples include:
#' \describe{
#' \item{basic}{Basic example of \code{video} in use}
#' \item{full}{Basic example of using all buttons available in \code{video}}
#' \item{server}{Example showing server-side functionality}
#' }
#' @param display.mode The mode in which to display the application. By default set to \code{"showcase"} to show
#' code behind the example.
#' @param ... Optional arguments to send to \code{shiny::runApp}
#'
#' @examples
#' availableVideoExamples()
#'
#' if (interactive()) {
#'   library(shiny)
#'   library(video)
#'
#'   runVideoExample("server")
#' }
#'
#' @rdname examples
#' @export
runVideoExample <- function(example = "basic", display.mode = "showcase", ...) {
  available_examples <- findVideoExamples()
  if (!example %in% available_examples) {
    stop("Example not available. Choose from: '", paste(available_examples, collapse = "', '"), "'")
  }

  shiny::runApp(
    file.path(system.file("examples", package = "video"), example),
    display.mode = display.mode,
    ...
  )
}

#' @rdname examples
#' @export
availableVideoExamples <- function() {
  available_examples <- findVideoExamples()
  cat("'", paste(available_examples, collapse = "', '"), "'\n", sep = "")

  invisible(available_examples)
}

findVideoExamples <- function() {
  example_dir <- system.file("examples", package = "video")
  list.files(example_dir)
}
