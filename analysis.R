library(ggplot2)
library(dplyr)

# This document is where data wrangling will take place.

# Function to get started with a fresh data frame.
get_emissions_data <- function() {
  read.csv("co2-emissions-by-nation.csv", stringsAsFactors = FALSE)
}
View(get_emissions_data())

emissions_data <- get_emissions_data()

# Line graph
Particular_nation <- filter(emissions_data, Nation == "AFGHANISTAN")

line_graph <- ggplot(data = Particular_nation, mapping = 
              aes(x = Year, y = Per.capita.CO2.emissions..metric.tons.of.carbon.), na.rm = TRUE) +
  geom_point() +
  geom_step() +
  labs(
    title = "Emissions of Nation",
    x = "Year",
    y = "Emissions Per Capita"
  )

line_graph

# Summary Table
get_emissions_summary_table <- get_emissions_data() %>%
  group_by(Nation) %>%
  summarise(total_emissions = sum(Per_capita_CO2_emissions, na.rm = TRUE)
            )

View(get_emissions_summary_table)

# Bar Graph
top_15_nations_emission <- get_emissions_data() %>%
  mutate(total_emissions = sum(Per_capita_CO2_emissions, na.rm = TRUE)) %>%
  arrange(-total_emissions) %>%
  top_n(15)
plot <- ggplot(top_15_nations_emission) +
  geom_col(mapping = aes(x = Nation, y = total_emissions)) +
  coord_flip() +
  labs(
    title = "Top 15 emission nations",
    x = "Nation",
    y = "Total Emissions"
  )

plot

# interactive map
nations_emission_interactive_map <- leaflet(data = get_emissions_data()) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = 150, lat = 45, zoom = 7) %>%
  addCircleMarkers(
    lat = ~lat,
    lng = ~long,
    stroke = FALSE,
    popup = ~paste0("Year: ", Year, "<br>",
                    "Nation: ", Nation, "<br>",
                    "Emissions Per Capita: ", Per_capita_CO2_emissions),
    radius = ~ (Per_capita_CO2_emissions),
    fillOpacity = 0.5,
  )

nations_emission_interactive_map