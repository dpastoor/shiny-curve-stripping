
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
  ),
  tabPanel("Initial Estimates",
           fluidPage(
             titlePanel("Test"),
               plotOutput("plot"),
               fluidRow(
                 column(3,
                        h4("PKPD Explorer"),
                        checkboxInput('point', 'Point', value = TRUE),
                        checkboxInput('line', 'Line'),
                        checkboxInput('log_y', 'log Y scale', value = FALSE),
                        sliderInput('point_size', 'Point Size', 
                                    min=0.5, max=5,
                                    value=2, 
                                    step=0.2),
                        sliderInput('line_size', 'Line Size', 
                                    min=0.5, max=5,
                                    value=1, 
                                    step=0.2)
                 ),
                 column(4, offset = 1,
                        selectInput('x', 'X', names(ui_data), "TIME" ),
                        selectInput('y', 'Y', names(ui_data), "COBS")
                 )
               )
             )
          
)
)
)

