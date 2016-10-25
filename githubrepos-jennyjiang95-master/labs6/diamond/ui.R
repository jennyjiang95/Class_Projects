
###ui.R

library(shiny)

## The widgets that were used were: `fileInput`, `selectInput`, and `sliderInput`.
## You'll also need the `helpText` function to create the help message.
## You can peak into the `rmd` file if you get stuck, but try to do it on your own.



shinyUI(fluidPage(
  titlePanel("Diamonds Data Graph"),
  
  sidebarLayout(
    sidebarPanel(
    #helptext
    helpText("Please choose the following and create a plot."),


    ## subset data before plotting
    # cut: Fair < Good < Very Good < Premium < Ideal
    # OR
    # color: D < E < F < G < H < I < J
    
    ## scatter plot price VS carat/depth/table
    
    #subset cut data
    checkboxGroupInput("choosecut", 
                label = "Choose the cut data",
                choices = list("Fair","Good","Very Good","Premium","Ideal"),
                selected = "Ideal"),
    
    ## subset color data
    checkboxGroupInput("choosecolor", 
                       label = "Choose the color data", 
                       choices = list("D", "E", "F","G", "H", "I", "J"),
                       selected = "E"),
    
    selectInput("chooseplot", 
                label = "Please choose the variable you would like to graph.", 
                choices = list("carat", "depth", "table"),
                selected = "carat"),
    
    submitButton("Submit")
    
    ),
    
  
    mainPanel(
      plotOutput("Plot")

    )
  )
    
  
))


