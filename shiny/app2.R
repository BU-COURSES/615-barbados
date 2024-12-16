# Shiny App for Barbados Analysis

library(shiny)
library(leaflet)
library(ggplot2)
library(plotly)
library(shinydashboard)
library(DT)
library(shinyWidgets)
library(highcharter)

# Load or simulate data for the app
barbados_data <- data.frame(
  year = 2010:2024,
  gdp = c(4.8, 4.9, 5.0, 5.1, 5.2, 5.2, 5.3, 5.4, 5.6, 5.7, 5.9, 5.9, 6.0, 6.1, 6.2),
  population = rep(287000, 15),
  tourism = c(1.5, 1.6, 1.7, 1.7, 1.8, 1.8, 1.9, 2.0, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6)
)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Barbados Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("chart-line")),
      menuItem("Key Facts", tabName = "key_facts", icon = icon("info-circle")),
      menuItem("Regional Comparison", tabName = "regional_comparison", icon = icon("globe")),
      menuItem("SWOT Analysis", tabName = "swot", icon = icon("balance-scale"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
              fluidRow(
                box(title = "Introduction", status = "info", solidHeader = TRUE, width = 12,
                    HTML(
                      "<p>Welcome to the Barbados Analysis App. This application provides detailed insights into Barbados, focusing on its economic performance, population trends, and tourism impact. The app also features a SWOT analysis to explore strengths, weaknesses, opportunities, and threats specific to the country.</p>
                       <p>Use the navigation menu to explore key facts, regional comparisons, and a detailed SWOT breakdown.</p>"
                    )
                )
              )
      )
    ),
    tabItem(tabName = "key_facts",
            fluidRow(
              box(title = "Key Facts about Barbados", status = "info", solidHeader = TRUE, width = 12,
                  HTML(
                    "<ul>
                        <li><b>Population:</b> Approximately 287,000 residents.</li>
                        <li><b>GDP:</b> $5.9 billion (2024).</li>
                        <li><b>Main Exports:</b> Sugar and rum.</li>
                        <li><b>Government:</b> Parliamentary democracy.</li>
                        <li><b>Tourism:</b> Major contributor to GDP, with 2.6 million visitors in 2024.</li>
                      </ul>"
                  )
              )
            )
    ),
    tabItem(tabName = "regional_comparison",
            fluidRow(
              box(title = "Regional Comparison", status = "success", solidHeader = TRUE, width = 12,
                  sliderInput("yearFilter", "Select Year Range:", min = 2010, max = 2024, value = c(2010, 2024)),
                  highchartOutput("regionalComparisonPlot", height = 400))
            )
    ),
    tabItem(tabName = "swot",
            fluidRow(
              column(6,
                     box(title = "SWOT Details", status = "warning", solidHeader = TRUE, width = 12,
                         HTML(
                           "<b>Strengths:</b>
                             <ul>
                               <li>Thriving tourism industry.</li>
                               <li>Stable government and political climate.</li>
                             </ul>
                             <b>Weaknesses:</b>
                             <ul>
                               <li>Small population size.</li>
                               <li>High dependence on external markets.</li>
                             </ul>
                             <b>Opportunities:</b>
                             <ul>
                               <li>Growth in renewable energy.</li>
                               <li>Development of the blue economy.</li>
                             </ul>
                             <b>Threats:</b>
                             <ul>
                               <li>Vulnerability to climate change.</li>
                               <li>Rising sea levels impacting infrastructure.</li>
                             </ul>"
                         )
                     )
              ),
              column(6,
                     box(title = "SWOT Analysis Chart", status = "warning", solidHeader = TRUE, width = 12,
                         highchartOutput("swotChart", height = 400))
              )
            )
    )
  )
)

# Define Server
server <- function(input, output, session) {
  
  # Render Regional Comparison Plot
  output$regionalComparisonPlot <- renderHighchart({
    filtered_data <- barbados_data %>%
      filter(year >= input$yearFilter[1], year <= input$yearFilter[2])
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_title(text = "Regional Comparison: GDP, Population, and Tourism") %>%
      hc_xAxis(categories = filtered_data$year, title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Values")) %>%
      hc_add_series(name = "GDP (Billion USD)", data = filtered_data$gdp, color = "#1f77b4") %>%
      hc_add_series(name = "Population (Millions)", data = filtered_data$population / 1e6, color = "#ff7f0e") %>%
      hc_add_series(name = "Tourism (Millions)", data = filtered_data$tourism, color = "#2ca02c")
  })
  
  # Render SWOT Chart
  output$swotChart <- renderHighchart({
    highchart() %>%
      hc_chart(type = "pie") %>%
      hc_title(text = "SWOT Analysis") %>%
      hc_series(list(
        name = "SWOT Categories",
        data = list(
          list(name = "Strengths", y = 2),
          list(name = "Weaknesses", y = 1),
          list(name = "Opportunities", y = 3),
          list(name = "Threats", y = 2)
        )
      ))
  })
}

# Run the App
shinyApp(ui, server)
