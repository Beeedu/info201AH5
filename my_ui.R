library("shiny")

background <- tabPanel(
  "Background",
  mainPanel(p("Read this from a .txt file?"))
)

conclusion <- tabPanel(
  "Conclusion",
  mainPanel(p("Read this from a .txt file?"))
)

about_us <- tabPanel(
  "About Us",
  mainPanel(p("Read this from a .txt file?"))
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
            choices = emissions_data$Nation %>% unique(),
            selected = "UNITED STATES OF AMERICA"
          )
        ),
        mainPanel(
          h3("Plot title"),
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
          h3("Map title"),
          p("Map would go here"),
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
