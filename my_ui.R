library("shiny")
library("plotly")
library("markdown")

background <- tabPanel(
  "Background",
  mainPanel(includeMarkdown("welcome.md"))
)

conclusion <- tabPanel(
  "Conclusion",
  mainPanel(includeMarkdown("conclusion.md"))
)

about_us <- tabPanel(
  "About Us",
  mainPanel(includeMarkdown("about_us.md"))
)

linePlot <- tabPanel(
      "Line Plot",
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            inputId = "yr_range",
            label = "Year range",
            min = 1950,
            max = 2014,
            value = year_range,
            sep = ""
          ),
          # checkboxInput(
          #   inputId = select_all,
          #   label = "Select All",
          #   value = F,
          # ),
          checkboxGroupInput(
            inputId = "checked_countries",
            label = "Countries",
            choices = country_list,
            selected = "UNITED STATES OF AMERICA"
          )
        ),
        mainPanel(
          h3("CO2 emissions per capita of select countries"),
          plotOutput("countries_emissions_plot")
        )
      )
    )

map_tab <- tabPanel(
  "Map",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "yr",
        label = "Year",
        choices = year_range,
        selected = 2014
      )
    ),
    mainPanel(
      plotlyOutput("emissions_map")
    )
  )
)

my_ui <- fluidPage(
  navbarPage(
    "World Nation Carbon Emissions Data Report",
    background,
    linePlot,
    map_tab,
    conclusion,
    about_us
  )
)
