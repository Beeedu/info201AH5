# This document is where data wrangling will take place.

# Function to get started with a fresh data frame.
get_emissions_data <- function() {
  read.csv("co2-emissions-by-nation.csv", stringsAsFactors = FALSE)
}
