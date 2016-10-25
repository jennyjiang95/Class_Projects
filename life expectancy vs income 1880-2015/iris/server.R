
# load other packages
library(shiny)
library(dplyr)
library(readr)
library(ggvis)

graph <- read_csv("cleaned_demographics.csv")
names(graph) <- c ("No", "Country", "Year", "GDP_per_capita", "Life_Expectancy", "Total_Population", "Group")

# interactive server code
shinyServer(
  function(input, output) {
    
    # A reactive expression wrapper for input$integer
    inputyear <- reactive(input$integer)
    inputopacity <- reactive(input$opacity)
    
    #subset data set
    ddata <- na.omit(subset(graph, Year == 1800)) 
    
    #add hover layers
    all_values <- function(x) {
      if(is.null(x)) return(NULL)
      row <- ddata[ddata$GDP_per_capita == x$GDP_per_capita, ]
      paste0(names(row), ": ", format(row), collapse = "<br />")
    }
    
    ddata %>% 
      ggvis (x = ~GDP_per_capita, 
             y = ~ Life_Expectancy) %>% 
      layer_points (fill = ~ Group,
                    size = ~ Total_Population,
                    opacity := inputopacity) %>% 
      add_legend(c("size", "fill")) %>% 
      add_axis("x", 
               title = "GDP Per Capita (Inflation-Adjusted)") %>%
      add_axis("y", 
               title = "Life Expectancy Birth") %>% 
      add_tooltip(all_values,    #interact with the graph, hover. 
                  "hover") %>% 
      bind_shiny("ggvis",       # react with the ui
                 "ggvis_ui")

  })




