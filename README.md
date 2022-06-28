
<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test coverage](https://codecov.io/gh/ashbaldry/video/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ashbaldry/video?branch=main)
[![R-CMD-check](https://github.com/ashbaldry/video/workflows/R-CMD-check/badge.svg)](https://github.com/ashbaldry/video/actions)
<!-- badges: end -->

# {video}  - Interactive Video Player

`{video}` is a package that utilises the [video.js](https://github.com/videojs/video.js) library to play video on the modern web. 

## Installation

This package is not yet available on CRAN. To install the latest version: 

```r
install.packages("devtools")
devtools::install_github("ashbaldry/video")
```

## Usage

The HTML way to include an audio file in any shiny application/web page is to use the `<audio>` tag. This cannot (easily) be manipulated from the server. 

```r
tags$video(src = "https://vjs.zencdn.net/v/oceans.mp4", type = "video/mp4", controls = NA)
```

video.js is a flexible video player that is more robust than the basic HTML5 video player, and can easily be manipulated from the server side of shiny applications.

```r
library(shiny)
library(video)

ui <- fluidPage(
  title = "video Example",
  h1("Video Example"),
  video(
    "https://vjs.zencdn.net/v/oceans.mp4",
    elementId = "video"
  ),
  tags$p(
    "Currently playing:",
    textOutput("video_playing", container = tags$strong, inline = TRUE)
  )
)

server <- function(input, output, session) {
  output$video_playing <- renderText({
    if (isTRUE(input$video_playing)) "Yes" else "No"
  })

  observe({
    req(input$video_seek)
    if (round(input$video_seek) == 10) {
      pauseVideo("video")
    } else if (round(input$video_seek) == 20) {
      stopVideo("video")
    }
  })
}

shinyApp(ui, server)
```

<video src="https://user-images.githubusercontent.com/8420419/175826808-83d03bfc-6ba1-49c6-8f86-4e40973b010d.mp4" type="movie/mp4" controls style="width: 100%"></video>

Whilst the buttons below the video aren't required for playing/pausing the video, they are linked to `observeEvent`s that send messages from the server to the video to update.

## Examples

All examples are available in the [Examples](https://github.com/ashbaldry/video/tree/main/inst/examples) directory and can be run locally by installing the `{video}` package:

- [Basic Player](https://github.com/ashbaldry/video/tree/main/inst/examples/basic)
- [Server-Side Controls](https://github.com/ashbaldry/video/tree/main/inst/examples/server)
