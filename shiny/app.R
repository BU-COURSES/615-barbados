# Shiny App for Barbados Analysis

library(shiny)
library(leaflet)
library(ggplot2)
library(plotly)
library(shinydashboard)
library(DT)
library(shinyWidgets)
library(highcharter)
library(dplyr)

# Run ./data/data_organizer first to get the extracted data from our dataset
load("./data.RData")

# Preprocessed data variables
gdp_dollars <- gdp_dollars %>% rename(year = Year, gdp = Dollars)
population_total <- population_total %>% rename(year = Year, population = Population)
tourism_data <- tourism_data %>% rename(year = Year, tourism = Amount)
population_growth <- population_growth %>% rename(year = Year, population_growth = Percentage)
unemployment_data <- unemployment_data %>% rename(year = Year, unemployment = Percentage)

# Merge datasets by year
barbados_data <- gdp_dollars %>%
  inner_join(population_total, by = "year") %>%
  left_join(tourism_data, by = "year") %>%
  left_join(population_growth, by = "year") %>%
  left_join(unemployment_data, by = "year")

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Barbados Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("chart-line")),
      menuItem("Key Facts", tabName = "key_facts", icon = icon("info-circle")),
      menuItem("SWOT Analysis", tabName = "swot", icon = icon("balance-scale")),
      menuItem("Conclusion", tabName = "conclusion", icon = icon("flag-checkered"))
    )
  ),
  dashboardBody(
    tabItems(
      # Overview Tab
      tabItem(tabName = "overview",
              fluidRow(
                box(title = "Introduction", status = "info", solidHeader = TRUE, width = 12,
                    HTML(
                      "<p>This app provides a detailed analysis of Barbados, focusing on its economic and demographic trends, regional comparisons, and strategic SWOT analysis. Explore trends in GDP, population, and tourism to understand key challenges and opportunities.</p>"
                    )
                )
              ),
              fluidRow(
                box(title = "Key Facts about Barbados", status = "info", solidHeader = TRUE, width = 12,
                    HTML(
                      "<ul>
                        <li><b>Population:</b> Approximately 282,000 residents (2023).</li>
                        <li><b>GDP:</b> $6.4 billion (2023).</li>
                        <li><b>Tourism:</b> A significant driver of the economy.</li>
                      </ul>"
                    )
                )
              ),
              fluidRow(
                box(title = "Graph 1: GDP, Tourism, Unemployment", status = "primary", solidHeader = TRUE, width = 6,
                    selectInput("graph1_variable", "Select Variable for Graph 1:",
                                choices = c("GDP" = "gdp", 
                                            "Tourism" = "tourism", 
                                            "Unemployment Rate" = "unemployment")),
                    plotlyOutput("graph1", height = 300)
                ),
                box(title = "Graph 2: Population and Growth", status = "primary", solidHeader = TRUE, width = 6,
                    selectInput("graph2_variable", "Select Variable for Graph 2:",
                                choices = c("Population Total" = "population", 
                                            "Population Growth" = "population_growth")),
                    plotlyOutput("graph2", height = 300)
                )
              ),
              fluidRow(
                box(title = "Analysis", status = "info", solidHeader = TRUE, width = 12,
                    htmlOutput("dynamic_analysis")
                )
              )
              
      ),
      
      # Key Facts Tab
      tabItem(tabName = "key_facts",
              fluidRow(
                box(title = "Key Facts about Barbados", status = "info", solidHeader = TRUE, width = 12,
                    HTML(
                      "<ul>
                        <li><b>Population:</b> Approximately 282,000 residents (2023).</li>
                        <li><b>GDP:</b> $6.4 billion (2023).</li>
                        <li><b>Tourism:</b> A significant driver of the economy.</li>
                      </ul>"
                    )
                )
              )
      ),
      
      # SWOT Analysis Tab
      tabItem(tabName = "swot",
              fluidRow(
                box(title = "SWOT Analysis Chart", status = "warning", solidHeader = TRUE, width = 6,
                    highchartOutput("swotChart", height = 400)
                ),
                box(title = "SWOT Details", status = "warning", solidHeader = TRUE, width = 6,
                    HTML(
                      "<b>Strengths:</b>
                      <ul>
                        <li>Thriving tourism sector.</li>
                        <li>Stable governance.</li>
                      </ul>
                      <b>Weaknesses:</b>
                      <ul>
                        <li>Small population size.</li>
                        <li>Reliance on external tourism markets.</li>
                      </ul>
                      <b>Opportunities:</b>
                      <ul>
                        <li>Renewable energy initiatives.</li>
                        <li>Blue economy development.</li>
                      </ul>
                      <b>Threats:</b>
                      <ul>
                        <li>Climate change impacts.</li>
                        <li>Rising sea levels.</li>
                      </ul>"
                    )
                )
              )
      ),
      
      # Conclusion Tab
      tabItem(tabName = "conclusion",
              fluidRow(
                box(title = "Conclusion", status = "info", solidHeader = TRUE, width = 12,
                    HTML(
                      "<h4>Summary of Findings:</h4>
                        <p>Barbados has shown notable economic and demographic trends over the decades:</p>
                        <ul>
                          <li><b>GDP Growth:</b> The economy has steadily expanded, particularly since the 1980s, driven by tourism and services. However, vulnerabilities to global economic shocks, such as the 2008 financial crisis and COVID-19, highlight the need for diversification.</li>
                          <li><b>Tourism:</b> As the backbone of the economy, tourism has shown significant peaks but remains volatile, especially during global disruptions. Strategic efforts to develop sustainable tourism are crucial to mitigate these risks.</li>
                          <li><b>Unemployment:</b> Barbados successfully reduced unemployment from its peak of 25% in the early 1990s to a stable range of 10–12%. However, challenges persist, including youth unemployment and the need for upskilling in emerging industries.</li>
                          <li><b>Population Growth:</b> The total population has grown steadily to over 280,000. However, the slowing growth rate, driven by an aging population and emigration, poses long-term sustainability challenges.</li>
                        </ul>
                
                        <h4>Key Challenges:</h4>
                        <ul>
                          <li>Economic over-reliance on tourism makes the economy highly sensitive to external shocks.</li>
                          <li>Population stagnation and emigration of skilled workers threaten the future workforce and growth potential.</li>
                          <li>Climate change and rising sea levels pose serious risks to infrastructure, tourism, and livelihoods.</li>
                        </ul>
                
                        <h4>Key Recommendations:</h4>
                        <ul>
                          <li><b>Economic Diversification:</b> Invest in sectors like renewable energy, technology, and the blue economy to reduce dependence on tourism and build economic resilience.</li>
                          <li><b>Workforce Development:</b> Address unemployment and skill mismatches by promoting education, vocational training, and job opportunities in emerging industries.</li>
                          <li><b>Population Sustainability:</b> Implement policies to retain young talent, attract skilled immigrants, and encourage family growth to counter slowing population growth.</li>
                          <li><b>Sustainable Tourism:</b> Focus on eco-tourism, regional partnerships, and infrastructure development to create a more robust and sustainable tourism sector.</li>
                          <li><b>Climate Resilience:</b> Invest in climate adaptation strategies, including infrastructure protection, renewable energy, and sustainable resource management.</li>
                        </ul>
                
                        <h4>Final Thoughts:</h4>
                        <p>Barbados has made remarkable strides in economic growth, demographic stability, and unemployment reduction. However, as a Small Island Developing State (SIDS), it faces unique challenges that require strategic and sustainable solutions. By diversifying the economy, investing in its workforce, and addressing climate-related vulnerabilities, Barbados can secure a resilient and prosperous future for its citizens.</p>"
                                    )
                                )
                              )
                              
      )
    )
  )
)

