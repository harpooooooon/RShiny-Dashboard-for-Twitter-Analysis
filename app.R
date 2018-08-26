# Libraries ####
library(shiny)
library(shinydashboard)
library(stats)
library(plotly)
library(ggExtra)

# ui ####
ui <- dashboardPage(
  # header ####
  dashboardHeader(title = "Visualizing Statistics",
                  titleWidth = 250),
  # side bar ####
  dashboardSidebar(
    sidebarMenu(
     menuItem(
       "Distrubutions",
        tabName = "Distributions",
        icon = icon("stats", lib = "glyphicon")
      ),
     menuItem(
       "Regression Analysis",
       tabName =  "Regression Analysis",
       icon = icon("fa fa-info-circle")
     )
    )
  ),
  
  # body ####
  dashboardBody(
    tabItems(
    # Distribution ####  
      tabItem(
        tabName = "Distributions",
        fluidPage(
          # Normal Distribution ####
          box(title = "Normal Distribution Controls",
              sliderInput(inputId = "norm_mu",
                          label = "Mean of Distribution",
                          min = 0, max = 500, value = 250, step = 1),
              sliderInput(inputId = "norm_sigma",
                          label = "Variance of Distribution",
                          min = 0, max = 50, value = 25, step = 1),
              width = 3),
          box(plotlyOutput(outputId = "Normal_Distribution"),
              width = 9),
          
          
          # F Distribution ####
          box(title = "F Distribution Controls",
              sliderInput(inputId = "f_df1",
                          label = "Primary Degree of Freedom",
                          min = 0, max = 500, value = 250, step = 1),
              sliderInput(inputId = "f_df2",
                          label = "Secondary Degree of Freedom",
                          min = 0, max = 500, value = 250, step = 1),
              width = 3),
          box(plotlyOutput(outputId = "F_Distribution"),
              width = 9),
          
          
          
          # Poisson Distribution ####
          box(title = "Poisson Distribution Controls",
              sliderInput(inputId = "pois_lambda",
                          label = "Lambda of Distribution",
                          min = 0, max = 500, value = 250, step = 1),
              width = 3),
          box(plotlyOutput(outputId = "Poisson_Distribution"),
              width = 9),
         
          
          # Binomial Distribution ####
          box(title = "Binomial Distribution Controls",
              sliderInput(inputId = "bi_prob",
                          label = "% Probability of Event Occuring",
                          min = 0, max = 1, value = 0.5, step = 0.05),
              sliderInput(inputId = "bi_trials",
                          label = "Number of Trials",
                          min = 0, max = 500, value = 250, step = 1),
              width = 3),
          box(plotlyOutput(outputId = "Binomial_Distribution"),
              width = 9),
          
          
          # Chi Square Distribution ####
          box(title = "Chi Sqaure Distribution Controls",
              sliderInput(inputId = "chi_df",
                          label = "Degrees of Freedom",
                          min = 0, max = 500, value = 250, step = 1),
              width = 3),
          box(plotlyOutput(outputId = "Chi_Square_Distribution"),
              width = 9),
          
          
          # T Distribution ####
          box(title = "T Distribution Controls",
              sliderInput(inputId = "t_df",
                          label = "Primary Degree of Freedom",
                          min = 0, max = 500, value = 250, step = 1),
              width = 3), 
          box(plotlyOutput(outputId = "T_Distribution"),
              width = 9)
        )
      ),
    # Regression Analysis ####
      tabItem(
        tabName = "Regression Analysis",
        fluidPage(
          # Input Parameters ####
          box(sliderInput(inputId = "reg_sd",
                        label = "Standard Deviation",
                        min = 0, max = 50, value = 25, step = 1), 
              sliderInput(inputId = "reg_sample",
                          label = "Sample Size",
                          min = 50, max = 500, value = 250, step = 10), 
              width = 4),
          # Plots ####
          box(plotlyOutput(outputId = "Regression"),
              width = 4),
          box(plotOutput(outputId = "Error"),
              width = 4)
        )
      )
  # end ####
    )
  )
)

    

