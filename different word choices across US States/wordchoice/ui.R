

library(shiny)
library(readr)


load("question_data.RData")
question = quest.use

shinyUI(fluidPage(
  
  #  Application title
  titlePanel("States vs word choices"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(
      # Simple integer interval
      selectInput("question", "Question:",
                  choices = question$quest),
 
      submitButton("Submit")
    
      ),
    
    
    mainPanel(
      plotOutput("Plot")
    )
  )
))
