library(shiny)
library(ggplot2)

dataset <- read.csv("Input.csv")
Neighvec <- c("All")
Neighvec <- append(Neighvec,as.character(unique(dataset$Neighborhood)))
Catvec <- c("All")
Catvec <- append(Catvec,as.character(unique(dataset$Category)))

shinyUI(pageWithSidebar(
  
  headerPanel("Dallas Yelp"),
  
  sidebarPanel(
        
    selectInput('neighborhood', 'Neighborhood', Neighvec),
    selectInput('category', 'Category', Catvec),
    selectInput('x', 'X', c("Rating","Reviews","Dollars")),
    selectInput('y', 'Y', c("Rating","Reviews","Dollars")),
    selectInput('color', 'Color', c('None', names(dataset))),
    h4('Average $:'),
    verbatimTextOutput("meanDollars"),
    h4('Average Number of Reviews:'),
    verbatimTextOutput("meanReviews"),
    h4('Average Rating:'),
    verbatimTextOutput("meanRating")
  ),
  
  mainPanel(
    plotOutput('plot'),
    plotOutput('plot2')
  )
)
)