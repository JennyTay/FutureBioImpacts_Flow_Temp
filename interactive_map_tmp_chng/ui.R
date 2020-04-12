#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("streams"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h1("select the variable"),
       selectInput("select", label = h3("select box"),
                   choices = list("max" = 1,
                                  "min" = 2,
                                  "avg" = 3),
                   selected = 1)),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Change with elevation"),
       plotOutput("plot")
    )
  )
))
