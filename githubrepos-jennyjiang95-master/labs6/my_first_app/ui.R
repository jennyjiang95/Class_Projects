
###ui.R

library(shiny)

## The widgets that were used were: `fileInput`, `selectInput`, and `sliderInput`.
## You'll also need the `helpText` function to create the help message.
## You can peak into the `rmd` file if you get stuck, but try to do it on your own.



shinyUI(fluidPage(
  titlePanel("Occupancy Rates in Berkeley"),
  
  sidebarLayout(
    sidebarPanel(
    #helptext
    helpText("upload an XML file with the Census Data to get started."),
    
    #file input
    fileInput("file", label= "File Input" ),
    
    #passswordInput
    passwordInput("password", 
                  label="Please enter your password"),
    
    #select input
    selectInput("neigh", 
                label = "Choose the neighborhood to inspect",
                choices = list("North Berkeley", 
                               "Rockridge",
                               "Downtown Berkeley", 
                               "Berkeley Hills",
                               "Oakland",
                               "Pokémon Stop"),
                selected = "Pokémon Stop"),
    
    #slider input
    sliderInput("occupancy", 
                label = "Number of People in Household:",
                min = 0, max = 40, value = c(0, 40))
    ),
   
    mainPanel(
      textOutput("text1"),
      textOutput("text2")
    )
  )
    
  
))


