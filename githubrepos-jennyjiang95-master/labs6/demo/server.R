
### server.R

library(shiny)
library(dplyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    df    <- faithful  # Old Faithful Geyser data
    bins  <- input$bins
    
    # draw the histogram with the specified number of bins
    ggplot(df, aes(x = waiting)) +
      geom_histogram(bins = bins, fill = "skyblue")
  })
})


