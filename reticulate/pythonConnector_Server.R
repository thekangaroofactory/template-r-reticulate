

# ------------------------------------------------------------------------------
# Python connector module server
# ------------------------------------------------------------------------------
# 
# This module is meant to be called from the main server
# 
# Dependencies:
# -------------
# library(shiny)
# library(reticulate)
# >> make sure both are managed at main app level


# ------------------------------------------------------------------------------
# Initialization:
# ------------------------------------------------------------------------------

# -- Define any Python packages needed for the app here:
PYTHON_DEPENDENCIES <- c('pip', 'numpy')

# -- Get environment variables
virtualenv_dir <- Sys.getenv('VIRTUALENV_NAME')
python_path <- Sys.getenv('PYTHON_PATH')


# ------------------------------------------------------------------------------
# SERVER LOGIC
# ------------------------------------------------------------------------------

pythonConnector_Server <- function(id, script_path, file = NULL) {
  moduleServer(id, function(input, output, session) {
    
    # -- Get namespace
    ns <- session$ns
    
    
    # ----------------------------------------------------------------------------
    # Python environments setup 
    # ----------------------------------------------------------------------------
    
    # check user
    if (Sys.info()[['user']] %in% c('shiny', 'rstudio-connect')){
      
      # -- Running on Remote Server
      # Create virtual env and install dependencies
      reticulate::virtualenv_create(envname = virtualenv_dir, python = python_path)
      reticulate::virtualenv_install(virtualenv_dir, packages = PYTHON_DEPENDENCIES, ignore_installed=TRUE)
      reticulate::use_virtualenv(virtualenv_dir, required = T) 
      
    } else {
      
      # -- Running locally
      cat("Running on local machine [user] =", Sys.info()[['user']], "\n")
      
      # Setup anaconda env
      use_condaenv(condaenv = virtualenv_dir, conda = "auto", required = FALSE)
      
    }
    
    
    # ----------------------------------------------------------------------------
    # Source external Python code
    # ----------------------------------------------------------------------------
    
    # log
    cat("Python function import into: ")
    str(globalenv())
    
    # source script
    source_python("python_functions.py", envir = globalenv())
    
    
    # ----------------------------------------------------------------------------
    # Build outputs with python info
    # ----------------------------------------------------------------------------
    
    # Display info about the system running the code
    output$sysinfo <- DT::renderDataTable({
      s = Sys.info()
      df = data.frame(Info_Field = names(s),
                      Current_System_Setting = as.character(s))
      return(datatable(df, rownames = F, selection = 'none',
                       style = 'bootstrap', filter = 'none', options = list(dom = 't')))
    })
    
    # Display system path to python
    output$which_python <- renderText({
      paste0('Python path: ', Sys.which('python'))
    })
    
    # Display Python version
    output$python_version <- renderText({
      rr = reticulate::py_discover_config(use_environment = 'python35_env')
      paste0('Python version: ', rr$version)
    })
    
    
    # --------------------------------------------------------------------------
    # *** END SERVER ***
    # --------------------------------------------------------------------------
  })
}


