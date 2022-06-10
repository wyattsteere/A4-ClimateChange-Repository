library(plotly)
library("rsconnect")
library("bslib")
library("shinythemes")
# Load climate data
climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)



# Home page tab
intro_side_tab <- sidebarPanel(
  # Title of tab
  "Introduction",
  fluidPage(theme = shinytheme("simplex"),
  includeMarkdown("C:/Users/wyatt/Dropbox/PC/Documents/A4 Climate Change/DatasetSummary"),
  )
)
main_panel_table <- mainPanel(
  "Summary",
  includeMarkdown("C:\Users\wyatt\Dropbox\PC\Documents\A4 Climate Change\5 Relevant Values"),
  h2("co2 Table"),
  dataTableOutput(outputId = "co2_table_1970"),
  h2("Sint Maarten Plot"),
  plotlyOutput(outputId = "sint_maarten_plot")
)
intro_tab <- tabPanel(
  "Intro Tab",
  sidebarLayout(
    intro_side_tab,
    main_panel_table
  )
)
# We want our next tab to have a sidebar layout
# So we're going to create a sidebarPanel() and a mainPanel() and then add them together

# Create sidebar panel for widget
sidebar_panel_widget <- sidebarPanel(
  checkboxGroupInput(
    inputId = "user_selection",
    label = "Countries",
    choices = c("United States", "China", "World"),
    # True allows you to select multiple choices
    selected = "United States" 
  ),
  sliderInput(inputId = "year_selection",
              label = h3("Slider"),
              min = min(climate_df$year),
              max = max(climate_df$year),
              sep = "",
              value = c(2010, 2020)
              )
)

# Put a plot in the middle of the page
main_panel_plot <- mainPanel(
  #  plotOutput(outputId = "climate_plot")
  # Make plot interactive
  includeMarkdown("C:/Users/wyatt/Dropbox/PC/Documents/A4 Climate Change/CountryVisualization"),
  plotlyOutput(outputId = "climate_plot")
  
)

# Plot Tab  - combine sidebar panel and main panel
climate_tab <- tabPanel(
  "Climate Viz",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot
  )
)


ui <- navbarPage(
  # Home page title
  "Climate Change",
  intro_tab,
  climate_tab
)
