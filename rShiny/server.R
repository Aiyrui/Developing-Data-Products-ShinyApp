#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

state <- data.frame(state.x77)

# Define UI for application that draws linear regressions and display regression coefficients
shinyServer(function(input, output) {
    
    fitFormula <- reactive({
        xInput <- input$variable
        paste("state$Income ~", "as.integer(state$",xInput,")")
    })
    
    fit <- reactive({
        lm(as.formula(fitFormula()), data = state)
    })
    
    caption <- reactive({
        paste(input$variable, "as Predictor")
    })
    
    output$plotTitle <- renderText({
        caption()
    })
    
    lmCoeff <- reactive({
        as.data.frame(summary(fit())$coefficients, row.names = c("Intercept", input$variable))
    })
    
    output$coeff <- renderTable({
        lmCoeff()
    }, rownames = TRUE)
    
    output$plot <- renderPlot({
        
        plot(as.formula(fitFormula()), xlab = input$variable, ylab = "Income")
        abline(fit(), col = "red")
    })

})
