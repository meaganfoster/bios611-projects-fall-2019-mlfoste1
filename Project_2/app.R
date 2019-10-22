library(shiny)
library(tidyverse)

UMD_df = read_tsv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv", na = '**')

# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Dashboard"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Integer for the year ----
      numericInput(inputId = "year",
                   label = "Number of year:",
                   min = 2006,
                   max = 2017,
                   value = 2016)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram and table----
      plotOutput(outputId = "popPlot"),
      dataTableOutput(outputId = "popTable")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # renderPlot creates histogram and links to ui
  output$popPlot <- renderPlot({
    year = seq(min(UMD_df$[Food Provided for], na.rm = T), 
               max(UMD_df$[Food Provided for], na.rm = T), 
               length.out = input$year + 1)
    
    ggplot(UMD_df, aes(x=[Food Provided for])) +
      geom_histogram(breaks = year) +
      labs(x = "[Food Provided for] size",
           title = "Histogram of Food Provided for") +
      scale_y_log10()
  })
  
  # Data table output, linked to ui
  output$popTable <- renderDataTable({UMD_df})
}

shinyApp(ui = ui, server = server)
