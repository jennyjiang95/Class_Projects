
# load other packages
library(shiny)
library(dplyr)
library(readr)
library(ggvis)

cleaned <- read_csv("cleaned_demographics.csv")
names(cleaned) <- c ("No", "Country", "Year", "GDP_per_capita", "Life_Expectancy", "Total_Population", "Group")

##Problems:
#1. add_legend
#2. scale
#4. change size of the point 

shinyServer(function(input, output) {
  
  ddata <- reactive ({na.omit(cleaned[cleaned$Year == input$integer,])})
  
  ddata %>% 
    ggvis(key := ~Country) %>% 
    layer_points(x = ~GDP_per_capita, 
                 y = ~Life_Expectancy,
                 size = ~ Total_Population,
                 fill = ~Group,
                 opacity := 0.7) %>% 
    add_legend(c("fill", "size")) %>% 
    add_axis("x", 
             title = "GDP Per Capita (Inflation-Adjusted)",
             properties = axis_props(
               ticks = list(tension= c(20,100),strokeWidth = 2),
               labels = list(align = "left", fontSize = 10)
             )
             ) %>% 
    add_axis("y", 
             title = "Life Expectancy Birth",
             properties = axis_props(
               ticks = list(strokeWidth = 2),
               labels = list(fontSize = 10)
             )
             ) %>%
    add_tooltip (function(data){paste0("Country: ", data$Country, "<br>",
                                       "GDP_per_capita: ", data$GDP_per_capita, "<br>",
                                      "Life Expectancy: ", data$Life_Expectancy, "<br>", 
                                      "Total Population: ", data$Total_Population, "<br>",
                                      "Group: ", data$Group)}, 
                "hover") %>%
    scale_numeric("y", domain = c(10, 100), nice = F) %>% 
    scale_numeric("x", domain = c(300, 100000), trans = "log", expand = 0) %>% 
    bind_shiny("ggvis", "ggvis_ui")
  

})

