
library(shiny)
library(ggplot2)
library(PKPDmisc)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    sliderInput("Terminal Observations",
                "Number of Terminal Observations:",
                min = 1,
                max = 50,
                value = 30)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
))