# Define Server
server <- function(input, output, session) {
  # Welcome Box Modal
  observe({
    showModal(modalDialog(
      title = "Welcome to the Barbados Analysis App!",
      "Explore trends in GDP, tourism, and population growth, and gain insights into the opportunities and challenges for Barbados.",
      footer = tagList(
        modalButton("Get Started"),
        tags$p("Created by Taha Ababou - MA615 Final Project", style = "text-align: center; margin-top: 10px; font-size: 12px; color: gray;")
      )
    ))
  })
  
  # Graph 1
  output$graph1 <- renderPlotly({
    data <- barbados_data
    plot_ly(data, x = ~year, y = as.formula(paste0("~", input$graph1_variable)),
            type = "scatter", mode = "lines", name = input$graph1_variable) %>%
      layout(title = paste("Trend of", input$graph1_variable),
             xaxis = list(title = "Year"), yaxis = list(title = input$graph1_variable))
  })
  
  # Graph 2
  output$graph2 <- renderPlotly({
    data <- barbados_data
    plot_ly(data, x = ~year, y = as.formula(paste0("~", input$graph2_variable)),
            type = "scatter", mode = "lines", name = input$graph2_variable) %>%
      layout(title = paste("Trend of", input$graph2_variable),
             xaxis = list(title = "Year"), yaxis = list(title = input$graph2_variable))
  })
  
  output$dynamic_analysis <- renderUI({
    # Analysis for Graph 1
    graph1_analysis <- switch(input$graph1_variable,
                              "gdp" = HTML("<p><b>GDP Analysis:</b> 
                  Barbados' GDP has demonstrated consistent growth since the 1980s, reflecting a steady economic trajectory. 
                  The upward trend in GDP post-2000 highlights Barbados' reliance on services and tourism sectors for economic stability. 
                  However, noticeable slowdowns occurred during global financial crises (e.g., 2008) and the recent sharp rise reflects recovery efforts post-COVID-19. 
                  Continued economic diversification is essential to sustain this growth and reduce vulnerability to global economic shocks.</p>"),
                              
                              "tourism" = HTML("<p><b>Tourism Analysis:</b> 
                     Tourism remains a cornerstone of Barbados' economy, contributing a significant share of its GDP. 
                     The data reveals periodic peaks, particularly in the early 2000s and late 2010s, which coincide with increased global travel and successful marketing efforts by the Barbados Tourism Authority. 
                     The steep decline around 2019 reflects the devastating impact of the COVID-19 pandemic on international travel. 
                     While tourism has historically driven growth, its volatility underscores the need to develop sustainable tourism strategies, including eco-tourism and domestic tourism initiatives.</p>"),
                              
                              "unemployment" = HTML("<p><b>Unemployment Analysis:</b> 
                          Barbados faced exceptionally high unemployment rates in the early 1990s, peaking at around 25%, driven by economic downturns and structural challenges. 
                          Over the years, unemployment has declined significantly, stabilizing around 10–12%. 
                          However, persistent challenges remain, including the need to create job opportunities for a growing youth population and address skill mismatches in emerging sectors such as renewable energy, technology, and the blue economy.</p>")
    )
    
    # Analysis for Graph 2
    graph2_analysis <- switch(input$graph2_variable,
                              "population" = HTML("<p><b>Population Analysis:</b> 
                         Barbados' total population has steadily increased from approximately 230,000 in 1960 to over 280,000 in 2023. 
                         This gradual growth reflects a stable demographic trend. However, as a small island nation, limited land and resources present unique challenges for sustainable urban development and infrastructure. 
                         Policymakers must carefully plan for the needs of a growing population while balancing environmental conservation and economic development.</p>"),
                              
                              "population_growth" = HTML("<p><b>Population Growth Analysis:</b> 
                                Barbados' population growth rate has shown a consistent decline since the late 20th century. 
                                The growth rate, which once hovered around 0.5%, has fallen to below 0.2% in recent decades. 
                                Factors contributing to this slowdown include declining birth rates, emigration of skilled workers seeking opportunities abroad, and an aging population. 
                                Addressing population stagnation requires policies to retain young talent, attract skilled immigrants, and provide incentives for families to increase birth rates.</p>")
    )
    
    # Combine and display the analysis
    HTML(paste(graph1_analysis, graph2_analysis, sep = "<hr>"))
  })
  
  
  
  # SWOT Pie Chart
  output$swotChart <- renderHighchart({
    highchart() %>%
      hc_chart(type = "pie") %>%
      hc_title(text = "SWOT Analysis") %>%
      hc_series(list(
        name = "SWOT",
        data = list(
          list(name = "Strengths", y = 2),
          list(name = "Weaknesses", y = 2),
          list(name = "Opportunities", y = 2),
          list(name = "Threats", y = 2)
        )
      ))
  })
}

# Run the App
shinyApp(ui, server)
