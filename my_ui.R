library("shiny")
library("markdown")

background <- tabPanel(
  "Background",
  mainPanel(includeMarkdown("welcome.md"))
)

conclusion <- tabPanel(
  "Conclusion",
  mainPanel(p("Conclusion"))
)

about_us <- tabPanel(
  "About Us",
  mainPanel(includeMarkdown("about_us.md"))
)

visualizations <- tabPanel(
  "Visualizations",
  mainPanel(
    tabPanel(
      "Plot",
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            inputId = "yr_range",
            label = "Year range",
            min = 1751,
            max = 2014,
            value = c(1751, 2014),
            sep = "",
          ),
          # Make this checkbox group drop down, save space
          # if user is not using the filter
          checkboxGroupInput(
            inputId = "checked_countries",
            label = "Countries",
            choices = c("United States", "China", "United Kingdom")
          )
        ),
        mainPanel(
          h3("CO2 emissions per capita of select countries"),
          plotOutput("countries_emissions_plot")
        )
      )
    ),
    tabPanel(
      "Map",
      sidebarLayout(
        sidebarPanel(
          # sliderInput(
          #   inputId = "yr",
          #   label = "Year",
          #   min = 1751,
          #   max = 2014,
          #   value = 2014,
          #   sep = "",
          # )
          selectInput(
            inputId = "yr",
            label = "Year",
            choices = c(1751:2014),
            selected = 2014
          )
        ),
        mainPanel(
          h3("Map of CO2 emissions of countries"),
          p("map goes here"),
          plotOutput("world_emissions_map")
        )
      )
    )
  )
)

visTab <- tabPanel("Visualizations", visualizations)

my_ui <- fluidPage(
  navbarPage(
    "World Nation Carbon Emissions Data Report",
    background,
    visTab,
    conclusion,
    about_us
  )
)
