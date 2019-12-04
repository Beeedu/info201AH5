library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")

source("analysis.R")

my_server <- function(input, output) {

  output$emissions_map <- renderPlotly({

    map_df <- map_df %>% filter(Year == input$yr)

    # Join the two sets of data
    world_map_joined <- left_join(world_map, map_df, by = 'region')
    
    values <- map_df %>%
      filter(!is.na(co2)) %>%
      pull("co2")

    # Plot the data
    emissions_map <- ggplot(
      data = world_map_joined,
      aes(
        x = long,
        y = lat, 
        group = group,
        text = paste(region, "<br>CO2: ", co2, sep = ""),
        fill = co2
        )
    ) +
      geom_polygon(color = "white", size = .5) +
      # set breaks
      scale_fill_continuous(
        low = "Green",
        high = "Red",
        trans = "log",
        #breaks = seq(0, max(values), by = round(max(values) / 5, 0)   )
        breaks = seq(0, max(values), by = 4)
        ) +
      labs(
        title = paste(
          "CO2 emissions of nations worldwide in ",
          input$yr,
          sep = ""
          ),
        fill = "Metric tons of CO2 per capita",
        x = "Longitude",
        y = "Latitude"
      )

    emissions_map <- ggplotly(emissions_map, height = 700, tooltip = "text") %>%
      style(hoveron = "text")

    emissions_map
  })

  output$countries_emissions_plot <- renderPlot({
    
    emissions_data <- emissions_data %>%
      rename(co2_per_capita = "Per.capita.CO2.emissions..metric.tons.of.carbon.") %>%
      mutate(co2 = as.numeric(co2_per_capita))
    emissions_data <- emissions_data[emissions_data$Year %in% seq(input$yr_range[1], input$yr_range[2], by = 1), ]
    emissions_data <- emissions_data[emissions_data$Nation %in% input$checked_countries, ]
    
    
    ggplot() +
      geom_line(data = emissions_data,
                mapping = aes(x = Year,
                              y = co2,
                              group = Nation,
                              color = Nation)
      ) +
      labs(
        title = "Nation Emissions",
        x = "Year",
        y = "Metric tons of CO2 per capita"
      )
    })
}
