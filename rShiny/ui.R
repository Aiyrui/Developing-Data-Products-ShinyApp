#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
state <- data.frame(state.x77)
# Define UI for application that draws linear regressions and display regression coefficients
shinyUI(fluidPage(

    # Application title
    titlePanel("US Income in 1974"),

    # Sidebar with a a drop-down menu for user to chose from
    sidebarLayout(
        sidebarPanel(
            selectInput("variable", "Predictor Variable:",
                        choices = colnames(state))
        ),

        # Show the regression plot and coefficients generated 
        mainPanel(
            h2(textOutput("plotTitle")),
            plotOutput("plot"),
            h3("Regression Coefficients"),
            tableOutput("coeff")
            
        )
    )
))
