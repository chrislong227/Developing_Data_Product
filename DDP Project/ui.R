library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Home Price Predictor for NJ in 2001'),
  sidebarPanel(
    h3('Instructions'),
    p('Please enter the basic information of the house you are willing to sell, including numbers of bathrooms, bedrooms and total rooms as well as your assessment of your neighborhood.
      On the right hand side, a predicted home price will be shown to serve you as a reference.'),
    h3('Please enter the basic information below.'),
    radioButtons('full', 'Number of full bathrooms:', c('1' = 1, '2' = 2, '3' = 3), selected = '1'), 
    radioButtons('half', 'Number of half bathrooms:', c('0' = 0, '1' = 1, '2' = 2), selected = '0'), 
    numericInput('bedrooms', 'Number of bedrooms:', 3, min = 1, max = 4, step = 1),
    numericInput('rooms', 'Number of total rooms:', 7, min = 3, max = 11, step = 1),
    numericInput('neighborhood', 'Your subjective assessment of neighborhood on scale of 1-5:', 3, min = 1, max = 5, step = 1)
    ),
  mainPanel(
    h3('Predicted Sale Price'),
    h4('Your Predictors:'),
    verbatimTextOutput("inputValues"),
    h4('Your Price is Estimated as:'),
    verbatimTextOutput("prediction"),
    h4('Your home price compared to others'),
    plotOutput('plots'),
    h3('Method'),
    p('I used the homeprice dataset in R, which is a random sampling of the homes sold in NJ during the year 2001. Source: Burgdorff Realty.
      I fit a model estimating the sale price based on how many rooms, including bathrooms and bedrooms, in each homes and on the assessment of the neighborhood.
      This could be a very useful information if you want to know about at what price you can sell your home in 2001 in NJ.'),
    h3('Author'),
    p('Chris Long on 3/28/2016')
    )
  ))