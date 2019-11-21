library("ggplot2")
library("dplyr")
library("rvest")
library("magrittr")
library("ggmap")
library("stringr")
library("maps")
library("mapproj")

# This document is where data wrangling will take place.

# Function to get started with a fresh data frame.
get_emissions_data <- function() {
  read.csv("co2-emissions-by-nation.csv", stringsAsFactors = FALSE)
}

# Map

# Select the relevant data
map_df <- get_emissions_data() %>%
  rename(co2_per_capita = "Per.capita.CO2.emissions..metric.tons.of.carbon.") %>%
  select(Nation, Year, co2_per_capita)
map_df <- map_df[4:nrow(map_df),]

# Create the map
world_map <- map_data("world")

# Inspect
map_df %>%
  select(Nation) %>%
  as.factor() %>%
  levels()

world_map %>%
  select(region) %>%
  as.factor() %>%
  levels()

# Change country names so they match between the data and the map
world_map <- world_map %>%
  mutate_all(.funs = toupper)

map_df$Nation <- map_df$Nation %>%
  recode(
    'UNITED STATES OF AMERICA' = 'USA',
    'UNITED KINGDOM' = 'UK',
    'VIET NAM' = 'VIET NAM',
    'REPUBLIC OF KOREA' = 'SOUTH KOREA',
    'WALLIS AND FUTUNA ISLANDS' = 'WALLIS AND FUTUNA'
  )

# Join the two sets of data
world_map_joined <- left_join(world_map, map_df, by = c('region' = 'Nation'))
#
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

ggplot(world_map_joined) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = co2_per_capita),
    color = "white",
    size = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "CO2 emissions per capita") +
  blank_theme


# Line graph
line_graph <- ggplot() +
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

line_graph

# # Summary Table
# get_emissions_summary_table <- emissions_data %>%
#   group_by(Nation) %>%
#   summarise(total_emissions = sum(Per.capita.CO2.emissions..metric.tons.of.carbon., na.rm = TRUE)
#             )
#
# View(get_emissions_summary_table)
#
# # Bar Graph
# top_15_nations_emission <- emissions_data %>%
#   mutate(total_emissions = sum(Per.capita.CO2.emissions..metric.tons.of.carbon., na.rm = TRUE)) %>%
#   arrange(-total_emissions) %>%
#   top_n(15)
# plot <- ggplot(top_15_nations_emission) +
#   geom_col(mapping = aes(x = Nation, y = total_emissions)) +
#   coord_flip() +
#   labs(
#     title = "Top 15 emission nations",
#     x = "Nation",
#     y = "Total Emissions"
#   )
#
# plot
#
# # interactive map
# nations_emission_interactive_map <- leaflet(data = emissions_data) %>%
#   addProviderTiles("CartoDB.Positron") %>%
#   setView(lng = 150, lat = 45, zoom = 7) %>%
#   addCircleMarkers(
#     lat = ~lat,
#     lng = ~long,
#     stroke = FALSE,
#     popup = ~paste0("Year: ", Year, "<br>",
#                     "Nation: ", Nation, "<br>",
#                     "Emissions Per Capita: ", Per.capita.CO2.emissions..metric.tons.of.carbon.),
#     radius = ~ (Per.capita.CO2.emissions..metric.tons.of.carbon.),
#     fillOpacity = 0.5,
#   )
#
# nations_emission_interactive_map
