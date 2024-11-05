### **App Functionality and Development** ###

The R Shiny app developed for functional enrichment analysis utilizes two core functions from the TCGAbiolinks package: TCGAanalyze\_EAcomplete () and TCGA\_EAbarplot (). The app allows users to input gene lists, conduct enrichment analyses, and visualize results in an interactive and user-friendly manner. Key components of the app's functionality are:

**Gene Set Enrichment Analysis (GSEA)**: The app allows users to input gene lists and perform functional enrichment analysis to identify significantly enriched pathways and gene sets. This helps in understanding biological processes, molecular functions, and cellular components associated with the genes.

**Gene Ontology (GO) and Pathway Enrichment**: GO 1.0 provides insights into GO terms and pathways by mapping genes to GO categories such as biological processes, molecular functions, and cellular components. It also supports pathway databases like KEGG for a broader context.

**Interactive Visualization**: The app generates interactive plots, including bar charts, network plots, and scatter plots that users can customize. These visualizations allow for better interpretation of the enrichment results.

**Data Integration**: Users can integrate various types of data for a more comprehensive analysis. It supports a wide range of organisms, making it applicable to many species.

**Gene List Input and Analysis Customization**: The app supports uploading gene lists in different formats (like Entrez IDs or gene symbols). Users can select specific parameters for analysis, such as p-value cutoffs, enrichment methods, and databases to query.

**Downloadable Results**: All results, including gene ontology terms, enriched pathways, and visualizations, can be downloaded in various formats for further analysis or presentation purposes.

This functionality makes GO 1.0 a powerful tool for researchers and bioinformaticians performing enrichment analysis and wanting to explore functional associations within gene sets.

The challenges encountered during development included ensuring the smooth integration of these functions into a Shiny interface, package installation and troubleshooting performance issues when analyzing these large datasets. 
