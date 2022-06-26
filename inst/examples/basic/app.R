library(shiny)
library(video)

ui <- fluidPage(
  h1("Video Player"),
  video("http://vjs.zencdn.net/v/oceans.mp4")
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
