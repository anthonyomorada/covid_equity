#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

fluidPage(
    
    titlePanel("COVID Mortality"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("sex", "sex?", choices = c("Female","Male","Other","Unknown")),
            selectInput("age_group", "age_group?", choices = c("0 - 9 Years","10 - 19 Years","20 - 29 Years","30 - 39 Years","40 - 49 Years","50 - 59 Years","60 - 69 Years","70 - 79 Years","80+ Years", "Unknown")),
            selectInput("race_ethnicity_combined", "race_ethnicity_combined?", choices = c("American Indian/Alaska Native, Non-Hispanic", "Asian, Non-Hispanic","Black, Non-Hispanic","Hispanic/Latino", "Multiple/Other, Non-Hispanic ", "Native Hawaiian/Other Pacific Islander, Non-Hispanic", "Unknown", "White, Non-Hispanic")),
            selectInput("res_state", "res_state?", choices = c("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MP","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OCONUS","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV", "WY")),
            selectInput("hc_work_yn", "hc_work_yn?", choices = c("No","Unknown","Yes")),
            selectInput("medcond_yn", "medcond_yn?", choices = c("No","Unknown","Yes")),
            hr(),
            
            p('Test:',
              a("Test", 
                href = "Null")),
            hr()
        ),
        
        mainPanel(
            h1('Input Table'),
            tableOutput("result"),
            hr(),
            h1('Risk of Mortality'),
            textOutput("death_yn"),
        )
    )
)  