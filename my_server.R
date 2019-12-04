library("shiny")
library("leaflet")
library("ggplot2")
library("plotly")
library("stringr")
library("dplyr")

source("analysis.R")

my_server <- function(input, output) {

  output$emissions_map <- renderPlotly({

    map_df <- map_df %>% filter(Year == input$yr)

    # Join the two sets of data
    world_map_joined <- left_join(world_map, map_df, by = 'region')

    # Plot the data
    emissions_map <- ggplot(
      data = world_map_joined,
      aes(x = long, y = lat, group = group, text = region, fill = co2)
    ) +
      geom_polygon(color = "white", size = .5) +
      scale_fill_continuous(low = "Green", high = "Red") +
      labs(
        title = paste("CO2 emissions of nations worldwide in ", input$yr, sep = ""),
        fill = "Metric tons of CO2 per capita",
        x = "Longitude",
        y = "Latitude"
      )

    emissions_map <- ggplotly(emissions_map, height = 700, width = 1250)

    emissions_map
  })

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
