library(shiny)
library(ggvis)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Life Expectancy and Income"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar panel
    sidebarPanel(
      sliderInput('integer',
                  'Year : ',
                  1800, 2015, value=1800,
                  animate = T)
      ),
    
    
    # Main panel
    mainPanel(
      uiOutput("ggvis_ui"),
      ggvisOutput("ggvis")
      )
      ))
      )

