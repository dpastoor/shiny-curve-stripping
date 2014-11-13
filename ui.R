
library(shiny)
library(ggplot2)
library(PKPDmisc)
shinyUI(navbarPage("Navbar",
  tabPanel("Upload Dataset",
    fluidPage(
      fluidRow(
        column(4,
        h4("1. Upload CSV file"),
        fileInput('file1', 'Choose CSV File',
                  accept=c('text/csv', 
                           'text/comma-separated-values,text/plain', 
                           '.csv')),
        h6("optional csv customizations"),
        p("Use these if the preview after uploading is showing that your data is not read in correctly"),
        checkboxInput('has_header', 'Header', TRUE),
        checkboxInput('has_units', 'Has Units', FALSE),
        radioButtons('sep', 'Separator',
                     c(Comma=',',
                       Semicolon=';',
                       Tab='\t'),
                     ','),
        radioButtons('quote', 'Quote',
                     c(None='',
                       'Double Quote'='"',
                       'Single Quote'="'"),
                     '"'),
        tags$hr()),
        column(4,
        h4("2. Select data columns"),
        selectInput('x', 'X (eg. time)', NULL, "TIME" ),
        selectInput('y', 'Y (eg. COBS or DV)', NULL, "DV"),
        selectInput('dose', 'DOSE', NULL, "DOSE"),
        h5("Be sure all dropdowns are associated with a column in the dataset 
           after uploading")
      ),
      column(4, 
             h4("3. Preview Uploaded Data"),
             tableOutput('contents')
             
      ))

      
    )
  ),
  tabPanel("Curve Stripping",
           fluidPage(
             titlePanel("Curve Stripping"),
               plotOutput("plot"),
               fluidRow(
                 column(4,
                        h4("Set # terminal points"),
                        sliderInput('num_term_pts', 'Number of Terminal Points', 
                                    min=3, max=20,
                                    value=5, 
                                    step=1),
                        h5("Set Plot Attributes"),
                        checkboxInput('point', 'Point', value = TRUE),
                        checkboxInput('line', 'Line'),
                        checkboxInput('log_y', 'log Y scale', value = TRUE),
                        sliderInput('point_size', 'Point Size', 
                                    min=0.5, max=5,
                                    value=3, 
                                    step=0.2),
                        sliderInput('line_size', 'Line Size', 
                                    min=0.5, max=5,
                                    value=1, 
                                    step=0.2)

                 ), 
                 column(5,
                        h3("Recommended Initial Estimates"),
                        tableOutput("initial_estimates")
                        )
                 
               )
             )
          
)
)
)


