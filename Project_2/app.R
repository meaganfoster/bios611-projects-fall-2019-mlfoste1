library(shiny)
library(tidyverse)

#UMD_df = read_tsv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv", na = '**')

source("helper_functions.R",local = F)

# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("UMD TO PIT: Dashboard"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel("TESTING",
      
      # Input: Integer for the year ----
      selectInput(inputId = "yearinput",
                   label = "Number of year:",
                   choices = list("2006","2007", "2008",
                                  "2009", "2010", "2011",
                                  "2012","2013","2014",
                                  "2015","2016"),
                   selected = 1)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram and table----
      plotOutput(outputId = "serv_reprt")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # renderPlot creates histogram and links to ui
  output$serv_reprt <- renderPlot({
    serv_reprt_plot(input$yearinput)
  })

  
  # Data table output, linked to ui
 # output$popTable <- renderDataTable({inputSserv_reprt_df})

}
shinyApp(ui = ui, server = server)