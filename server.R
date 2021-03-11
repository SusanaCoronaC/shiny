#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  ToothGrowth$dosesp <- ifelse(ToothGrowth$dose - 1.5 > 0, ToothGrowth$dose - 1.5, 0)
  
  model1 <- lm(len ~ dose, data = ToothGrowth)
  model2 <- lm(len ~ dosesp + dose, data = ToothGrowth)
  model1pred <- reactive({
    doseInput <- input$sliderDose
    predict(model1, newdata = data.frame(dose = doseInput))
  })
  model2pred <- reactive({
    doseInput <- input$sliderDose
    predict(model2, newdata =
              data.frame(dose = doseInput,
                         dosesp = ifelse(doseInput - 1.5 > 0,
                                         doseInput - 1.5, 0)))
  })
  output$plot1 <- renderPlot({
    doseInput <- input$sliderDose
    
    plot(ToothGrowth$dose, ToothGrowth$len, xlab = "Dose",
         ylab = "Length", bty = "n", pch = 25, type="p", col="blue", cex=2)
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        dose = 0:2, dosesp= ifelse(0:2 - 1.5 > 0, 0:2 - 1.5, 0)
      ))
      lines(0:2, model2lines, col = "gray", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch= 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(doseInput, model1pred(), col = "magenta", pch = 16, cex =2)
    points(doseInput, model2pred(), col = "orange", pch = 16, cex=2)
  })
  output$pred1 <- renderText({
    model1pred()
  })
  output$pred2 <- renderText({
    model2pred()
  })
  output$print_dose <- renderPrint({
    paste("unique values dose",   unique(ToothGrowth$dose))
  })
  output$print_supp <- renderPrint({
    paste("unique values supplement" , unique(ToothGrowth$supp))
  })
  output$Dataset <- renderText(
    print("The Effect of Vitamin C on Tooth Growth in Guinea Pigs
                  Description
                  The response is the length of odontoblasts (cells responsible for tooth growth) in 60 guinea pigs. Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods, orange juice or ascorbic acid (a form of vitamin C and coded as VC).")
  )
})
