library(shiny)

shinyServer(function(input, output) {
  output$display <- renderText(
    if (data == "Buy/Make") {
      UNITS <- 15000
      FC <- 25000
      VC <- 5
      MAKE_COST_REG <- FC + (VC * UNITS)

      PRICE <- 7
      BUY_COST_REG <- PRICE * UNITS

      if (MAKE_COST_REG > BUY_COST_REG) {
        print("Buy")
      } else if (MAKE_COST_REG < BUY_COST_REG) {
        print("Make")
      } else {
        print("Either Works")
      }
    } else if (input$forecast == "Moving Average") {
      TIME_PERIOD <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)
      ACTUAL <- c(1600, 2200, 2000, 1600, 2500, 3500, 3300, 3200, 3900, 4700, 4300, 4400, NA)
      FORECAST <- c()
      for (i in 5:13) {
        FORECAST[i] <- mean(ACTUAL[(i - 4):(i - 1)])
      }
      FORECASTdf <- data.frame(TIME_PERIOD, ACTUAL, FORECAST)

      AbsoluteDeviation <- c()
      for (i in 1:13) {
        AbsoluteDeviation[i] <- abs(ACTUAL[i] - FORECAST[i])
      }

      Square <- c()
      for (i in 1:13) {
        Square[i] <- (ACTUAL[i] - FORECAST[i])^2
      }

      Percent <- c()
      for (i in 1:13) {
        Percent[i] <- ((ACTUAL[i] - FORECAST[i]) / ACTUAL[i]) * 100
      }

      Error <- data.frame(AbsoluteDeviation, Square, Percent)
      FORECASTdf[, 4:6] <- Error

      output$display <- renderTable({
        FORECASTdf
      })
    } else if (input$forecast == "Weighted Moving") {
      TIME_PERIOD <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)
      ACTUAL <- c(1600, 2200, 2000, 1600, 2500, 3500, 3300, 3200, 3900, 4700, 4300, 4400, NA)
      WEIGHTS <- c(.1, .2, .3, .4)
      FORECAST <- c()
      for (i in 5:13) {
        FORECAST[i] <- sum(ACTUAL[(i - 4):(i - 1)] * WEIGHTS)
      }
      FORECASTdf <- data.frame(TIME_PERIOD, ACTUAL, FORECAST)

      AbsoluteDeviation <- c()
      for (i in 1:13) {
        AbsoluteDeviation[i] <- abs(ACTUAL[i] - FORECAST[i])
      }

      Square <- c()
      for (i in 1:13) {
        Square[i] <- (ACTUAL[i] - FORECAST[i])^2
      }

      Percent <- c()
      for (i in 1:13) {
        Percent[i] <- ((ACTUAL[i] - FORECAST[i]) / ACTUAL[i]) * 100
      }

      Error <- data.frame(AbsoluteDeviation, Square, Percent)
      FORECASTdf[, 4:6] <- Error

      output$display <- renderTable({
        FORECASTdf
      })
    } else if (input$forecast == "Exponential Smoothing") {
      TIME_PERIOD <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)
      ACTUAL <- c(1600, 2200, 2000, 1600, 2500, 3500, 3300, 3200, 3900, 4700, 4300, 4400, NA)
      ALPHA <- .3
      FORECAST <- c(NA, ACTUAL[1])
      for (i in 3:13) {
        FORECAST[i] <- FORECAST[i - 1] + (ALPHA * (ACTUAL[i - 1] - FORECAST[i - 1]))
      }
      FORECASTdf <- data.frame(TIME_PERIOD, ACTUAL, FORECAST)

      AbsoluteDeviation <- c()
      for (i in 1:13) {
        AbsoluteDeviation[i] <- abs(ACTUAL[i] - FORECAST[i])
      }

      Square <- c()
      for (i in 1:13) {
        Square[i] <- (ACTUAL[i] - FORECAST[i])^2
      }

      Percent <- c()
      for (i in 1:13) {
        Percent[i] <- ((ACTUAL[i] - FORECAST[i]) / ACTUAL[i]) * 100
      }

      Error <- data.frame(AbsoluteDeviation, Square, Percent)
      FORECASTdf[, 4:6] <- Error

      output$display <- renderTable({
        FORECASTdf
      })
    }
  )
})
