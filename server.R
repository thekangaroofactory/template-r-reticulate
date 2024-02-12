
# ------------------------------------------------------------------------------
# Application server
# ------------------------------------------------------------------------------

shinyServer(function(input, output) {
  

  # ----------------------------------------------------------------------------
  # -- Start Python connector server
  
  pythonConnector_Server("python", script_path = "./", file = "python_functions.py")
  
  # ----------------------------------------------------------------------------
  

  # Test that the Python functions have been imported
  output$message <- renderText({
    return(test_string_function(input$str))
  })

    
  # Test that numpy function can be used
  output$xy <- renderText({
    z = test_numpy_function(input$x, input$y)
    return(paste0('x + y = ', z))
  })
  
})