library("ggplot2")
library("dplyr")

# This document is where data wrangling will take place.

# Function to get started with a fresh data frame.
get_emissions_data <- function() {
  read.csv("co2-emissions-by-nation.csv", stringsAsFactors = FALSE)
}

year_range <- get_emissions_data() %>%
  rename(co2_per_capita = "Per.capita.CO2.emissions..metric.tons.of.carbon.") %>%
  filter(!is.na(as.numeric(co2_per_capita))) %>%
  arrange(Year) %>%
  select(Year)

year_range <- year_range[[1]] %>% unique()

# Map

# Select the relevant data
map_df <- get_emissions_data() %>%
  rename(co2_per_capita = "Per.capita.CO2.emissions..metric.tons.of.carbon.") %>%
  select(Nation, Year, co2_per_capita) 

# Create the map
world_map <- map_data("world")

map_df <- map_df[4:nrow(map_df),] %>% 
  mutate(region = Nation) %>%
  select(-Nation) %>%
  mutate(co2 = as.numeric(co2_per_capita))

map_df$region <- map_df$region %>% sapply(str_to_title)

# Recode country names (2014) to match the world map
map_df$region <- map_df$region %>%
  recode(
    'United States Of America' = 'USA',
    'United Kingdom' = 'UK',
    'Viet Nam' = 'Vietnam',
    'Democratic Republic Of The Congo (Formerly Zaire)' = 'Democratic Republic of the Congo',
    'Brunei (Darussalam)' = 'Brunei',
    'China (Mainland)' = 'China',
    'Libyan Arab Jamahiriyah' = 'Libya',
    'Republic Of South Sudan' = 'South Sudan',
    'Republic Of Sudan' = 'Sudan',
    'Bosnia & Herzegovina' = 'Bosnia and Herzegovina',
    'Republic Of Korea' = 'South Korea',
    'Democratic People S Republic Of Korea' = 'North Korea',
    'Italy (Including San Marino)' = 'Italy',
    'Islamic Republic Of Iran' = 'Iran',
    'Russian Federation' = 'Russia',
    'Plurinational State Of Bolivia' = 'Bolivia',
    'United Republic Of Tanzania' = 'Tanzania',
    'Myanmar (Formerly Burma)' = 'Myanmar',
    'Lao People S Democratic Republic' = 'Laos',
    'Republic Of Moldova' = 'Moldova',
    'France (Including Monaco)' = 'France',
    'Republic Of Cameroon' = 'Cameroon',
    'Cote D Ivoire' = 'Ivory Coast',
    'Timor-Leste (Formerly East Timor)' = 'Timor-Leste',
    'Syrian Arab Republic' = 'Syria',
    'Congo' = 'Republic of Congo'
  )

# Line graph
emissions_data <- get_emissions_data()

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
