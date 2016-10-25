

library(shiny)

shinyUI(fluidPage(
  
  #  Application title
  titlePanel("Life Expectancy and Income"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(
      # Simple integer interval
      sliderInput("integer", "Year:",
                 min=1800, max=2015, value=1800,
                 animate = TRUE)
    ),
   
    mainPanel(
      plotOutput("Plot")
    )
  )
))
