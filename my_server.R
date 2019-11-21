library("shiny")
library("leaflet")
library("ggplot2")
library("ggmap")

source("analysis.R")

my_server <- function(input, output) {
  
  output$world_emissions_map <- renderPlot({
  #   ggplot(world_map) +
  #     geom_polygon(
  #       mapping = aes(x = long, y = lat, group = group),
  #       color = "white",
  #       size = .1
  #     ) +
  #     coord_map()
    
  #   blank_theme <- theme_bw() +
  #     theme(
  #       axis.line = element_blank(),        # remove axis lines
  #       axis.text = element_blank(),        # remove axis labels
  #       axis.ticks = element_blank(),       # remove axis ticks
  #       axis.title = element_blank(),       # remove axis titles
  #       plot.background = element_blank(),  # remove gray background
  #       panel.grid.major = element_blank(), # remove major grid lines
  #       panel.grid.minor = element_blank(), # remove minor grid lines
  #       panel.border = element_blank()      # remove border around plot
  #     )
  #   
  #   ggplot(world_map_joined) +
  #     geom_polygon(
  #       mapping = aes(x = long, y = lat, group = group, fill = co2_per_capita),
  #       color = "white",
  #       size = .1
  #     ) +
  #     coord_map() +
  #     scale_fill_continuous(low = "#132B43", high = "Red") +
  #     labs(fill = "CO2 emissions per capita") +
  #     blank_theme
  })
  
  # countries_emissions_plot <- renderPlot({
  #   
  # })
}
