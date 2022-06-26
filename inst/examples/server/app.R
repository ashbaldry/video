library(shiny)
library(video)

ui <- fluidPage(
  h1("Video Player"),
  video(
    elementId = "video",
    files = c(
      "http://vjs.zencdn.net/v/oceans.mp4",
      "http://vjs.zencdn.net/v/oceans.webm",
      "http://vjs.zencdn.net/v/oceans.ogv"
    ),
    format = c(
      "video/mp4",
      "video/webm",
      "video/ogg"
    )
  ),
  br(),
  actionButton("play", "Play", icon("play")),
  actionButton("pause", "Pause", icon("pause")),
  actionButton("stop", "Stop", icon("stop")),
  actionButton("seek", "Go to 10 secs")
)

server <- function(input, output, session) {
  observeEvent(input$play, playVideo("video"))
  observeEvent(input$pause, pauseVideo("video"))
  observeEvent(input$stop, stopVideo("video"))
  observeEvent(input$seek, seekVideo("video", 10))
}

shinyApp(ui, server)
