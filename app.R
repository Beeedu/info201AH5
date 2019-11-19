# File for Shiny application.

source("analysis.R")
source("my_ui.R")
source("my_server.R")

library("shiny")

shinyApp(ui = my_ui, server = my_server)