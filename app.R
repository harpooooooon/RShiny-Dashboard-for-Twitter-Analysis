# libraries ####
library(shiny)
library(shinydashboard)
library(ggplot2)
library(twitteR)
library(lubridate)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(stringr)


# ui ####
ui <- dashboardPage(
  
  dashboardHeader(title = "Twitter Analysis"),
  dashboardSidebar(
  #sidebar menu ####
    sidebarMenu(
      menuItem(
        "charts",
        tabName = "charts",
        icon = icon("stats", lib = "glyphicon")
      ),
      menuItem(
        "strata analysis",
        tabName = "strata_analysis",
        icon = icon("align-center", lib = "glyphicon")
      ),
      menuItem(
        "raw data",
        tabName = "raw_data",
        icon = icon("th", lib = "glyphicon")
      ),
      #intputs ####
      textInput( 
        inputId = "twitter_handle",
        label = "Enter twitter handle",
        width = 300,
        value = ""),
      sliderInput(
        inputId = "tweet_num",
        label = "Number of tweets",
        min = 0, max = 1000,
        value = 500),
      actionButton(
        inputId = "click",
        label = "submit"
      )
    )
  ),
  #dashboard ####
  dashboardBody(
    tabItems(
      #chart tab ####
      tabItem(
        tabName = "charts",
        fluidRow(
          box(plotOutput("tweets_per_day", width = "auto")),
          box(plotOutput("tweets_per_hour", width = "auto")),
          box(plotOutput("source", width = "auto")),
          box(plotOutput("cloud", width = "auto", height = 450)),
            box(verbatimTextOutput("info1")),
          box(plotOutput("fav_vs_rt", click = "plot_click1", width = "auto")),
            box(verbatimTextOutput("info2")),
          box(plotOutput("fav_vs_rt_per_tweet", click = "plot_click2", width = "auto"))
        )
      ),
    
      #strata analysis tab ####
      tabItem(
        tabName = "strata_analysis",
        fluidRow(
          dataTableOutput("strata_table")
        )
      ), 
      
      #raw data tab ####
      tabItem(
        tabName = "raw_data",
        fluidRow(
          dataTableOutput('raw_data_table')  
        )
      )
    )
  )
)

# authenitcation ####
setup1()

# server ####
server <- function(input, output){
  
  #declaring vaiables and associated plotes dependent on user inputs
  observeEvent(input$click, {
    #inputs ####
    handel <- isolate({as.character(input$twitter_handle)})
    sample_size <- isolate({input$tweet_num})
    
    #sourcing tweets ####
    tweets <- reactive({
      form_tweet_df(handel, sample_size)
    })
    
    #plotting tweets per day  ####
    output$tweets_per_day <- renderPlot({
      tweet_per_day(tweets())
    })
    
    #plotting tweets per hour ####
    output$tweets_per_hour <- renderPlot({
      tweets_per_hour(tweets())
    })
    
    #strata analysis ####
    output$strata_table <- renderDataTable(
      rt_fav_frequency_table(tweets(), size = 20)
    )
    #plotting log (fav vs. retweet) ####
    output$fav_vs_rt <- renderPlot({
      fav_retweet_ratio(tweets())
    })
    #making the points interactive
    output$info1 <- renderText({
      paste0("x = ", input$plot_click1$x,"\n",
             "y = ", input$plot_click1$y)
    })
    
    #plotting fav vs retweet ratio per tweet ####
    output$fav_vs_rt_per_tweet <- renderPlot({
      fav_rt_ratio_per_tweet(tweets())
    })
    #making the points interactive
      output$info2 <- renderText({
      paste0("x = ", input$plot_click2$x, "\n",
             "y = ", input$plot_click2$y)
              
    })
    
    #plotting source ####
    output$source <- renderPlot({
      tweet_source(tweets())
    })
    
    #plotting the word cloud of aggregated terms ####
    output$cloud <- renderPlot({
      word_cloud(tweets(), 60)
    })  
    
    #plotting the raw datatable ####
      output$raw_data_table <- renderDataTable(
        display_data(tweets())
      )
      
      
  })
}

#initiate application ####
shinyApp(ui = ui,
         server = server)
