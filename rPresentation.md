Developing Data Products Course Project
========================================================
author: tmxiang
date: 5/19/21
width: 1440
height: 1100

Overview
========================================================

This project showcases a Shiny application with linear regression models of the US income in 1974, which will vary depending on the predictor variable used. The application uses the `state.77` from the *US State Facts and Figures* dataset in the R datasets package.

* The user will chose a variable from a dropdown box to use as predictor for the US income.

* The application will display the linear regression model and regression coefficients after user input

For more information on the Shiny application, please see:

1. Shiny App: https://aiyrui.shinyapps.io/rShinyApp/

2. UI/Server code: https://github.com/Aiyrui/Developing-Data-Products-ShinyApp

UI Code
========================================================


```r
library(shiny)
state <- data.frame(state.x77)
shinyUI(fluidPage(
    titlePanel("US Income in 1974"),
    sidebarLayout(
        sidebarPanel(
            selectInput("variable", "Predictor Variable:",
                        choices = colnames(state))
        ),
        mainPanel(
            h2(textOutput("plotTitle")),
            plotOutput("plot"),
            h3("Regression Coefficients"),
            tableOutput("coeff")
        )
    )
))
```

<!--html_preserve--><div class="container-fluid">
<h2>US Income in 1974</h2>
<div class="row">
<div class="col-sm-4">
<form class="well" role="complementary">
<div class="form-group shiny-input-container">
<label class="control-label" id="variable-label" for="variable">Predictor Variable:</label>
<div>
<select id="variable"><option value="Population" selected>Population</option>
<option value="Income">Income</option>
<option value="Illiteracy">Illiteracy</option>
<option value="Life.Exp">Life.Exp</option>
<option value="Murder">Murder</option>
<option value="HS.Grad">HS.Grad</option>
<option value="Frost">Frost</option>
<option value="Area">Area</option></select>
<script type="application/json" data-for="variable" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
</div>
</div>
</form>
</div>
<div class="col-sm-8" role="main">
<h2>
<div id="plotTitle" class="shiny-text-output"></div>
</h2>
<div id="plot" class="shiny-plot-output" style="width:100%;height:400px;"></div>
<h3>Regression Coefficients</h3>
<div id="coeff" class="shiny-html-output"></div>
</div>
</div>
</div><!--/html_preserve-->

Server Code
========================================================


```r
library(shiny)
state <- data.frame(state.x77)
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
```

Application Output
========================================================

A sample output of the application is:

![plot of chunk unnamed-chunk-3](rPresentation-figure/unnamed-chunk-3-1.png)

```
                Estimate   Std. Error   t value     Pr(>|t|)
(Intercept) 4.314100e+03 119.08993360 36.225566 1.618686e-36
Population  2.865938e-02   0.01943044  1.474974 1.467492e-01
```
