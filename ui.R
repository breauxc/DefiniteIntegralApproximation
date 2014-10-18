library(shiny)

shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Approximating Definite Integrals"),
        sidebarPanel(
            h3("Formula:"),
            textInput("formula", "Input a formula for y in terms of x.", "x^2/exp(x)"),
            numericInput('lowerlimit', 'Lower Limit', 0, min = 0, max = 10, step = 1),
            numericInput('upperlimit', 'Upper Limit', 10, min = 0, max = 10, step = 1),
            actionButton('action','Submit'),
            h3("Approximation Controls:"),
            sliderInput("rectangles", "Number of approximating rectangles:", 
                        min = 1, max = 100, value = 10),
            h3("Documentation:"),
            p(a("Approximating Definite Integrals",href="DIhelp.html"))
        ),
        mainPanel(
            h4('The formula you entered is'),
            verbatimTextOutput("formulaOutput"),
            plotOutput("curvePlot"),
            h4('The sum of the area of the rectangles is'),
            verbatimTextOutput("rectsum"),
            h4('and the value of the definite integral is'),
            verbatimTextOutput("integral")
        )
    )
)
