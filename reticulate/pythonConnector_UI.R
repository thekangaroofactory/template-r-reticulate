


# -- where to find active python
which_python_UI <- function(id){
  
  # namespace
  ns <- NS(id)
  
  # build output
  verbatimTextOutput(ns('which_python'))
  
}


# -- python version
python_version_UI <- function(id){
  
  # namespace
  ns <- NS(id)
  
  # build output
  verbatimTextOutput(ns('python_version'))
  
}


# -- system info table
sysinfo_UI <- function(id){
  
  # namespace
  ns <- NS(id)
  
  # build output
  withSpinner(DT::dataTableOutput(ns("sysinfo")))
  
}



