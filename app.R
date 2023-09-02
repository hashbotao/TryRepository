library(shiny)
library(shinydashboard)
library(stats)
library(ggrepel)
library(igraph)
library(caret)
library(dplyr)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(tibble)
library(randomForest)
library(glmnet)
library(ggfortify)
library(DT)

ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = tagList(tags$img(src = "https://assets.manchester.ac.uk/logos/hi-res/TAB_UNI_MAIN_logo/Coloured_backgrounds/TAB_col_background.png", style = "width:70%; max-height: 42px; display:block; margin:auto;margin-top:5px;"))), 
  dashboardSidebar(  
    sidebarMenu(
      
      menuItem("About", tabName = "About", icon = icon("house")),
      menuItem("Data PrePorcess",tabName = "One",icon = icon("upload")),
      
      menuItem("Integration and Analyse", tabName = "di", icon = icon("mixer"),
               menuSubItem("Early Integration", tabName = "Earlyi", icon = icon("layer-group")),
               menuSubItem("Intermediate Integration", tabName = "Intermediatei",icon = icon("puzzle-piece")),
               menuSubItem("Late Integration", tabName = "Latei", icon = icon("clone"))
      ),
      
      tags$li(style = "height: 0.5px; background-color: #bbc7cd; margin: 12px 12px;"),
      
      menuItem("Contact", tabName = "contact", icon = icon("envelope")),
      menuItem("GitHub", icon = icon("github"), href="https://www.example.com")
      
    )),
  
  dashboardBody(
    
    tags$head(
      tags$style(HTML("
                          .main-header {
                            height: 20px;
                          }
                          
                          .box { 
                            overflow-x: auto;
                            overflow-y: auto;
                          }
        
                          .half-width {
                            width: 50%;
                          }
        
                          .custom-btn {
                            width: 100%; 
                            margin-bottom: 5px; 
                          }
                          
                          .shiny-notification {
                            position: fixed;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                            width: auto;
                            max-width: 100%;
                          }
                          
                          table {
                          border-collapse: collapse;
                          width: 100%;
                          }
      
                          th, td {
                          border: 1px solid black;
                          padding: 8px;
                          text-align: left;
                          }
                          
                          th:nth-child(1), td:nth-child(1) {
                          width: 70%;
                          }
                          
                          th:nth-child(2), td:nth-child(2) {
                          width: 30%;
                          }
                          
                          ")
                 )
    ),
    
    tabItems(
      # 第一个选项卡页面
      # tabName = "About"
      tabItem(tabName = "About",
              h1("Welcome to UoME-Omices"),
              fluidRow(
                box(width = 6,height = "200px",title = "What is this?",status = "primary",solidHeader = TRUE,
                    HTML("<p><strong>This is a demo Omics data analyical dashboard using R, Shiny and various other features.</strong></p>
                          <p>The dashboard provides basic functions about <strong>data intergation</strong>, <strong>data analysis</strong> and its <strong>visualisation</strong></p>"),
                    helpText("Check out the source code via the Github link：",HTML("<a href='https://www.example.com'>GitHub_Link</a>")),
                    helpText("Check out the tutorial file link：",HTML("<a href='https://www.example.com'>Tutorial_File_Link</a>"))
                ), 
                box(width = 6,height = "200px",title = "Acknowledgements",status = "warning",solidHeader = TRUE,
                    HTML("<p>I would like to express my sincere gratitude to my supervisor <em>Dr Juhi Gupta</em>.</p>
                          <p>I am grateful to her for the support she gave me and the freedom to choose my direction; for her patience, motivation and vast knowledge; and for her invaluable guidance and feedback on the direction of the topic, the planning of the structure of the project, how to find the dataset, and the modifications to the structure of the dissertation, which have helped me a great deal in completing this project!.</p>
                          "),), 
                box(width = 12, height = "800px",title = "Available references",status = "info",
                    HTML("<p>This is a list of some of the available references and URL for dashboard development methods, datasets sources and algorithm applications</p>"),
                    tabsetPanel(
                      
                      tabPanel("ShinyDashboard Development",
                               box(width = 12,"",
                                   tags$table(
                                     tags$thead(
                                       tags$tr(tags$th("Name"), tags$th("URL"))
                                     ),
                                     tags$tbody(
                                       tags$tr(tags$td("[Web] Shiny : Easy web apps for data science without the compromises"), tags$td(tags$a(href="https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/index.html", "Link"))),
                                       tags$tr(tags$td("[Web] Package 'shiny'"), tags$td(tags$a(href="https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=b7600ac8de6a97df1bd26dcbfc43ef9fc3c8be61", "Link"))),
                                       tags$tr(tags$td("[Web] Development of interactive biological web applications with R/Shiny"), tags$td(tags$a(href="https://academic.oup.com/bib/article-abstract/23/1/bbab415/6387320", "Link"))),
                                       tags$tr(tags$td("[Web] Shiny-phyloseq: Web application for interactive microbiome analysis with provenance tracking"), tags$td(tags$a(href="https://academic.oup.com/bioinformatics/article/31/2/282/2365643", "Link"))),
                                       tags$tr(tags$td("[Web] Ourcodingclub"), tags$td(tags$a(href="https://ourcodingclub.github.io/tutorials/shiny/", "Link"))),
                                       tags$tr(tags$td("[Web] Mastering Shiny"), tags$td(tags$a(href="https://mastering-shiny.org/", "Link"))),
                                       tags$tr(tags$td("[Web] Shiny Tutorial: Build a Full Shiny Dashboard with shiny.fluent"), tags$td(tags$a(href="https://appsilon.com/shiny-fluent-tutorial/", "Link"))),
                                       tags$tr(tags$td("[Book] Mastering shiny"), tags$td(tags$a(href="https://books.google.co.uk/books?hl=en&lr=&id=CfErEAAAQBAJ&oi=fnd&pg=PP1&dq=shiny&ots=pWhv2EIgJ_&sig=FhUbZW9Qwu2c6k0GuYLbnHjv4Fs&redir_esc=y#v=onepage&q=shiny&f=false", "Link"))),
                                       tags$tr(tags$td("[Book] Web application development with R using Shiny"), tags$td(tags$a(href="https://books.google.co.uk/books?hl=en&lr=&id=FW0dDAAAQBAJ&oi=fnd&pg=PP1&dq=shiny&ots=kFddc8uqBP&sig=tqUuLBCa0-efSneUcVPvV6tHNyg&redir_esc=y#v=onepage&q=shiny&f=false", "Link")))
                                     )
                                   )
                               )
                      ),
                      
                      tabPanel("Omics Datasets Source",
                        box(width = 12,"",
                            tags$table(
                              tags$thead(
                                tags$tr(tags$th("Name"), tags$th("URL"))
                              ),
                              tags$tbody(
                                tags$tr(tags$td("[Web] Omicsdi"), tags$td(tags$a(href="https://www.omicsdi.org/", "Link"))),
                                tags$tr(tags$td("[Web] TCGA (The Cancer Genome Atlas)"), tags$td(tags$a(href="https://portal.gdc.cancer.gov/", "Link"))),
                                tags$tr(tags$td("[Web] NCBI GEO (Gene Expression Omnibus)"), tags$td(tags$a(href="https://www.ncbi.nlm.nih.gov/geo/", "Link"))),
                                tags$tr(tags$td("[Web] ArrayExpress"), tags$td(tags$a(href="https://www.ebi.ac.uk/arrayexpress/", "Link"))),
                                tags$tr(tags$td("[Web] PRIDE (Proteomics Identifications Database)"), tags$td(tags$a(href="https://www.ebi.ac.uk/pride/", "Link"))),
                                tags$tr(tags$td("[Web] MetaboLights"), tags$td(tags$a(href="https://www.ebi.ac.uk/metabolights/", "Link"))),
                                tags$tr(tags$td("[Web] ENCODE (Encyclopedia of DNA Elements)"), tags$td(tags$a(href="https://www.encodeproject.org/", "Link"))),
                                tags$tr(tags$td("[Web] GTEx (Genotype-Tissue Expression)"), tags$td(tags$a(href="https://gtexportal.org/", "Link"))),
                                tags$tr(tags$td("[Web] Human Protein Atlas"), tags$td(tags$a(href="https://www.proteinatlas.org/", "Link"))),
                                tags$tr(tags$td("[Web] 1000 Genomes"), tags$td(tags$a(href="http://www.internationalgenome.org/", "Link")))
                              )
                            )
                            )
                      ),
                      
                      tabPanel("Statistical methods and ML algorithms",
                        box(width = 12,"",
                            tags$table(
                              tags$thead(
                                tags$tr(tags$th("Name"), tags$th("URL"))
                              ),
                              tags$tbody(
                                tags$tr(tags$td("[Web] Multi-omics integration—a comparison of unsupervised clustering methodologies"), tags$td(tags$a(href="https://academic.oup.com/bib/article/20/4/1269/4758623", "Link"))),
                                tags$tr(tags$td("[Web] Computational strategies for single-cell multi-omics integration"), tags$td(tags$a(href="https://www.sciencedirect.com/science/article/pii/S2001037021001720", "Link"))),
                                tags$tr(tags$td("[Web] The group lasso for logistic regression"), tags$td(tags$a(href="https://academic.oup.com/jrsssb/article/70/1/53/7109381", "Link"))),
                                tags$tr(tags$td("[Web] Genome-wide association analysis by lasso penalized logistic regression"), tags$td(tags$a(href="https://academic.oup.com/bioinformatics/article/25/6/714/251234", "Link"))),
                                tags$tr(tags$td("[Web] Penalized logistic regression with the adaptive LASSO for gene selection in high-dimensional cancer classification"), tags$td(tags$a(href="https://www.sciencedirect.com/science/article/pii/S0957417415005618?casa_token=s04q79OPhwIAAAAA:Vur9anB9vS65fLBjGFErDdVF_7AfQLfCG41jy8_1OEZQSa3k3HlrtqROV2Xr7dTfP30S6HrAKNY", "Link"))),
                                tags$tr(tags$td("[Web] Random forest for bioinformatics"), tags$td(tags$a(href="https://link.springer.com/chapter/10.1007/978-1-4419-9326-7_11", "Link"))),
                                tags$tr(tags$td("[Web] Understanding one-way ANOVA using conceptual figures"), tags$td(tags$a(href="https://synapse.koreamed.org/articles/1156679", "Link"))),
                                tags$tr(tags$td("[Web] Random Forest"), tags$td(tags$a(href="https://meridian.allenpress.com/jim/article-abstract/47/1/31/131479/Random-Forest", "Link"))),
                                tags$tr(tags$td("[Web] Integration strategies of multi-omics data for machine learning analysis"), tags$td(tags$a(href="https://www.sciencedirect.com/science/article/pii/S2001037021002683", "Link"))),
                                tags$tr(tags$td("[Web] Multi-omics data integration by generative adversarial network"), tags$td(tags$a(href="https://academic.oup.com/bioinformatics/article/38/1/179/6355579", "Link")))
                              )))))))
      ), 
      
      tabItem(tabName = "One",
              h1("Single Dataset Preprocess"),
              fluidRow(
                box(width = 6, height = "900px", title = "Upload dataset", status = "primary", solidHeader = TRUE,
                    fileInput("file0","Upload a unpreprocess sample dataset", accept = c("text/csv",".csv")),
                    helpText("You can do some preprocess here for every single dataset"),
                    tabsetPanel(
                      tabPanel("RemoveNULL",helpText("Here is an example to Remove NULL value in the dataset"),
                               actionButton(inputId = "removenull", label = "Remove NULL", class = "custom-btn"), 
                               downloadButton("downloadrn","Export",class = "custom-btn"),
                      ),
                      
                      tabPanel("RemoveDuplicates",helpText("Here is an example to Remove Duplicate Rows in the dataset"),
                               actionButton(inputId = "removeduplicates", label = "Remove Duplicates", class = "custom-btn"), 
                      ),
                      
                      tabPanel("Min-Max",helpText("Here is an example to MinMax in the dataset"),
                               actionButton(inputId = "MinMax", label = "Min-Max",class = "custom-btn"),
                      ),
                      
                      tabPanel("PCA",helpText("Here is an example to run PCA for dataset"),
                               actionButton("doPCA", "RunPCA", class = "custom-btn"),
                               plotOutput("pcaPlot", height = "400px"),
                               plotOutput("variancePlot", height = "400px")
                      ),
                      
                      tabPanel("Note : Why Preprocess?",icon = icon("lightbulb"),
                               box(width = 12)
                              
                      ),
                      
                    )
                    
                ),
                box(width = 6, height = "900px", title = "Display Data", solidHeader = TRUE, status = "primary",
                    dataTableOutput("content")
                )
                
              )
      ),
      
      tabItem(tabName = "Earlyi",
              h1("Early ( Concatenation-based ) Integration"),
              fluidRow(
                box(width = 6, height = "200px", title = "Introduction", status = "primary", solidHeader = TRUE,
                    helpText("Introduce early integration ...................")),
                box(width = 6, height = "200px", title = "Example Data", status = "warning", solidHeader = TRUE,
                    HTML("<p><strong>Data Source: </strong>The dataset used for early integration was taken from NCBI's <strong>GSE31189</strong> series of bladder cancer datasets and was used to explore associations between DNA and phenomes. </p>
                         <p>For the horizontal integration demo, we picked a subset of the base change section to use.</p>
                         <p>For the vertically integrated demo, we picked a subset of mRNA data and phenotype data.</p>
                         "),
                    helpText("Download example datasets here,or get the full dataset from Github：",HTML("<a href='https://www.example.com'>Data</a>"), " ,",HTML("<a href='https://www.example.com'>GitHub_Link</a>")),
                    
                ),
                    

                
                box(width = 6, height = "800px",title = "Early integration methods", status = "info", solidHeader = TRUE,
                    
                    tabsetPanel(
                      tabPanel("Horizontal Concatenation", helpText("Upload two example datasets for horizontal concatenation here"),
                               fileInput("ei_hc_file1_input", "Upload Horizontal_dataset1.csv: "),
                               fileInput("ei_hc_file2_input", "Upload Horizontal_dataset2.csv: "),
                               actionButton("ei_hc_process", "Concatenate Datasets and display",class = "custom-btn"),
                               downloadButton("ei_hc_export", "Export Processed Dataset as csv",class = "custom-btn")
                      ),
                      
                      tabPanel("Vertical Concatenation",helpText("Upload two example datasets for vertical concatenation here"),
                               column(6,
                                      fileInput("ei_vc_file0_input", "Upload Vertical_unprocessed_pheno_dateset.csv: ")
                               ),
                               column(6,
                                      actionButton("Display","Display Data", class = "custom-btn"),
                                      actionButton("Transform","Transform Data", class = "custom-btn"),
                                      downloadButton("Export","Export Data", class = "custom-btn")
                               ),
                               
                               column(12,
                                      fileInput("ei_vc_file1_input","Upload Vertical_processed_pheno_dateset.csv: "),
                                      fileInput("ei_vc_file2_input","Upload Vertical_gene_dateset.csv: "),
                                      actionButton("ei_vc_process","Concatenate Datasets and display", class = "custom-btn"),
                                      downloadButton("ei_vc_export","Export Processed Dataset as csv", class = "custom-btn")
                               ),
                      ),
                      
                      tabPanel(icon = icon("lightbulb"), " Note: Vertical vs. Horizontal ?", 
                               box(width = 12, height = "600px",
                                   tags$img(src = "www/H.png", height = 200, width = 560),
                                   tags$img(src = "www/V.png", height = 200, width = 560),
                                 
                                 helpText("Material from the School of Health Sciences, University of Manchester"),
                                 HTML("<p>Also highly recommend you read the full courseware from <strong>Dr Juhi Gupta</strong></p>","<a href='https://learn-eu-central-1-prod-fleet01-xythos.content.blackboardcdn.com/5f0eeec577cec/37292194?X-Blackboard-S3-Bucket=learn-eu-central-1-prod-fleet01-xythos&X-Blackboard-Expiration=1692738000000&X-Blackboard-Signature=GA6euST1RNicjISGESxt5GIwZkKy2ZbnmAitDX22Kyc%3D&X-Blackboard-Client-Id=301771&X-Blackboard-S3-Region=eu-central-1&response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27Methods%2520of%2520data%2520integration%2520-%2520part%25201.pdf&response-content-type=application%2Fpdf&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDgaDGV1LWNlbnRyYWwtMSJGMEQCIB%2F7vF8PNrfw7uDOmzXbUVKRPYOGfzuwXpxiQXfMXyQ1AiA1wVeVy0hmQHh816IIHhsFLTcbp3qesxYBPa0sLNOsHCrHBQjx%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAMaDDYzNTU2NzkyNDE4MyIM%2FUd34kv98U83LMSnKpsFWucXJBPTRwhF8v%2BncdYUkjW29nJ1Lt7KLt10QmIkBITlg36DoLLl4Guvw24aZit4TPG7GlCDoTVBoTrpN%2BxTN5wToOMdxFS48waZ14%2BAL8KQczg03%2BAVxUpqsJqpnfmcemhBQr8msQidxkWWgpPRAC8gm5cwa98z5RTxvQwlFLQ5a%2FUDceR%2BwJ9Tr8z6nq2bjPVNqfIhd3H3Iha293sM%2FpfBba1k3bkdAiOqI%2FV3nuWNtDbbZYUU5tkoahIv3XVs74uK5Jl5%2Bm4pXynm17sKhK0pBHz%2BjggD7YFni3PfOJErqo6ppQFSWXEpCUYqWVMv7adhsxaYc0jFzzDxw2aKKUHn9auPkemJdh2yPoJVfbxyF6QSqnHl5zjT%2FBKiJyMDjLslJzB8SsjKgaKXFImb3X6eZ8i7yZv9ej3bQ%2BzpePpk%2FgkusZyeUiGcblh8mhbnanQM0khS5wWypEO3rdVyEDLvbOKX6CP%2BXExlPbUkTlcTfdJBQgr1epumqhhKGczhBDLNgURQ4qTr3Zx39pRdI7AKa54jO%2F%2B6d5N0CHfTNUe6QDBGvCkwhDc6vgnl7nQXw%2BMCmzgszf74LpGtTZK6olsbt96PMSp7bsyBAE%2FAskm9rWdj%2B7M8MdLe1bhNDG%2BaU6E57e%2Br4JywJHNI2G0ty47RwazkMy4y%2BHwSfojs6SV%2BmwsNfwyZayIghEDvM1zrvFhla9bR3k4XLQZKWOqz%2FnYL4j7rIOUcjCTZF%2BVhto%2F6k%2FIAv7Th%2BEuGFWzfoXialhpTIDHFcW%2BlgCqeqNKL%2B8gYOZCgv8R72flaIURg5RQugifpPnfn%2BByp6HlYWupEW4VxChag%2FOsTz8Gjg2e1UUAMRezIiud5uflGxq0RtklpMj6yuOUBJudsxzDqvZOnBjqyAXAChrXOn64aqsWqjOpXy40Q2xPywzZo5sqRdLG%2FcKH%2BhB574eD37Tc3tBmp3MAQ%2BC6fYGyNo7afIU08HGAGkX6Z2RW9QEvfyrJQeKSAud%2B0qZHNinsONeGtfdKMfdyjqFF2AsxjsdSh79zLzwlxM0kIh%2FdGqskSHJgXi3MMHV70lfk8fXeClOqb%2FYIfb9ekn7joffsh%2BxwIarGs2SoLpcnVPXqfyzUMTHpf6lehNrKhli0%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230822T150000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=ASIAZH6WM4PLWX4S6X5I%2F20230822%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Signature=fdbab19ca663b3c6c61377b95f1d60a179e5e5c532473ab8041a5240358817b1'>Link</a>")
                                 
                               )
                               
                               
                               )
                    )
                ),
                
                box(width = 6, height = "800px", title = "Data display", status = "success", solidHeader = TRUE,
                    
                    dataTableOutput("concatenated_data_table")
                    
                )
              )
      ),
      
      tabItem(tabName = "Intermediatei",
              h1("Intermediate ( Transformation-based ) Integration"),
              fluidRow(
                box(width = 6, height = "200px", title = "Introduction", status = "primary", solidHeader = TRUE,
                    helpText("Introduce early integration ..................."),
                    ),
                
                box(width = 6, height = "200px", title = "Example Data", status = "warning", solidHeader = TRUE,
                    HTML("<p><strong>Data Source: </strong>The dataset used for intermediate integration was taken from TCGA's <strong>breast cancer dataset</strong> . Used to explore the association between mRNA , protein and sample subtype in different breast cancer subtypes.. </p>
                         <p>In order to obtain a better variability of the results, we provide two sets of data, corresponding to the normalised data of the original data and the manually hashed data..</p>
                         "),
                    helpText("Download example datasets here,or get the full dataset from Github：",HTML("<a href='https://www.example.com'>Data</a>"), " ,",HTML("<a href='https://www.example.com'>GitHub_Link</a>")),
                    ),
                    
                
                
                box(width = 6, height = "800px", status = "info", title = "Intermediate Integration", solidHeader = TRUE, 
                    fileInput("clinical_data_input", "Upload Clinical Data"),
                    fileInput("mrna_data_input", "Upload mRNA Data"),
                    fileInput("protein_data_input", "Upload Protein Data"),
                    actionButton("process_data", "Process Data", class = "custom-btn"),
                    actionButton("show_plot", "Show Network Plot", class = "custom-btn"),
                    actionButton("show_heatmap", "Show Heatmap", class = "custom-btn"),
                    actionButton("show_density", "Show Density Plot", class = "custom-btn")
                    
                ),
                
                box(width = 6, height = "800px", title = "Data display", status = "success", solidHeader = TRUE,
                    
                    tabsetPanel(
                      tabPanel("Network Plot",plotOutput("plot_output")),
                      tabPanel("Heatmap Plot",plotOutput("heatmap_output")),
                      tabPanel("Density Plot",plotOutput("density_output"))
                      
                    ),
                    
                   
                )
              )
      ),
      
      tabItem(tabName = "Latei",
              h3("Late ( Model-based ) Integration"),
              fluidRow(
                box(width = 12, height = "200px", title = "Introduction", status = "primary", solidHeader = TRUE,
                    helpText("Introduce early integration ...................")),
                
                
                box(width = 4, height = "800px", status = "info", title = "ANOVA", solidHeader = TRUE,
                    fluidRow(
                      box(width = 12,
                          fileInput("anova_input", "Choose Clinical-Related dataset:", accept = c("text/csv", ".csv")),
                          actionButton("anova_process", "ANOVA", class = "custom-btn"),
                          ),
                      box(width = 12,
                          tabsetPanel(
                            tabPanel("ANOVA Results", dataTableOutput("anova_results")),
                            tabPanel("Top 10 Variants by F-value", plotOutput("anova_plot")),
                            tabPanel("Variants Levels across Subtypes", plotOutput("subtype_plot"))
                          )
                          )
                    ),
                    
                    
                    
                ),
                
                box(width = 4, height = "800px", title = "RandomForest", status = "success",solidHeader = TRUE,
                    fluidRow(
                      box(width = 12,
                          fileInput("rf_input", "Choose Clinical-Related dataset:", multiple = FALSE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                          actionButton("rf_process", "Random Forest", class = "custom-btn"),
                      ),
                      
                      box(width = 12,
                          tabsetPanel(
                            tabPanel("Confusion Matrix", dataTableOutput("rf_results")),
                            tabPanel("Feature Importance", plotOutput("importance_plot")),
                            tabPanel("Variants by Subtype", plotOutput("subtype_gene_plot")),
                            tabPanel("Error Rate", plotOutput("error_plot"))
                          )
                      )
                    )
                ),
                
              
                box(width = 4, height = "800px", title = "LASSO Logistic Regression", status = "success",solidHeader = TRUE,
                    fluidRow(
                      box(width = 12,
                          fileInput("lasso_input", "Choose Clinical-Related dataset:", multiple = FALSE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                          actionButton("lasso_process", "Run LASSO Analysis", class = "custom-btn"),
                          selectInput("subtype_select", "Select Subtype", "")
                          ),
                      box(width = 12,
                          tabsetPanel(
                            tabPanel("LASSO Results", dataTableOutput("lasso_results")),
                            tabPanel("Variant Importance", plotOutput("gene_plot")),
                            tabPanel("Correlation Network", plotOutput("correlation_plot"))
                          )
                      ))
                  )
                )
              ),
      
      tabItem(tabName = "contact",
              h2("Contact Us"),
              p("Please fill in the following details and we'll get back to you as soon as possible."),
              textInput("contact_name", "Your Name"),
              textInput("contact_email", "Your Email"),
              textAreaInput("contact_message", "Your Message", width = 800, height = 300),
              actionButton("send_message", "Send")
      )
    )
  )
)

# 定义server部分
server <- function(input, output, session) {
  
  ######### ######### ######### ######### ######### ######### ######### ######### ######### #########
  ######### Data Preprocess
  ######### ######### ######### ######### ######### ######### ######### ######### ######### #########
  
  # 创建一个反应式表达式来读取上传的 CSV 文件
  data0 <- reactive({
    inFile0 <- input$file0
    if (is.null(inFile0)) {
      return(NULL)
    }
    read.csv(inFile0$datapath)
  })
  
  # 创建一个反应式值来存储处理过的数据
  processedData <- reactiveVal()
  
  # 当 data0 更新时，更新 processedData
  observe({
    processedData(data0())
  })
  
  # 当用户点击按钮时，删除全为0的行并更新 processedData
  observeEvent(input$removenull, {
    data <- processedData()
    if (!is.null(data)) {
      newData <- data[which(rowSums(data==0)==0),]
      if (nrow(newData) < nrow(data)) {
        processedData(newData)
        showNotification("Successful deletion of target row！", type = "message", duration = 3, closeButton = FALSE)
      } else {
        showNotification("No target row exists！", type = "warning", duration = 3, closeButton = FALSE)
      }
    }
  })
  
  # 当用户点击按钮时，删除重复行并更新 processedData
  observeEvent(input$removeduplicates, {
    data <- processedData()
    if (!is.null(data)) {
      newData <- data[!duplicated(data),]
      if (nrow(newData) < nrow(data)) {
        processedData(newData)
        showNotification("Successful deletion of duplicates！", type = "message", duration = 3, closeButton = FALSE)
      } else {
        showNotification("No duplicate rows！", type = "warning", duration = 3, closeButton = FALSE)
      }
    }
  })
  
  # 当用户点击按钮时，进行Min-Max标准化并更新 processedData
  observeEvent(input$MinMax, {
    data <- processedData()
    if (!is.null(data)) {
      # Extracting gene expression data without SampleID
      gene_data <- data[, -1]
      
      # Min-Max normalization
      min_vals <- apply(gene_data, 2, min)
      max_vals <- apply(gene_data, 2, max)
      normalized_data <- sweep(gene_data, 2, min_vals, `-`)
      normalized_data <- sweep(normalized_data, 2, max_vals - min_vals, `/`)
      
      # Combine SampleID and normalized data
      data_normalized <- cbind(data$SampleID, normalized_data)
      
      processedData(data_normalized)
      showNotification("Successful Min-Max standardisation！", type = "message", duration = 3, closeButton = FALSE)
    }
  })
  
  observeEvent(input$doPCA, {
    data_normalized <- processedData() # 假设processedData()返回Min-Max标准化后的数据
    if (!is.null(data_normalized)) {
      # Conducting PCA on the normalized data (excluding SampleID column)
      pca_result <- prcomp(data_normalized[, -1], scale = FALSE)
      
      # Extracting the first two principal components
      pca_data <- as.data.frame(pca_result$x[, 1:2])
      
      # Visualizing the PCA result using ggplot2
      pca_plot <- ggplot(pca_data, aes(x = PC1, y = PC2)) + 
        geom_point(aes(color = data_normalized$SampleID)) + 
        theme_minimal() + 
        labs(title = "PCA Plot", x = "Principal Component 1", y = "Principal Component 2") +
        theme(plot.title = element_text(hjust = 0.5))
      
      
      # Bar plot for variance explained by each principal component
      explained_var <- data.frame(component = 1:length(pca_result$sdev), variance = (pca_result$sdev^2)/sum(pca_result$sdev^2))
      explained_var$cumulative_variance <- cumsum(explained_var$variance)
      
      var_plot <- ggplot(explained_var, aes(x = as.factor(component))) +
        geom_bar(aes(y = variance), stat = "identity", fill = "skyblue") +
        geom_line(aes(y = cumulative_variance), group = 1, color = "red", size = 1) +
        geom_point(aes(y = cumulative_variance), color = "red") +
        labs(
          title = "Variance Explained by Each Principal Component",
          x = "Principal Component",
          y = "Variance Explained (%)"
        ) +
        theme(plot.title = element_text(hjust = 0.5))
      
      
      
      output$pcaPlot <- renderPlot({ pca_plot })
      output$variancePlot <- renderPlot({ var_plot }) # Add this line to render the variance explained plot
      
      showNotification("Successful PCA treatment！", type = "message", duration = 3, closeButton = FALSE)
    }
  })
  

  # 使用 processedData 来渲染表格
  output$content <- renderTable({
    processedData()
  })
  
  # 处理下载请求
  output$downloadrn <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(processedData(), file, row.names = FALSE)
    }
  )
  

  ####################################################################################################
  #  Horizontal Integration
  ####################################################################################################
  
  # Reactive value to store concatenated dataset for horizontal integration
  concatenated_data <- reactiveVal()
  
  observeEvent(input$ei_hc_process, {
    # Read in the datasets from fileInputs
    file1 <- read.csv(input$ei_hc_file1_input$datapath)
    file2 <- read.csv(input$ei_hc_file2_input$datapath)
    
    # Check if column names of the two datasets match
    if (!identical(colnames(file1), colnames(file2))) {
      showModal(modalDialog(
        title = "Error",
        "Data doesn't match horizontal integration requirements. Please recheck and preprocess the datasets.",
        easyClose = TRUE
      ))
      return()
    }
    
    # Horizontal concatenation of the two datasets
    combined <- cbind(file1, file2)
    
    # Store combined data in reactive value
    concatenated_data(combined)
  })
  
  # Display the concatenated dataset for horizontal integration
  output$concatenated_data_table_ <- renderDataTable({
    concatenated_data()
  })
  
  # Provide download functionality for the concatenated dataset for horizontal integration
  output$ei_hc_export <- downloadHandler(
    filename = function() {
      "Horizontal_Integrated_Data.csv"
    },
    content = function(file) {
      write.csv(concatenated_data(), file, row.names = FALSE)
    }
  )
  
  ####################################################################################################
  #  Vertical Integration
  ####################################################################################################
  
  # Reactive value to store concatenated dataset
  concatenated_data <- reactiveVal()
  
  observeEvent(input$ei_vc_process, {
    # Read in the datasets from fileInputs
    file1 <- read.csv(input$ei_vc_file1_input$datapath)
    file2 <- read.csv(input$ei_vc_file2_input$datapath)
    
    # Check if column names of the two datasets match
    if (!identical(colnames(file1), colnames(file2))) {
      showModal(modalDialog(
        title = "Error",
        "Processed Data不符合垂直整合的字段要求，请重新检查并处理数据集",
        easyClose = TRUE
      ))
      return()
    }
    
    # Vertical concatenation of the two datasets
    combined <- rbind(file1, file2)
    
    # Store combined data in reactive value
    concatenated_data(combined)
  })
  
  # Display the concatenated dataset
  output$concatenated_data_table <- renderDataTable({
    concatenated_data()
  })
  
  # Provide download functionality for the concatenated dataset
  output$ei_vc_export <- downloadHandler(
    filename = function() {
      "Vertical_Integrated_Data.csv"
    },
    content = function(file) {
      write.csv(concatenated_data(), file, row.names = FALSE)
    }
  )
  
  
  ####################################################################################################
  #  Intermediate Integration
  ####################################################################################################

  g_reactive <- reactiveVal()
  data_reactive <- reactiveVal()
  similarity_matrix_reactive <- reactiveVal()
  
  observeEvent(input$process_data, {
    # 数据读取
    clinical_data <- read.csv(input$clinical_data_input$datapath)
    og_mrna_data <- read.csv(input$mrna_data_input$datapath)
    og_protein_data <- read.csv(input$protein_data_input$datapath)
    
    # 合并数据
    merged_data <- merge(merge(clinical_data, og_mrna_data, by="SampleID"), og_protein_data, by="SampleID")
    
    # 创建一个空图
    g <- graph.empty(directed = FALSE)
    
    # 添加节点
    g <- add_vertices(g, nrow(merged_data), name=merged_data$SampleID, type="SampleID")
    genes <- colnames(og_mrna_data)[-1]
    proteins <- colnames(og_protein_data)[-1]
    g <- add_vertices(g, length(genes), name=genes, type="Gene")
    g <- add_vertices(g, length(proteins), name=proteins, type="Protein")
    subtypes <- unique(merged_data$Subtype)
    g <- add_vertices(g, length(subtypes), name=subtypes, type="Subtype")
    
    # 添加样本与基因、蛋白质和亚型的边
    for (i in 1:nrow(merged_data)) {
      sample <- merged_data$SampleID[i]
      for (gene in genes) {
        weight_value <- merged_data[i, gene]
        g <- add_edges(g, c(sample, gene), weight=weight_value)
      }
      for (protein in proteins) {
        weight_value <- merged_data[i, protein]
        g <- add_edges(g, c(sample, protein), weight=weight_value)
      }
      subtype <- merged_data$Subtype[i]
      g <- add_edges(g, c(sample, subtype))
    }
    
    # 计算样本间的余弦相似度
    expressions <- merged_data[, !(names(merged_data) %in% c("SampleID", "Subtype"))]
    similarity_matrix <- proxy::dist(expressions, method = "cosine")
    similarity_matrix <- as.matrix(similarity_matrix)
    
    
    # 添加相似度大于0.98的边
    for (i in 1:(nrow(merged_data) - 1)) {
      for (j in (i + 1):nrow(merged_data)) {
        if (1 - similarity_matrix[i, j] > 0.999) {
          g <- add_edges(g, c(merged_data$SampleID[i], merged_data$SampleID[j]), weight=1 - similarity_matrix[i, j])
        }
      }
    }
    
    # 将处理后的图保存到reactiveVal
    g_reactive(g)
    
    # 将相似性矩阵保存到reactiveVal
    similarity_matrix_reactive(similarity_matrix)
    
    # 将处理后的数据保存到reactiveVal
    data_reactive(merged_data)
  })
  
  output$plot_output <- renderPlot({
    # 检查是否按下了"Show Plot"按钮
    if (input$show_plot > 0) {
      # 使用 ggraph 进行可视化
      g <- g_reactive()
      ggraph(g, layout = 'fr') + 
        geom_edge_link(aes(edge_alpha = weight), edge_linewidth = 1, show.legend = FALSE) +
        geom_node_point(aes(color = type), size = 3) +
        geom_node_text(aes(label = name), vjust = 0.5, hjust = 0.5, size = 3) + 
        theme_void() + 
        theme(legend.position = "right")
    }
  })
  
  output$heatmap_output <- renderPlot({
    if (input$show_heatmap > 0) {
      similarity_matrix <- similarity_matrix_reactive()
      
      # 将相似性矩阵转换为长格式数据框
      long_data <- as.data.frame(as.table(1 - similarity_matrix))
      
      # 使用ggplot2创建热图
      heatmap_plot <- ggplot(long_data, aes(Var1, Var2, fill = Freq)) +
        geom_tile() +
        scale_fill_viridis_c() +  # 使用viridis颜色方案
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              axis.title.x = element_blank(),
              axis.title.y = element_blank())
      
      print(heatmap_plot)
    }
  })
  
  output$density_output <- renderPlot({
    # 检查是否按下了"Show Density Plot"按钮
    if (input$show_density > 0) {
      data <- data_reactive()
      
      long_data <- data %>% 
        pivot_longer(cols = -c(SampleID, Subtype), names_to = "type", values_to = "expression")
      
      # 使用ggplot2创建密度图
      ggplot(long_data, aes(x = expression, fill = type)) +
        geom_density(alpha = 0.5) +
        labs(title = "Density Plot of Gene and Protein Expressions",
             x = "Expression Value",
             y = "Density") +
        theme_minimal()
    }
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ####################################################################################################
  #  Late Integration
  ####################################################################################################
 
  #########################
  # ANOVA
  #########################
  
  observeEvent(input$anova_process, {
    
    inFile <- input$anova_input
    if(is.null(inFile)){
      return(NULL)
    }
    
    data <- read.csv(inFile$datapath)
    
    results <- data.frame(Gene=character(), F_value=numeric(), P_value=numeric(), stringsAsFactors=FALSE)
    
    for (gene in colnames(data)[3:ncol(data)]) {   # 注意这里修改了数据引用
      formula_str <- paste(gene, "~ Subtype")
      aov_model <- aov(as.formula(formula_str), data=data)   # 注意这里修改了数据引用
      summary_aov <- summary(aov_model)
      
      f_val <- summary_aov[[1]]$'F value'[1]
      p_val <- summary_aov[[1]]$'Pr(>F)'[1]
      
      results <- rbind(results, data.frame(Gene=gene, F_value=f_val, P_value=p_val))
    }
    
    sorted_results <- results[order(-results$F_value), ]
    top_genes <- head(sorted_results, 10)$Gene
    
    bar_color <- "skyblue"
    
    color_palette <- c(
      "#D32F2F", # Red
      "#1976D2", # Blue
      "#388E3C", # Green
      "#FBC02D", # Yellow
      "#8E24AA", # Purple
      "#F57C00", # Orange
      "#0288D1", # Light Blue
      "#7B1FA2", # Deep Purple
      "#C2185B", # Pink
      "#00796B"  # Teal
    )
    
    
    output$anova_plot <- renderPlot({
      ggplot(head(sorted_results, 10), aes(x=reorder(Gene, -F_value), y=F_value)) + 
        geom_bar(stat="identity", fill=bar_color) +  # 使用指定的颜色
        theme_minimal() + 
        labs(title="Top 10 variants on subtype based on ANOVA", y="F-value") + 
        theme(plot.title = element_text(hjust = 0.5))
      
      
    })
    
    mean_methylation <- data %>%
      group_by(Subtype) %>%
      summarise(across(all_of(top_genes), mean))
    
    output$subtype_plot <- renderPlot({
      ggplot(melt(mean_methylation, id.vars = "Subtype"), aes(x=Subtype, y=value, fill=variable)) + 
        geom_bar(stat="identity", position="dodge") + 
        scale_fill_manual(values = color_palette) +
        theme_minimal() + 
        labs(title="Variants levels of top genes across subtypes", y="Variants Level", x="Subtype") + 
        theme(plot.title = element_text(hjust = 0.5))
    })
    
    output$anova_results <- renderDataTable({
      head(sorted_results, 10)
    })
    
  })
  
  #########################
  # Random Forest
  #########################

  observeEvent(input$rf_process, {
    
    inFile <- input$rf_input
    if (is.null(inFile)) {
      return(NULL)
    }
    
    data <- read.csv(inFile$datapath)
    
    # 数据划分
    set.seed(123)
    trainIndex <- createDataPartition(data$Subtype, p = .7, list = FALSE)
    data_train <- data[trainIndex, ]
    data_test <- data[-trainIndex, ]
    
    target_train <- as.factor(data_train$Subtype)
    data_rf_train <- data_train[, -1]
    data_rf_train <- data_rf_train[, -1]
    
    # 使用Random Forest进行分析
    rf_model <- randomForest(data_rf_train, y = target_train, importance = TRUE)
    
    # 提取特征重要性
    importance_data <- as.data.frame(importance(rf_model))
    
    # 绘制特征重要性条形图
    output$importance_plot <- renderPlot({
      top_features <- importance_data %>% 
        rownames_to_column(var="Gene") %>%
        top_n(10, MeanDecreaseAccuracy)
      
      ggplot(top_features, aes(x=reorder(Gene, MeanDecreaseAccuracy), y=MeanDecreaseAccuracy)) + 
        geom_bar(stat="identity", fill="steelblue") + 
        coord_flip() +
        theme_minimal() + 
        labs(title="Top 10 genes based on Random Forest Importance", y="Importance", x="Gene")
    })
    
    # 绘制为每个特定亚型的平均甲基化水平的前10个基因
    output$subtype_gene_plot <- renderPlot({
      # 提取所有的亚型
      subtypes <- unique(data$Subtype)
      
      # 列表，用于存储每个亚型的前10个基因及其平均甲基化水平
      top_genes_list <- list()
      
      # 对每个亚型进行操作
      for (subtype in subtypes) {
        subtype_data <- data[data$Subtype == subtype, ]
        
        # 计算平均甲基化水平
        gene_means <- colMeans(subtype_data[, 3:ncol(data)], na.rm = TRUE)
        
        # 对基因按平均甲基化水平进行排序，并提取前10个
        top_genes <- sort(gene_means, decreasing = TRUE)[1:10]
        top_genes_df <- data.frame(Gene = names(top_genes), Methylation = as.numeric(top_genes), Subtype = subtype)
        top_genes_list[[subtype]] <- top_genes_df
      }
      
      # 合并所有的结果
      final_data <- do.call(rbind, top_genes_list)
      
      # 绘制条形图
      ggplot(final_data, aes(x = Gene, y = Methylation, fill = Subtype)) +
        geom_bar(stat = "identity", position = "dodge") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Top 10 genes with highest mRNA level per subtype", y = "Average mRNA Level", x = "Gene")
    })
    
    # 绘制误差率图
    output$error_plot <- renderPlot({
      plot(rf_model, ylim=c(0, 1), main="Error Rate vs. Number of Trees")
    })
    
    # 显示混淆矩阵
    output$rf_results <- renderDataTable({
      rf_model$confusion
    })
    
  })
  
  #########################
  # LASSO Logistic Regression
  #########################
  
  observeEvent(input$lasso_process, {
    
    # 检查是否上传了文件
    inFile <- input$lasso_input
    if (is.null(inFile)) {
      return(NULL)
    }
    
    # 加载数据
    data <- read.csv(inFile$datapath)
    
    # 更新下拉菜单的选择
    updateSelectInput(session, "subtype_select", choices = unique(data$Subtype))
    
    all_results <- list() # 存储每个亚型的结果
    
    # 对每个亚型进行循环
    for(subtype in unique(data$Subtype)) {
      
      # 创建二分类响应变量
      y <- ifelse(data$Subtype == subtype, 1, 0)
      
      # 确保数据中只有数值型数据
      x_train <- as.matrix(data[, sapply(data, is.numeric)])
      
      # 执行LASSO回归
      lasso_model <- cv.glmnet(x_train, y, alpha=1)
      
      coef_matrix <- as.matrix(coef(lasso_model, s=lasso_model$lambda.min))
      non_zero_coefs <- coef_matrix[coef_matrix != 0]
      genes <- rownames(coef_matrix)[coef_matrix != 0]
      
      coef_df <- data.frame(Gene = genes, Coefficient = non_zero_coefs)
      top_genes <- coef_df[order(abs(coef_df$Coefficient), decreasing = TRUE)[1:10], ]
      
      # 保存结果
      all_results[[subtype]] <- top_genes
    }
    
    
    # 输出结果到Dashboard
    output$lasso_results <- renderDataTable({
      DT::datatable(all_results[[input$subtype_select]])
    })
    
    # 输出可视化到Dashboard
    output$gene_plot <- renderPlot({
      selected_genes <- all_results[[input$subtype_select]]
      ggplot(selected_genes, aes(x=reorder(Gene, Coefficient), y=Coefficient)) + 
        geom_bar(stat='identity') +
        coord_flip() + 
        ggtitle(paste("Top 10 genes for", input$subtype_select)) +
        xlab("Gene") + 
        ylab("Coefficient") +
        theme(plot.title = element_text(hjust = 0.5))
    })
    

    
    
    # 输出相关性网络图到Dashboard
    output$correlation_plot <- renderPlot({
      
      # 计算相关性
      genes <- genes[genes %in% colnames(data)] # 仅保留数据框中存在的基因名
      
      corr_matrix <- cor(data[, genes])
      
      # 创建网络图
      graph <- graph_from_adjacency_matrix(corr_matrix, mode="undirected", weighted=TRUE, diag=FALSE)
      graph <- simplify(graph) # 移除自环和重复的边
      
      # 只显示相关性大于0.7的边
      graph <- delete.edges(graph, E(graph)[abs(E(graph)$weight) <= 0.5])
      
      # 绘制网络图
      plot(graph, vertex.label.cex=0.8, edge.width=E(graph)$weight*2, main="Correlation Network of Top Genes")
    })
    
    
  })
  
    
    observeEvent(input$send_message, {
      
      showNotification("Thank you, we are happy to receive your feedback and will be in touch as soon as possible!", type = "message")
      
    })
    
  
  
    
}

shinyApp(ui, server)