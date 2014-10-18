library(shiny)


shinyServer(
    function(input, output) {
        
        ### Display the formula in text. Only update this when the action button is clicked.
        output$formulaOutput <- renderText({ 
                input$action
                isolate(paste0("y=",input$formula))
            })
        
        ### fn = the formula. Only update this when the action button is clicked.
        fn <- reactive({
            input$action 
            expr = isolate(parse(text=input$formula))
            function(x) eval(expr)
        })
        
        ### ll = lower limit. Only update this when the action button is clicked.
        ll <- reactive({
            input$action
            isolate(input$lowerlimit)      
        })
        
        ### ul = upper limit.  Only update this when the action button is clicked.
        ul <- reactive({
            input$action
            isolate(input$upperlimit)      
        })
        
        ### n = number of rectangles
        n <- reactive({
            input$rectangles
        })
                
        ### fnx is a vector of x values representing the left side of the approximating rectangles
        fnx <- reactive({
            fnx = seq(from = ll(), to = ul(), length.out = n()+1)
            fnx[-length(fnx)]
        })
        
        ### fny is a vector of y values representing the value of the function at each point in fnx
        fny <- reactive({
            fn = fn()
            fn(fnx())
        })
        
        ### CurvePlot plots both the function, from the lower limit to the upper limit, and draws the approximating rectangles.
        output$curvePlot <- renderPlot({
            
            ### First, plot the function
            fn = fn()
            curve(fn, from = ll(), to = ul())

            ### Now, add approximating rectangles to the curve.
            rect(fnx(),0,fnx()+(ul()-ll())/n(),fny(),border=TRUE)
        })
        
        ### Rectsum gives the sum of the rectangles, where the heights are given by fny() and the widths by 
        output$rectsum <- renderText({
            sum(fny()*(ul()-ll())/n())
        })
        
        ### Integral gives the definite integral of the rectangles, as calculated by the integrate function in R.
        output$integral <- renderText({
            integrate(fn(),lower= ll(),upper=ul())$value
        })
    }
)