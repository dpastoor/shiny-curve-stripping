
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#
library(shiny)
library(ggplot2)
library(PKPDmisc)
library(dplyr)
shinyServer(function(input, output, session) {

  
  
  dataset <- reactive({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)  
    if(!is.null(inFile)) {
      if(input$has_units) {
        data <-  read_csv_wunits(inFile$datapath, sep=input$sep, 
                                 quote=input$quote)
      } else {
        data <-  read.csv(inFile$datapath, header=input$has_header, sep=input$sep, 
                          quote=input$quote)
      }
      return(data)
    }
  })
  
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)  
    if(!is.null(inFile)) {
      if(input$has_units) {
        data <-  read_csv_wunits(inFile$datapath, sep=input$sep, 
                                 quote=input$quote)
      } else {
        data <-  read.csv(inFile$datapath, header=input$has_header, sep=input$sep, 
                          quote=input$quote)
      }
      return(data)
    }

    
    
    
  })
  
  observe({
    #not positive if observed needed but based on googling around and it works
    # http://stackoverflow.com/questions/20073948/observe-updateselectinput-based-on-first-selection
    if(!is.null(dataset)) {
      updateSelectInput(session, 'x', 'X', names(dataset()), "TIME" )
      updateSelectInput(session, 'y', 'Y', names(dataset()), "COBS")
      updateSelectInput(session, 'dose', 'DOSE', names(dataset()), "DOSE")
     }
  })

  

  
  output$plot <- renderPlot({
    if(is.null(dataset)) return(NULL)
    data <- dataset()
    data <- data[data[[input$y]] > 0,] # TODO: change to give user option to filter or change to small value
    
    ### for terminal slope plotting ---------------
    time <- data[[input$x]]
    num_time_points <- length(time)
    #check to make sure partial time legit option
    ###need to add warning
    start_terminal_points <- num_time_points - input$num_term_pts + 1
    
    
    terminal_data<-data[start_terminal_points:num_time_points,]

    
    ### plot ----------
    p <- ggplot(data, aes_string(x=input$x, y=input$y))
    
    if (input$point)
      p <- p + geom_point(size = input$point_size)
    if (input$line)
      p <- p + geom_line(size = input$line_size)
      
    if (input$log_y)
      p <- p + scale_y_log10()
    
    p <- p + geom_smooth(data = terminal_data, method='lm', formula = y~x, se=F, size = 2)  
    print(p + base_theme_obs())
   
  })
  output$initial_estimates <- renderTable({
    if(is.null(dataset)) return(NULL)
    data <- dataset()
    data <- data[data[[input$y]] > 0,] # TODO: change to give user option to filter or change to small value
    strip_curves(data[[input$x]], data[[input$y]], data[[input$dose]],number_terminal_points = input$num_term_pts)
  })
  
})

