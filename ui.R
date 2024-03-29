
# ------------------------------------------------------------------------------
# UI
# ------------------------------------------------------------------------------

# Begin UI for the R + reticulate example app
ui <- fluidPage(
  
  titlePanel('Using R Shiny + reticulate'),
  
  sidebarLayout(
    
    # ---------------- Sidebar panel with changeable inputs ----------------- #
    sidebarPanel(
      
      h4('Inputs to Python functions called by reticulate'),
      textInput('str',
                'Text to display',
                value = 'This text is being printed by a Python function!'),
      numericInput('x',
                   'x value',
                   value = 1),
      numericInput('y',
                   'y value',
                   value = 2)
    ),
    
    # ---------------- Sidebar panel with changeable inputs ----------------- #
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = 'tabs',
                  tabPanel('Using R and Python functions',
                           h3('Outputs generated by Python functions via reticulate'),
                           verbatimTextOutput('message'),
                           br(),
                           'Use the numpy Python package to add two numbers',
                           verbatimTextOutput('xy')),
                  tabPanel('Architecture Info', 
                           h3('Current architecture info'),
                           '(These values will change when app is run locally vs on Shinyapps.io)',
                           hr(),
                           sysinfo_UI("python"),
                           br(),
                           which_python_UI("python"),
                           python_version_UI("python")
                           
                  )
      )
    )
  )
)