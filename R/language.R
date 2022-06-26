#' Add Language Support
#'
#' @description
#' Enabling languages (other than English) to appear as tooltips and other buttons in video.js widgets.
#'
#' @param video A \code{\link{video}}
#' @param languages A character vector of languages to support in the video.
#' See \code{availableVideoLanguages()} for a full list
#'
#' @return
#' An updated \code{video} with extra language support
#'
#' @details
#' If any languages are missing, you can add a separate script in the head of the application
#' that will apply the language to all videos. See \url{https://videojs.com/guides/languages/}
#' for more details
#'
#' @examples
#' video <- video("http://vjs.zencdn.net/v/oceans.mp4")
#' video <- addVideoLanguages(video, c("es", "fr", "de"))
#'
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(lang = "fr", video)
#'   server <- function(input, output) {}
#'   shinyApp(ui, server)
#' }
#'
#' @importFrom stats setNames
#'
#' @rdname video-languages
#' @export
addVideoLanguages <- function(video, languages) {
  missing_languages <- setdiff(languages, availableLanguages())
  if (length(missing_languages)) {
    stop(
      "The following languages are currently unavailable for video.js: ",
      paste(missing_languages, collapse = ", ")
    )
  }

  video$x$options$languages <- setNames(lapply(languages, getLanguageText), languages)
  video
}

#' @rdname video-languages
#' @export
availableLanguages <- function() {
  lang_dir <- system.file("htmlwidgets/video/lang", package = "video")
  unique(sub("\\..*", "", list.files(lang_dir)))
}

getLanguageText <- function(language) {
  jsonlite::fromJSON(
    system.file(file.path("htmlwidgets/video/lang", paste0(language, ".json")), package = "video")
  )
}
