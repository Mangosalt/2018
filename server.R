#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#xxx

library(shiny)
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
packageVersion('plotly')

dataput <- read.csv("AB_NYC_2019.csv")
shinyServer(function(input, output) {
  # Create text output for Description tab
  output$text <- renderText({
    
    "This application analyses the New York City Airbnb from kaggle (https://www.kaggle.com/dgomonov/new-york-city-airbnb-open-data). 
    The database includes book information in Airbnb NYC. This application focuses on the price, room type, and location. This application allows the user to perform geo-spatial analysis on Airbnb in the NYC."
    
  })
  
  
  # Create plot 
 
  output$distPlot1 <- renderPlotly({
    
    p <- dataput %>%
      group_by(neighbourhood_group) %>%
      summarize(count = n())
    plot_ly(p, labels = ~neighbourhood_group, values = ~count) %>%
      add_pie(hole = 0.6) %>%
      layout(showlegend = T,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
  })
  output$distPlot2 <- renderPlot({
    
    airbnb = tbl_df(dataput)
    plot_df2 <- airbnb %>% filter(neighbourhood_group == input$neighbourhood, price >= input$price[1], price <= input$price[2],
                                  number_of_reviews >= input$numofreview[1],number_of_reviews <= input$numofreview[2])
    ggplot(plot_df2) +geom_point(aes(x=price, y=number_of_reviews, 
                                     color = neighbourhood_group))+theme_classic()+theme_minimal()
    
  })
  
  output$distPlot3 <- renderPlot({
    airbnb = tbl_df(dataput)
    plot_df3 <- airbnb %>% filter(price >= input$price4[1], price <= input$price4[2],room_type == input$checkboxGroup,
                                  neighbourhood_group == input$neighbourhood3) 
    qplot(price,data=plot_df3,facets=room_type~.,binwidth = 6, fill = neighbourhood_group) +theme_minimal()
    
  })
  
  output$distPlot4 <- renderPlot({
    plot_df4 <- dataput %>% filter(price >= input$price2[1], price <= input$price2[2],availability_365 == input$availibility2)
    ggplot(data = plot_df4, aes(x = price, color = availability_365)) +
      geom_histogram(fill="lightblue") +labs(x="Price") +theme_minimal()+theme_classic()
  })
  
  
  
  # Create data table output
  output$table<-DT::renderDataTable(
    DT::datatable(scored_df <- dataput %>% filter(price >= input$price3[1],price <= input$price3[2],availability_365 == input$availibility3, 
                                                  neighbourhood_group == input$neighbourhood4))
  )
  
})
  
  
 
    
    
    