# server ####
server <- function(input, output, ...){
  # Distributions ####
    # Normal Distrbution ####
    output$Normal_Distribution <- renderPlotly({
        df <- data.frame(x = rnorm(mean = input$norm_mu,
                                   sd = input$norm_sigma, 
                                   n = 100))
        plot1 <- ggplot(df, aes(x)) +
          geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "steelblue") + 
          geom_density(fill = "#b3a4a4", alpha = 0.5) + 
          theme(panel.background = element_rect(fill = '#ffffff'))   
        
        ggplotly(plot1)
      })
    
    
    # F Distribution ####
    output$F_Distribution <- renderPlotly({
      df <- data.frame(x = rf(df1 = input$f_df1,
                              df2 = input$f_df2, 
                              n = 100))
      plot2 <- ggplot(df, aes(x)) +
        geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "steelblue") + 
        geom_density(fill = "#b3a4a4", alpha = 0.5) + 
        theme(panel.background = element_rect(fill = '#ffffff'))   
      
      ggplotly(plot2)
    })
    
    
    # Poisson Distribution ####
    output$Poisson_Distribution <- renderPlotly({
      df <- data.frame(x = rpois(lambda = input$pois_lambda,
                                 n = 100))
      
      plot3 <- ggplot(df, aes(x)) +
        geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "steelblue") + 
        geom_density(fill = "#b3a4a4", alpha = 0.5) + 
        theme(panel.background = element_rect(fill = '#ffffff'))   
      
      ggplotly(plot3)
    })
    
    # Binomial Distribution ####
    output$Binomial_Distribution <- renderPlotly({
      df <- data.frame(x = rbinom(p = input$bi_prob,
                                  size = input$bi_trials,
                                  n = 100))
      
      plot4 <- ggplot(df, aes(x)) +
        geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "steelblue") + 
        geom_density(fill = "#b3a4a4", alpha = 0.5) + 
        theme(panel.background = element_rect(fill = '#ffffff'))   
      
      ggplotly(plot4)
    })
    
    
    # Chi Squared Distribution ####
    output$Chi_Square_Distribution <- renderPlotly({
      df <- data.frame(x = rchisq(df = input$chi_df,
                                  n = 100))
      
      plot5 <- ggplot(df, aes(x)) +
        geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "steelblue") + 
        geom_density(fill = "#b3a4a4", alpha = 0.5) + 
        theme(panel.background = element_rect(fill = '#ffffff'))   
      
      ggplotly(plot5)
    })
    
    # T Distribution ####
    output$T_Distribution <- renderPlotly({
      df <- data.frame(x = rt(df = input$t_df,
                              n = 100))
      plot6 <- ggplot(df, aes(x)) +
        geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "steelblue") + 
        geom_density(fill = "#b3a4a4", alpha = 0.5) + 
        theme(panel.background = element_rect(fill = '#ffffff'))   
      
      ggplotly(plot6)
    })
   
  # Regression Tab #### 
    output$Regression <- renderPlotly({
      df <- data.frame(x = rnorm(mean = 10,
                                 sd = input$reg_sd,
                                 n = reg_sample),
                       y = rnorm(mean = 10,
                                 sd = input$reg_sd,
                                 n = reg_sample))
      fit <- lm(y ~ x)  
      plot <- plot_ly(data = df,                     
                      x = ~x, y = ~y, 
                      type = "scatter", mode= "markers",
                      name = "X vs. Y",
                      marker = list(opacity = 0.7)) %>% 
        add_lines(x = ~x,
                  y = fitted(fit),
                  name = "Line of best Fit") %>% 
        layout(title = "Regression between X and Y",
               xaxis = list(title = "X"),
               yaxis = list(title = "Y"))
      
      plot
    })
      
      
    
    
}
 
 
# initiate application ####
 shinyApp(server = server,
          ui = ui)