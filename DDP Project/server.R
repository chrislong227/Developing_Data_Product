library(shiny)
library(UsingR)
data("homeprice")

lmModel = lm(sale ~ full + half + bedrooms + rooms + neighborhood, data = homeprice)

sale = function(full, half, bedrooms, rooms, neighborhood) {
  lmModel$coefficients[1] + lmModel$coefficients[2] * full + 
    lmModel$coefficients[3] * half + lmModel$coefficients[4] * bedrooms + lmModel$coefficients[5] * rooms + lmModel$coefficients[6] * neighborhood
}

shinyServer(
  function(input, output) {
    predicted_sale = reactive({sale(as.numeric(input$full), as.numeric(input$half), as.numeric(input$bedrooms), 
                                    as.numeric(input$rooms), as.numeric(input$neighborhood))})
    output$inputValues = renderPrint({paste(input$full, "full bathrooms, ",
                                            input$half, "half bathrooms, ",
                                            input$bedrooms, "bedrooms, ",
                                            input$rooms, "total rooms, ",
                                            input$neighborhood, "points")})
    output$prediction = renderPrint({paste(round(predicted_sale(), 2), "Thousand USD")})
    output$plots = renderPlot({
      par(mfrow = c(2, 2))
      # (1, 1)
      with(homeprice, plot(full, sale,
                           xlab='number of full bathrooms',
                           ylab='sale',
                           main='sale vs full bathrooms'))
      points(as.numeric(input$full), predicted_sale(), col = 'red', cex=3)                 
      # (1, 2)
      with(homeprice, plot(bedrooms, sale,
                           xlab='number of bedrooms',
                           ylab='sale',
                           main='sale vs bedrooms'))
      points(as.numeric(input$bedrooms), predicted_sale(), col = 'red', cex=3)  
      # (2, 1)
      with(homeprice, plot(rooms, sale,
                           xlab='number of total rooms',
                           ylab='sale',
                           main='sale vs total rooms'))
      points(as.numeric(input$rooms), predicted_sale(), col = 'red', cex=3)  
      # (2, 2)
      with(homeprice, plot(neighborhood, sale,
                           xlab='neighborhood rating',
                           ylab='sale',
                           main='sale vs neighborhood quality'))
      points(as.numeric(input$neighborhood), predicted_sale(), col = 'red', cex=3)  
    })
  }
)