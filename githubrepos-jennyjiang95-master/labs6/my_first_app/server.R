
##server.R

library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  
  output$text1 <- renderText({ 
    paste("You have selected", input$neigh, "as your neighborhood.", sep = " ")
  })
  output$text2 <- renderText({ 
    paste("You are interested in houses where",
          input$occupancy[1], "to", input$occupancy[2],
          "people live.", sep = " ")
  })
  
})
  

vignette("nse")


