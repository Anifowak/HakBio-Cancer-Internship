library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(plotly)
library(knitr)
library(kableExtra)
library(htmltools)

# Load country latitude and longitude data
countries_data <- read.csv("data/countries_lat_lon.csv")

# Function to load cholera data
load_cholera_data <- function() {
  tryCatch({
    read.csv("data/cholera_data.csv")
  }, error = function(e) {
    stop("Error loading cholera data: ", e$message)
  })
}

# Load cholera data
cholera_data <- load_cholera_data()

# Merge cholera data with latitude and longitude
cholera_data <- cholera_data %>%
  left_join(countries_data, by = "country")

# Define UI
ui <- navbarPage("Cholera Data Dashboard",
                 theme = shinythemes::shinytheme("cerulean"),
                 tabPanel("Home",
                          fluidPage(
                            tags$head(tags$style(HTML("
                              body {
                                font-family: 'Helvetica', sans-serif;
                                background-color: #f7f9fc;
                              }
                              .navbar {
                                background-color: #003366; /* Dark blue */
                              }
                              .navbar-default .navbar-nav > li > a {
                                color: white; /* Text color */
                              }
                              .navbar-default .navbar-nav > li > a:hover {
                                color: #ffcc00; /* Hover color */
                              }
                              .content {
                                text-align: center; /* Center align */
                                padding: 20px;
                              }
                              .title {
                                font-size: 32px; /* Adjust font size */
                                font-weight: bold;
                                color: #003366;
                                margin-bottom: 20px;
                              }
                              .section {
                                background-color: white;
                                border-radius: 8px;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                                padding: 20px;
                                margin-bottom: 20px;
                              }
                              h3 {
                                color: #003366;
                              }
                              p {
                                font-size: 18px;
                              }
                            "))),
                            div(class = "content",
                                div(class = "title", "Welcome to the Cholera Data Visualization Dashboard"),
                                div(class = "section",
                                    h3("About Cholera"),
                                    p("Cholera is a highly contagious bacterial disease primarily transmitted through contaminated water or food."),
                                    p("This dashboard provides a comprehensive overview of global cholera outbreaks since 1949, serving as a valuable resource for researchers, public health officials, and anyone interested in understanding the global impact of cholera.")
                                ),
                                div(class = "section",
                                    h3("Our Mission"),
                                    p("Our mission is to enhance public health communication through interactive visualizations and standardized reports, identifying trends and patterns in cholera. This aims to improve preparation for future cholera outbreaks.")
                                ),
                                div(class = "section",
                                    h3("Get Started"),
                                    p("Explore the dashboard to visualize cholera data, generate reports, and gain insights into the cholera outbreak patterns globally."),
                                    
                                  
                                    tags$footer(style = "text-align: center; margin-top: 20px;", 
                                                "© 2024 Goal-getters. All rights reserved.")
                                )
                            )
                          )),
                 tabPanel("About",
                          fluidPage(
                            tags$head(tags$style(HTML("
                              .about-header {
                                text-align: center;
                                color: #003366;
                                font-size: 28px;
                                margin-bottom: 20px;
                              }
                              .about-section {
                                background-color: white;
                                border-radius: 8px;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                                padding: 20px;
                                margin: 0 auto;
                                width: 80%;
                              }
                              h3 {
                                color: #003366;
                              }
                              p {
                                font-size: 18px;
                              }
                            "))),
                            div(class = "about-header", "About the Cholera Dashboard Project"),
                            div(class = "about-section",
                                h3("Initiation"),
                                p("The Cholera dashboard project was initiated as part of a HackBio internship program, where participants were tasked with developing R Shiny dashboards for bioinformatics applications.")
                            ),
                            div(class = "about-section",
                                h3("Goal"),
                                p("The goal was to provide a user-friendly website for scientists, enhancing public health communication through interactive visualizations and standardized reports identifying trends and patterns in cholera. This aims to improve preparation for future cholera outbreaks.")
                            ),
                            div(class = "about-section",
                                h3("Impact"),
                                p("By achieving these goals, the Cholera dashboard project aimed to make a positive impact on the bioinformatics community and contribute to the advancement of scientific research."),
                                
                                tags$footer(style = "text-align: center; margin-top: 20px;", 
                                            "© 2024 Goal-getters. All rights reserved.")
                            )
                          )),
                 
                 tabPanel("Cholera Dashboard",
                          sidebarLayout(
                            sidebarPanel(
                              selectInput("yearInput", "Select Year:",
                                          choices = sort(unique(cholera_data$year), decreasing = TRUE),
                                          selected = max(cholera_data$year)),
                              selectInput("countryInput", "Select Country:",
                                          choices = sort(unique(countries_data$country)),
                                          selected = "Global"),
                              checkboxInput("showDeaths", "Show Deaths", value = TRUE),
                              helpText("Use the dropdowns to filter cholera data."),
                              actionButton("generateReport", "Generate Country Report"),
                              downloadButton("downloadReport", "Download Report")
                            ),
                            
                            mainPanel(
                              tabsetPanel(
                                tabPanel("Map", leafletOutput("choleraMap")),
                                tabPanel("Cholera Cases Over Time", plotlyOutput("casesTimeSeries")),
                                tabPanel("Cholera Cases", plotlyOutput("casesPlot")),
                                tabPanel("Cholera Deaths", plotlyOutput("deathsPlot")),
                                tabPanel("Cholera Fatality Rate", plotlyOutput("fatalityRatePlot")),
                                tabPanel("Summary Metrics", verbatimTextOutput("summaryMetrics")),
                                tabPanel("Country Report", uiOutput("countryReport")),
                              )
                            )
                          )),
                 
                 tabPanel("Contact",
                          fluidPage(
                            tags$head(tags$style(HTML("
                              .contact-header {
                                text-align: center;
                                color: #003366;
                                font-size: 28px;
                                margin-bottom: 20px;
                              }
                              .contact-section {
                                background-color: white;
                                border-radius: 8px;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                                padding: 20px;
                                margin: 0 auto;
                                width: 80%;
                              }
                              .contact-list {
                                list-style-type: none;
                                padding: 0;
                              }
                              .contact-list li {
                                margin: 10px 0;
                                font-size: 18px;
                              }
                              a {
                                color: #003366;
                                text-decoration: none;
                              }
                              a:hover {
                                text-decoration: underline;
                              }
                            "))),
                            div(class = "contact-header", "Contact Us"),
                            div(class = "contact-section",
                                p("For inquiries, please reach out to our team:"),
                                tags$ul(class = "contact-list",
                                        tags$li(a("Tomilayo Oluwaseun Fadairo", href = "mailto:Oluwaseuntomilayo9@gmail.com")),
                                        tags$li(a("Akinjide Samuel Anifowose", href = "mailto:Anifowosesamuel54@gmail.com")),
                                        tags$li(a("Opeoluwa Shodipe", href = "mailto:Opeoluwashodipe94@gmail.com")),
                                        tags$li(a("Ndubueze Ngozika Abigail", href = "mailto:ndubungoabi2002@gmail.com")),
                                        tags$li(a("Nwankwo Peace Nneka", href = "mailto:nnekapeace85@gmail.com")),
                                        tags$li(a("Alo Y. Mary", href = "mailto:aloyetunde99@gmail.com")),
                                        tags$li(a("Akeemat Ayinla", href = "mailto:akeematayinla@gmail.com"))
                                     ),
                                      tags$footer(style = "text-align: center; margin-top: 20px;", 
                                            "© 2024 Goal-getters. All rights reserved.")
                            ))
                 )
)     
# Define Server
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    req(input$yearInput, input$countryInput)
    if (input$countryInput == "Global") {
      cholera_data %>%
        filter(year == input$yearInput)
    } else {
      cholera_data %>%
        filter(year == input$yearInput, country == input$countryInput)
    }
  })
  
  observe({
    updateSelectInput(session, "countryInput",
                      choices = sort(unique(cholera_data$country[cholera_data$year == input$yearInput])),
                      selected = "Global")
  })
  
  output$choleraMap <- renderLeaflet({
    req(filtered_data())
    leaflet(filtered_data()) %>%
      addTiles() %>%
      addCircles(
        lat = ~lat, lng = ~lon,
        weight = 1, radius = ~reported_cases * 10,
        popup = ~paste(country, "Cases:", reported_cases, "Deaths:", reported_deaths),
        label = ~paste(country, "Cases:", reported_cases) %>% lapply(htmltools::HTML)
      )
  })
  
  output$casesTimeSeries <- renderPlotly({
    time_series_data <- cholera_data %>%
      group_by(year) %>%
      summarise(total_cases = sum(reported_cases, na.rm=TRUE), 
                total_deaths = sum(reported_deaths, na.rm=TRUE))
    
    p <- ggplot(time_series_data, aes(x = year)) +
      geom_line(aes(y = total_cases, color = "Total Cases"), size=1) +
      geom_line(aes(y = total_deaths, color = "Total Deaths"), size=1) +
      labs(title="Cholera Cases and Deaths Over Time", x="Year", y="Count") +
      scale_color_manual(values=c("blue", "red")) +
      theme_minimal()
    
    ggplotly(p) %>% layout(hovermode="closest")
  })
  
  output$casesPlot <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = reorder(country, -reported_cases), y = reported_cases)) +
      geom_bar(stat="identity", fill="blue") +
      coord_flip() +
      labs(title=paste("Cholera Cases in", input$yearInput), x="Country", y="Reported Cases") +
      theme_minimal() +
      geom_text(aes(label=reported_cases), position=position_stack(vjust=0.5), color="white")
    
    ggplotly(p) %>% layout(hovermode="closest")
  })
  
  output$deathsPlot <- renderPlotly({
    if (input$showDeaths) {
      p <- ggplot(filtered_data(), aes(x = reorder(country, -reported_deaths), y = reported_deaths)) +
        geom_bar(stat="identity", fill="red") +
        coord_flip() +
        labs(title=paste("Cholera Deaths in", input$yearInput), x="Country", y="Reported Deaths") +
        theme_minimal() +
        geom_text(aes(label=reported_deaths), position=position_stack(vjust=0.5), color="white")
      
      ggplotly(p) %>% layout(hovermode="closest")
    } else {
      return(NULL)
    }
  })
  
  output$fatalityRatePlot <- renderPlotly({
    filtered_df <- filtered_data()
    filtered_df <- filtered_df %>%
      mutate(fatality_rate = ifelse(reported_cases > 0,
                                    (reported_deaths / reported_cases) * 100,
                                    NA))
    
    p <- ggplot(filtered_df, aes(x=reorder(country, -fatality_rate), y=fatality_rate)) +
      geom_line(color="red", size=1) +
      geom_point(color="red") +
      coord_flip() +
      labs(title=paste("Cholera Fatality Rate in", input$yearInput), x="Country", y="Fatality Rate (%)") +
      theme_minimal()
    
    ggplotly(p) %>% layout(hovermode="closest")
  })
  
  output$summaryMetrics <- renderPrint({
    req(filtered_data())
    
    total_cases <- sum(filtered_data()$reported_cases, na.rm=TRUE)
    total_deaths <- sum(filtered_data()$reported_deaths, na.rm=TRUE)
    
    cat("Summary Metrics:\n")
    cat("Total Cases:", total_cases, "\n")
    cat("Total Deaths:", total_deaths, "\n")
    
    if (total_cases > 0) {
      cat("Cholera Fatality Rate (%):", round((total_deaths / total_cases) * 100, 2), "\n")
    } else {
      cat("No cases reported.\n")
    }
  })
  
  observeEvent(input$generateReport,{
    req(filtered_data())
    
    report <- filtered_data() %>%
      select(country, year, reported_cases, reported_deaths)
    
    if (nrow(report) == 0) {
      showNotification("No data available for the selected filters.", type="error")
      return(NULL)
    }
    
    report_table <- kable(report, format="html", escape=FALSE) %>%
      kable_styling("striped", full_width=F)
    
    output$countryReport <- renderUI({
      tagList(
        h3(paste("Country Report for", input$countryInput)),
        HTML(as.character(report_table))  # Wrap the report_table in HTML()
      )
    })
    
    showNotification(paste("Report generated for", input$countryInput), type="message")
  })
  
  output$downloadReport <- downloadHandler(
    filename = function() { paste(input$countryInput, "-report.html") },
    content = function(file) {
      report_content <- filtered_data() %>%
        select(country, year, reported_cases, reported_deaths) %>%
        kable(format="html", escape=FALSE) %>%
        kable_styling(full_width=F)
      
      writeLines(as.character(report_content), file)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server, options = list(height = 1080))
