
library(shiny)
library(ggplot2)
library(PKPDmisc)

shinyUI(navbarPage("Navbar",
  tabPanel("Upload Dataset",
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('has_header', 'Header', TRUE),
      checkboxInput('has_units', 'Has Units', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    ),
    mainPanel(
      tableOutput('contents')
    )
  )
))
)

