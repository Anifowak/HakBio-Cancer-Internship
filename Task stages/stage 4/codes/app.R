# Load required libraries
library(shiny)
library(shinythemes)
library(DT)  # For interactive data tables
library(TCGAbiolinks)
library(EDASeq)

# Define UI for the app
ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  # Custom CSS for title panel and footer
  tags$head(
    tags$style(HTML("
      .title-panel {
        background-color: #003366;  /* Dark blue color */
        padding: 20px;
        color: white;
        text-align: center;
        font-size: 32px;
        font-weight: bold;
      }
      .footer {
        text-align: center;
        padding: 10px;
        font-size: 14px;
        color: #555;  /* Light gray color */
        position: fixed;
        bottom: 0;
        width: 100%;
        background-color: #f9f9f9;  /* Light background for the footer */
        border-top: 1px solid #ddd;  /* Light border at the top of the footer */
      }
    "))
  ),
  
  # Header with a custom title panel
  div(class = "title-panel", "GO 1.0 - Gene Enrichment Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      textAreaInput("gene_list", "Paste Gene List (One per line):", rows = 8, placeholder = "Paste your gene symbols or IDs here"),
      h4("Select Enrichment Types:"),  # Section header
      checkboxGroupInput("enrichmentTypes", "Enrichment Types:",
                         choices = list("Biological Process" = "BP", 
                                        "Cellular Component" = "CC", 
                                        "Molecular Function" = "MF", 
                                        "Pathway" = "Pathway"),
                         selected = "BP"),  # Default selected option
      actionButton("analyze", "Run Enrichment Analysis"),
      downloadButton("downloadPlot", "Download Barplot PDF"),  # Download button for the plot
      hr()
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Home",
                 fluidRow(
                   column(12,
                          h1("Welcome to GO 1.0", style = "text-align:center; margin-top:20px;"),
                          hr(),
                          p("Welcome to GO 1.0, a user-friendly web-based platform for gene-set enrichment analysis. It features an easy-to-use interface, which offers customizable visualization options, and allows printing results in formats like PDF or PNG.", 
                            style = "font-size:16px; text-align:center;"),
                          p("This platform provides valuable resources, including a guide on how to navigate through the website. Developed as part of the HackBio internship program, it is patterned after ShinyGO 8.0, aiming to simplify cancer gene-set enrichment analysis.", 
                            style = "font-size:16px; text-align:center;"),
                          p("Use the sidebar options to begin your analysis.", 
                            style = "font-size:16px; text-align:center;")
                   )
                 )),
        
        # About tab with updated content
        tabPanel("About",
                 h2("INTRODUCTION"),
                 p("The Shiny GO 1.0 app is a user-friendly web application for performing Gene Set Enrichment Analysis (GSEA). 
                It allows researchers to identify enriched gene sets based on their input gene lists, facilitating insights 
                into biological functions and pathways."),
                 
                 h3("Requirements"),
                 p("A web browser (Chrome, Firefox, or any other browser)"),
                 
                 h3("Accessing the App"),
                 p("1. Open your web browser."),
                 p("2. Enter the URL to access the Shiny GO 1.0 app."),
                 p("3. Wait for the app to load."),
                 
                 h3("Main Features"),
                 p("1. Input Gene List: Upload or paste your gene list in the provided text box. Make sure to separate genes by commas or new lines."),
                 p("2. Select Enrichment Types: Choose specific enrichment types for analysis (e.g., Biological Process, Pathway)."),
                 p("3. Click the 'Run Analysis' button to initiate the gene set enrichment analysis. Wait for the results to load."),
                 p("4. Viewing the Results: The app will display a summary of the enrichment results, including enriched terms and their significance values."),
                 p("5. Visualization Tools: View results in various formats, including charts and graphs."),
                 p("6. Downloading Results: Click the 'Download Results' button to save your analysis in preferred formats (e.g., CSV, PDF)."),
                 
                 h3("Conclusion"),
                 p("The Shiny GO 1.0 app is a powerful tool for gene set enrichment analysis, providing an intuitive interface for researchers to derive meaningful 
                biological insights from their gene data. Explore the functionalities and leverage the app for your research needs!"),
                 
                 h3("Support"),
                 p("If you encounter any issues or have questions, please contact our support team via the contact link on the app or email us directly at 
                support@2024 Goal-getters.")
        ),
        
        # Results tab
        tabPanel("Results",
                 h4("Enrichment Analysis Results"),
                 DTOutput("resultsTable"),  # Use DT for better tables
                 plotOutput("enrichmentPlot", width = "100%", height = "700px")  # Add the plot output here
        ),
        
        # Contact tab
        tabPanel("Contact",
                 fluidRow(
                   column(12,
                          h2("Contact Us", style = "margin-top:20px; text-align:center;"),
                          hr(),
                          p("For inquiries or feedback regarding GO 1.0, please contact us:", 
                            style = "font-size:16px;"),
                          tags$ul(
                            tags$li(a("Tomilayo Oluwaseun Fadairo", href = "mailto:Oluwaseuntomilayo9@gmail.com")),
                            tags$li(a("Akinjide Samuel Anifowose", href = "mailto:Anifowosesamuel54@gmail.com")),
                            tags$li(a("Opeoluwa Shodipe", href = "mailto:Opeoluwashodipe94@gmail.com")),
                            tags$li(a("Ndubueze Ngozika Abigail", href = "mailto:ndubungoabi2002@gmail.com")),
                            tags$li(a("Nwankwo Peace Nneka", href = "mailto:nnekapeace85@gmail.com"))
                          ),
                          p("We appreciate your feedback and look forward to hearing from you!", style = "font-size:16px;"),
                          hr()
                   )
                 ))
      )
    )
  ),
  
  # Footer
  div(class = "footer", "© 2024 Goal-getters. All rights reserved.")
)

server <- function(input, output) {
  
  observeEvent(input$analyze, {
    req(input$gene_list)  # Ensure a gene list is provided
    
    # Split pasted gene list into a vector
    geneData <- strsplit(input$gene_list, "\n")[[1]]
    geneData <- trimws(geneData)  # Trim any extra spaces
    
    # Prepare for enrichment results storage
    EA_result <- list()
    
    # Run analyses based on selected types
    if ("BP" %in% input$enrichmentTypes) {
      EA_result$ResBP <- TCGAanalyze_EAcomplete(
        TFname = "DEA genes", 
        RegulonList = geneData  
      )$ResBP
    }
    
    if ("CC" %in% input$enrichmentTypes) {
      EA_result$ResCC <- TCGAanalyze_EAcomplete(
        TFname = "DEA genes", 
        RegulonList = geneData
      )$ResCC
    }
    
    if ("MF" %in% input$enrichmentTypes) {
      EA_result$ResMF <- TCGAanalyze_EAcomplete(
        TFname = "DEA genes", 
        RegulonList = geneData
      )$ResMF
    }
    
    if ("Pathway" %in% input$enrichmentTypes) {
      EA_result$ResPat <- TCGAanalyze_EAcomplete(
        TFname = "DEA genes", 
        RegulonList = geneData
      )$ResPat
    }
    
    # Display results in a table
    output$resultsTable <- renderDT({
      resultsToDisplay <- list()
      
      if ("BP" %in% input$enrichmentTypes && !is.null(EA_result$ResBP)) {
        resultsToDisplay$BP <- as.data.frame(EA_result$ResBP)
      }
      
      if ("CC" %in% input$enrichmentTypes && !is.null(EA_result$ResCC)) {
        resultsToDisplay$CC <- as.data.frame(EA_result$ResCC)
      }
      
      if ("MF" %in% input$enrichmentTypes && !is.null(EA_result$ResMF)) {
        resultsToDisplay$MF <- as.data.frame(EA_result$ResMF)
      }
      
      if ("Pathway" %in% input$enrichmentTypes && !is.null(EA_result$ResPat)) {
        resultsToDisplay$Pathway <- as.data.frame(EA_result$ResPat)
      }
      
      # Combine results into a single data frame, fill missing values with NA
      combinedResults <- Reduce(function(x, y) merge(x, y, all = TRUE), resultsToDisplay)
      datatable(combinedResults)
    })
    
    # Visualization
    output$enrichmentPlot <- renderPlot({
      # Check if any of the results are available
      req(any(c("BP", "CC", "MF", "Pathway") %in% input$enrichmentTypes))
      
      # Generate the barplot
      TCGAvisualize_EAbarplot(
        tf = rownames(EA_result$ResBP),  # Using BP's rownames, adjust this depending on your dataset
        GOBPTab = EA_result$ResBP,
        GOCCTab = EA_result$ResCC,
        GOMFTab = EA_result$ResMF,
        PathTab = EA_result$ResPat,
        nRGTab = geneData,
        nBar = 10,  # Number of top terms to display
        filename = NULL,  # Do not create a PDF file here
        text.size = 1.5,  # Adjust text size
        mfrow = c(1, 1),  # Single large plot layout
        xlim = NULL,
        fig.width = 30,
        fig.height = 15,
        color = c("orange", "cyan", "green", "yellow")  # Bar colors for each category
      )
    })
    
    # Download handler for the plot
    output$downloadPlot <- downloadHandler(
      filename = "TCGAvisualize_EAbarplot_Output.pdf",
      content = function(file) {
        pdf(file, width = 30, height = 15)  # Create a PDF device
        TCGAvisualize_EAbarplot(
          tf = rownames(EA_result$ResBP),
          GOBPTab = EA_result$ResBP,
          GOCCTab = EA_result$ResCC,
          GOMFTab = EA_result$ResMF,
          PathTab = EA_result$ResPat,
          nRGTab = geneData,
          nBar = 10,  # Number of top terms to display
          filename = NULL,  # No file created at this point
          text.size = 1.5,  # Adjust text size
          mfrow = c(1, 1),  # Single large plot layout
          xlim = NULL,
          fig.width = 30,
          fig.height = 15,
          color = c("orange", "cyan", "green", "yellow")  # Bar colors for each category
        )
        dev.off()  # Close the PDF device
      }
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server, options = list(height = 1080))