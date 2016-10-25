
##server.R

library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

  
  output$Plot <- renderPlot({
    y <- "price"
    x <- input$chooseplot
    cut <- input$choosecut
    color <- input$choosecolor
    diamonds %>% 
      filter(cut %in% cut, color %in% color) %>% 
      ggplot(aes_string(x = x, y = "price"))+
      geom_point()
    
    #x_value <- input$chooseplot

  })
  
  
})
  


