# Week 4 assignment
# 1.	Some form of input (widget: textbox, radio button, checkbox, ...)
# 2.	Some operation on the ui input in sever.R
# 3.	Some reactive output displayed as a result of server calculations
# 4.	You must also include enough documentation so that a novice user could use your application.
# 5.	The documentation should be at the Shiny website itself. Do not post to an external link.

#

library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict length for toothgrowth  from doses given"),
  sidebarLayout(
    sidebarPanel(
      helpText("- You can predict tooth growth using dose as predictor"),
      helpText("- You can specify the given dose (0.5, 1, and 2 mg/day) using a slider"),
      helpText("- You can show or hide model 1 and model 2 using checkboxs"),
      sliderInput("sliderDose", "What is the dose given for toothgrowth?", 0, 2, value=1, step=.5), 
      helpText("Dose levels examples: 0.5, 1, and 2 mg/day"),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
          tabPanel("prediction", br(), 
            plotOutput("plot1"),
            h3("Predicted length for toothgrowth from Model 1:"),
            textOutput("pred1"),
            h3("Predicted length for toothgrowth from Model 2:"),
            textOutput("pred2"),
            textOutput("print_dose"),
            textOutput("print_supp")),
          tabPanel("Dataset", br(), textOutput("Dataset"))
      )
    )
  )
))