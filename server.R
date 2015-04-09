library(shiny)
library(ggplot2)
library(swirl)
library(caret)

dataset <- read.csv("Input.csv")

shinyServer(function(input,output) {
  
  filtdata <- reactive({
    if(input$neighborhood=="All"&input$category=="All"){
    subdata <- dataset
    subdata
    } else if(input$neighborhood!="All"&input$category=="All"){
    subdata <- subset(dataset,Neighborhood==input$neighborhood)
    subdata
    } else if(input$neighborhood=="All"&input$category!="All"){
    subdata <- subset(dataset,Category==input$category)
    subdata  
    } else {
    subdata <- subset(dataset,Neighborhood==input$neighborhood & Category==input$category)
    subdata  
    }
  })
  output$meanDollars <- renderText(mean(filtdata()[["Dollars"]]))
  output$meanReviews <- renderText(mean(filtdata()[["Reviews"]]))
  output$meanRating <- renderText(mean(filtdata()[["Rating"]]))
  output$plot <- renderPlot(qplot(filtdata()[[input$x]],filtdata()[[input$y]],color=filtdata()[[input$color]],xlab=input$x,ylab=input$y,position=position_jitter(w=0.05,h=0.05)))
  output$plot2 <- renderPlot(hist(filtdata()[[input$x]],xlab=input$x,col="blue"))
})
