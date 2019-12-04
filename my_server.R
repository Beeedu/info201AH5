library("shiny")
library("ggplot2")
source("analysis.R")

my_server <- function(input, output) {
  # world_emissions_map <- renderLeaflet({
  #   
  # })
  
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
}

