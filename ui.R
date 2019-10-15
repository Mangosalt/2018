

library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyverse)
packageVersion('plotly')
dataput <- read.csv("AB_NYC_2019.csv")

# Define style of application and title
ui <- navbarPage("New York City Airbnb",
                 # Create description panel, incl. text output and file input functionality
                 tabPanel("Description", h4('Analysing New York City Airbnb'), textOutput("text"), hr()),
                 
              
                 # Create dropdown menu with two tabs
                 navbarMenu("Plots",
                            # Create tab for plot 1
                            tabPanel("Neighbourhood Proportion", plotlyOutput("distPlot1")),
                            
                            # Create tab for plot 2, including filters
                            tabPanel("Neighbourhood vs. Price (interactive)",plotOutput("distPlot2"), hr(),fluidRow(
                              column(4, offset = 1,
                                     selectInput("neighbourhood", label = "Neighbourhood Group",
                                                 choices = c("Brooklyn" = "Brooklyn", "Manhattan" = "Manhattan", "Queens" = "Queens", "Bronx"=
                                                               "Bronx", "Staten Island" = "Staten Island", selected = 1))
                              ),
                              column(4,
                                     sliderInput("price", "Price", min = 1, max = 1000, value = c(20,500))
                              ),
                              column(4,
                                     sliderInput("numofreview", "Number of Reviews", min = 1, max = 650, value = c(10,300))
                            ),
                            column(4,                                                                   
                                   
                                   sliderInput("availibility", "Availability - (DataTable)", min = 0, max = 365, value = c(10,300))
                                   
                            )
                            )),
                            #Create plot3
                            tabPanel("Room Type vs. Price", plotOutput("distPlot3"), hr(), fluidRow(
                              column(4, offset = 1,
                                     selectInput("neighbourhood3", label = "Neighbourhood Group",
                                                 choices = c("Brooklyn" = "Brooklyn", "Manhattan" = "Manhattan", "Queens" = "Queens", "Bronx"=
                                                               "Bronx", "Staten Island" = "Staten Island", selected = 1))
                                     ),
                              column(4,
                                     sliderInput("price4", "Price", min = 1, max = 1000, value = c(20,500))
                                     ),
                              column(4,
                                     checkboxGroupInput("checkboxGroup",
                                                        "Checkbox Group",
                                                        list("Private Room" = "Private room", "Shared Room" = "Shared room","Entire Home/Apt" = 
                                                               "Entire home/apt", selected = 1))
                              )
                            )),
                            
                            tabPanel("Price vs. Availability",plotOutput("distPlot4"), hr(), fluidRow(
                              column(4,
                                     sliderInput("availibility2", "Availability", min = 0, max = 365, value = c(10,300)),
                                     sliderInput("price2", "Price", min = 1, max = 1000, value = c(20,500))
                                     )
                            ))),
                 # Create tab for data table
                 tabPanel('Data Table',
                          fluidRow(
                            column(4, offset = 1,
                                   selectInput("neighbourhood4", label = "Neighbourhood Group",
                                               choices = c("Brooklyn" = "Brooklyn", "Manhattan" = "Manhattan", "Queens" = "Queens", "Bronx"=
                                                             "Bronx", "Staten Island" = "Staten Island", selected = 1))
                            ),
                            column(3,
                                   sliderInput("availibility3", "Availability", min = 0, max = 365, value = c(10,300)),
                                   sliderInput("price3", "Price", min = 1, max = 1000, value = c(20,500))
                            )),
                            
                          
                          hr(),
                          DT::dataTableOutput("table"))
)