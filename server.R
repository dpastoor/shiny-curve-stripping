
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyServer(function(input, output) {
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    if(input$has_units) {
      read_csv_wunits(inFile$datapath, sep=input$sep, 
               quote=input$quote)
      } else {
        read.csv(inFile$datapath, header=input$has_header, sep=input$sep, 
            quote=input$quote)
  }
  })
  
})
