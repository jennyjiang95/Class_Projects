

library(shiny)
library(dplyr)
library(stringr)
library(ggplot2)
library(readr)


cleaned <- read_csv("cleaned.csv")
names(cleaned) <- c("number","quest","ans","n","long","lat","group")


shinyServer(function(input, output) {
  
  output$Plot <- renderPlot({
      
    cleaned1 <- cleaned %>% 
      filter(quest == input$question)
    
    ggplot(cleaned1) + 
      geom_polygon(aes_string(x = "long", y = "lat", fill = "ans", group = "group"), 
                   color = "black") + 
      coord_fixed(1.3)+
      scale_fill_discrete(labels = function(x) str_wrap(x, width = 20))+
      labs(title = input$question)
    
  })
  
})
