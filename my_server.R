library("shiny")
library("ggplot2")
source("analysis.R")

my_server <- function(input, output) {
  # world_emissions_map <- renderLeaflet({
  #   
  # })
  
output$countries_emissions_plot <- renderPlot( 
  ggplot() +
    geom_line(data = filter(emissions_data, Nation == "AFGHANISTAN"),
              mapping = aes(x = Year,
                            y = Per.capita.CO2.emissions..metric.tons.of.carbon.,
                            group = 1), color = "blue") +
    geom_line(data = filter(emissions_data, Nation == "ALBANIA"),
              mapping = aes(x = Year,
                            y = Per.capita.CO2.emissions..metric.tons.of.carbon.,
                            group = 1), color = "red") +
    labs(
      title = "Emissions of Nation",
      x = "Year",
      y = "Emissions Per Capita"
    )
)
}
