library(shiny)
library(shinydashboard)
library(shinyWidgets)

shinyUI(fluidPage(

    # Application title
    titlePanel("SCM Forecast and Error"),

    sidebarLayout(
        sidebarPanel(
          pickerInput(
            inputId = "forecast",
            label = "Forecast Model", 
            choices = c("Buy/Make", "Moving Average", "Weighted Moving", "Exponential Smoothing")
          )
        ),

        mainPanel(
            tableOutput("display")
        )
    )
))
