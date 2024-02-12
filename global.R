
# ------------------------------------------------------------------------------
# Import R packages needed for the app here:
# ------------------------------------------------------------------------------
library(shiny)
library(shinycssloaders)
library(DT)
library(reticulate)

# -- source code
source("./reticulate/pythonConnector_UI.R")
source("./reticulate/pythonConnector_Server.R")
