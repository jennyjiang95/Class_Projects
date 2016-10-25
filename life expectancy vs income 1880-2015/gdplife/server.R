

library(shiny)
library(dplyr)
library(ggplot2)
library(readr)

graph <- read_csv("cleaned_demographics.csv")
names(graph) <- c ("No", "Country", "Year", "GDP_per_capita", "Life_Expectancy", "Total_Population", "Group")

#(list) object cannot be coerced to type 'integer'
#str(graph)
shinyServer(function(input, output) {
  

 #1. set manually break
 #2. log transformation
 #3. change size option 1-7. 1-20
 #4. abs

  output$Plot <- renderPlot({
    
    selected_year <- input$integer
    
    ggplot(na.omit(subset(graph, Year== selected_year))) + 
      geom_point(aes_string(x = "GDP_per_capita", 
                     y = "Life_Expectancy", 
                     fill = "Group",
                     size = "Total_Population"),
                 color = "black", alpha = 0.8, shape = 21)+
      scale_size_area(max_size=20)+
      scale_size_continuous(range = c(1,20))+
    labs(title = selected_year,
         x = "GDP Per Capita (Inflation-Adjusted)",
         y = "Life Expectancy Birth")+
    scale_x_log10(limits = c(500,100000), 
                  breaks = c(500,5000,50000),
                  labels = c("$500", "$5000", "$50000"))+
      scale_y_continuous(limits = c(20,80),
                         breaks = seq(25,75,25),
                         labels= c("25" = "25 \nyears", 
                                  "50" = "50 \nyears",
                                  "75" = "75 \nyears")) +
      theme (axis.text=element_text(size=15),
             axis.title=element_text(size=15)) +
    guides (size = FALSE, alpha = FALSE)
  })
    

})
