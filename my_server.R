library("shiny")
# library("leaflet")
library("ggplot2")
# library("ggmap")

source("analysis.R")

my_server <- function(input, output) {

  # output$world_emissions_map <- renderPlot({
  # #   ggplot(world_map) +
  # #     geom_polygon(
  # #       mapping = aes(x = long, y = lat, group = group),
  # #       color = "white",
  # #       size = .1
  # #     ) +
  # #     coord_map()
  # 
  # #   blank_theme <- theme_bw() +
  # #     theme(
  # #       axis.line = element_blank(),        # remove axis lines
  # #       axis.text = element_blank(),        # remove axis labels
  # #       axis.ticks = element_blank(),       # remove axis ticks
  # #       axis.title = element_blank(),       # remove axis titles
  # #       plot.background = element_blank(),  # remove gray background
  # #       panel.grid.major = element_blank(), # remove major grid lines
  # #       panel.grid.minor = element_blank(), # remove minor grid lines
  # #       panel.border = element_blank()      # remove border around plot
  # #     )
  # #
  # #   ggplot(world_map_joined) +
  # #     geom_polygon(
  # #       mapping = aes(x = long, y = lat, group = group, fill = co2_per_capita),
  # #       color = "white",
  # #       size = .1
  # #     ) +
  # #     coord_map() +
  # #     scale_fill_continuous(low = "#132B43", high = "Red") +
  # #     labs(fill = "CO2 emissions per capita") +
  # #     blank_theme
  # })
<<<<<<< HEAD
  
  output$countries_emissions_plot <- renderPlot({
    
    # checked <- input$checked_countries
    # 
    # emissions_data <- emissions_data %>%
    #   filter(Nation == checked)
    
    emissions_data <- emissions_data %>%
      rename(co2_per_capita = "Per.capita.CO2.emissions..metric.tons.of.carbon.")
    
    
    emissions_data <- emissions_data[emissions_data$Year%in%seq(input$yr_range[1], input$yr_range[2], by = 1),]
    emissions_data <- emissions_data[emissions_data$Nation%in%input$checked_countries,]
      
    ggplot() +
      geom_line(data = emissions_data,
                mapping = aes(x = Year,
                              y = co2_per_capita,
                              group = Nation,
                              color = Nation)
                ) +
      labs(
        title = "Emissions of Nation",
        x = "Year",
        y = "Emissions Per Capita"
      )
    
  })
=======

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
>>>>>>> dc6a4428e531ce1769fec2f946c6f7abc219d51f
}

