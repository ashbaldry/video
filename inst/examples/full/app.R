library(shiny)
library(video)

ui <- fluidPage(
  title = "video Example",
  h1("Video Example"),
  video(
    "http://vjs.zencdn.net/v/oceans.mp4",
    elementId = "video"
  ),
  tags$br(),
  tags$br(),
  tags$p(
    "Currently playing:",
    textOutput("video_playing", container = tags$strong, inline = TRUE)
  ),
  tags$p(
    "Duration:",
    textOutput("video_seek", container = tags$strong, inline = TRUE),
    "/",
    textOutput("video_duration", container = tags$strong, inline = TRUE)
  )
)

server <- function(input, output, session) {
  output$video_playing <- renderText({
    if (isTRUE(input$video_playing)) "Yes" else "No"
  })

  output$video_duration <- renderText({
    sprintf(
      "%02d:%02.0f",
      input$video_duration %/% 60,
      input$video_duration %% 60
    )
  })

  output$video_seek <- renderText({
    sprintf(
      "%02d:%02.0f",
      input$video_seek %/% 60,
      input$video_seek %% 60
    )
  })
}

shinyApp(ui, server)
