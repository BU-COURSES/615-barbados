# **Barbados Analysis Dashboard**

### A Comprehensive Shiny Web Application for Economic and Demographic Analysis

------------------------------------------------------------------------

## **Project Overview**

The **Barbados Analysis Dashboard** is an interactive Shiny application
designed to analyze and visualize economic, demographic, and employment
trends in Barbados. By leveraging historical and recent data, this
dashboard provides insights into key indicators like GDP, tourism,
unemployment, and population trends. It also highlights opportunities
and challenges unique to Barbados as a **Small Island Developing State
(SIDS)**.

The app is ideal for researchers, policymakers, students, and anyone
interested in understanding Barbados' development trajectory.

[Live Shiny App](https://tahaababou.shinyapps.io/shiny/)

------------------------------------------------------------------------

## **Key Features**

### **1. Overview Tab**

-   **Dynamic Graphs**:\
    Users can explore trends in key indicators with two interactive
    graphs:
    -   **Graph 1**:
        -   GDP\
        -   Tourism\
        -   Unemployment Rate\
    -   **Graph 2**:
        -   Population Total\
        -   Population Growth\
-   **Dynamic Insights**:\
    A detailed analysis dynamically updates based on the selected
    variable, providing context and interpretation for trends in the
    graphs.

------------------------------------------------------------------------

### **2. Key Facts Tab**

-   A summary of Barbados' key economic and demographic indicators:
    -   Population: \~282,000 (2023)\
    -   GDP: \$6.4 billion (2023)\
    -   Tourism: A major contributor to the economy.

------------------------------------------------------------------------

### **3. SWOT Analysis Tab**

-   **Interactive SWOT Chart**:\
    A visual representation of the **Strengths**, **Weaknesses**,
    **Opportunities**, and **Threats** facing Barbados.\
-   **Detailed SWOT Insights**:\
    Drill-down explanations for each aspect of the SWOT analysis,
    providing actionable context.

------------------------------------------------------------------------

### **4. Conclusion Tab**

-   **Summary of Findings**:\
    A detailed recap of key insights from the analysis, including
    economic performance, population growth trends, and labor market
    conditions.\
-   **Key Challenges**:\
    Highlights the challenges Barbados faces, such as reliance on
    tourism, population stagnation, and climate risks.
-   **Recommendations**:\
    Actionable suggestions for policymakers to promote sustainable
    growth, including:
    -   Economic diversification\
    -   Workforce development\
    -   Sustainable tourism\
    -   Climate resilience strategies

------------------------------------------------------------------------

## **Technologies Used**

-   **R Shiny**: For building the interactive web application.\
-   **Leaflet**: To integrate map-based visualizations (future
    development).\
-   **ggplot2** and **plotly**: For creating dynamic and visually
    appealing charts.\
-   **Highcharter**: For interactive SWOT pie charts.\
-   **Data Processing**:
    -   **dplyr**: For data wrangling and preprocessing.

------------------------------------------------------------------------

## **Data Sources**

*All datasets used were extracted from the World Bank Group (see n.4)*

The data used in this project is preprocessed and extracted using the
`data_organizer.R` script from the following sources: 1.
**all_countries.xls**: General country data 2.
**barbados_all_data.xls**: Barbados-specific historical data 3.
**barbados_metadata_export.xlsx**: Supporting metadata for economic and
population indicators 4. **World Bank Open Data**:
<https://data.worldbank.org/country/barbados>

The following indicators are analyzed: - **GDP**: Historical GDP values
(in USD) - **Tourism**: Annual tourist arrivals and contributions -
**Population**: Total population and annual growth rates -
**Unemployment**: Historical unemployment rates across decades

------------------------------------------------------------------------

## **File Structure**

``` plaintext
Canvas/
├── 615-barbados.Rproj            # RStudio project file
├── README.md                    # Project documentation (this file)
├── data
│   ├── all_countries.xls        # Raw dataset
│   ├── barbados_all_data.xls    # Barbados data
│   ├── barbados_metadata_export.xlsx # Metadata
│   ├── data_organizer.R         # Script to preprocess and clean raw datasets
│   └── data_organizer.Rmd       # R Markdown report for data preparation
├── instructions.qmd             # Instructions document
├── presentation.Rmd             # Presentation file
├── report.Rmd                   # Final written report
└── shiny
    ├── app.R                    # Main Shiny app script
    ├── data.RData               # Preprocessed data used in the app
    └── rsconnect/               # Deployment configuration (if applicable)
```

------------------------------------------------------------------------

## **How to Run the App**

Follow these steps to launch the Shiny app locally:

1.  **Clone the Repository**:

    ``` bash
    git clone https://github.com/BU-COURSES/615-barbados.git
    cd 615-barbados
    ```

2.  **Run the Data Organizer**:\
    Ensure the data is preprocessed before running the app:

    ``` bash
    Rscript ./data/data_organizer.R
    ```

    The app.R already has a command to run the .RData variables used in
    this analysis. Use the above in case of needs of debugging.

3.  **Launch the App**:\
    Open `app.R` in your R environment (e.g., RStudio) and run:

    ``` r
    shiny::runApp()
    ```

4.  **View in Browser**:\
    The app will open in your default browser.

------------------------------------------------------------------------

## **Key Insights**

-   **GDP**: Barbados has achieved steady economic growth despite
    vulnerabilities to global crises.
-   **Tourism**: A major economic driver but highly volatile, requiring
    sustainable strategies.
-   **Unemployment**: Significant progress since the 1990s, though
    challenges persist with youth employment.
-   **Population**: Gradual population growth with a noticeable
    slowdown, raising sustainability concerns.

------------------------------------------------------------------------

## **Future Enhancements**

-   **Map Integration**: Use Leaflet for visualizing Barbados' tourism
    and economic hotspots.
-   **Forecasting Tools**: Implement predictive models for GDP, tourism,
    and unemployment.
-   **Regional Comparison**: Include economic comparisons with
    neighboring Caribbean countries.
-   **Sustainability Metrics**: Add insights related to renewable energy
    and climate resilience.

------------------------------------------------------------------------

## **Author**

**Taha Ababou**\
- Master's in Statistical Practice\
- Boston University

------------------------------------------------------------------------

## **Acknowledgments**

This project was developed as part of the MA615 Final Project at Boston
University, leveraging publicly available economic and demographic
datasets.
