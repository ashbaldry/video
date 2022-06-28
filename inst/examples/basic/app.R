library(shiny)
library(video)

ui <- fluidPage(
  h1("Video Player"),
  video("https://vjs.zencdn.net/v/oceans.mp4")
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
