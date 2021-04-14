#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


setwd("~/Documents/GitHub/vaccine-distribution")
library(caret)
library(shiny)
library(ggplot2)

##### SERVER #####

# Define server logic for random distribution application
shinyServer(function(input, output) {
    inputdata <- reactive({
        df <- data.frame(
            sex = as.factor(input$sex),
            age_group = as.factor(input$age_group),
            race_ethnicity_combined = as.factor(input$race_ethnicity_combined),
            res_state = as.factor(input$res_state),
            hc_work_yn = as.factor(input$hc_work_yn),
            medcond_yn = as.factor(input$medcond_yn)
        )
        colnames(df) <- c("sex","age_group","race_ethnicity_combined","res_state","hc_work_yn","medcond_yn")    
        return(df)
    })
    
    output$result <- renderTable({inputdata()})
    
    #death_yn Model
    death_yn_model <- readRDS("death_yn_model.rds")
    output$death_yn <- renderPrint({
        preds <- predict(death_yn_model, newdata = inputdata(), type = "response", se.fit = TRUE)
        critval <- 1.96 ## approx 95% CI
        upr <- round((preds$fit + (critval * preds$se.fit)) *100 , digits = 2)
        lwr <- round((preds$fit - (critval * preds$se.fit)) *100 , digits = 2)
        fit <- round(preds$fit*100, digits = 2)
        paste("Risk of Mortality is ", as.numeric(fit), "%. Confidence Interval [" , lwr, "%, ", upr, "%]", sep ="")
    })
})
