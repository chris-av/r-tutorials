library(stats)      # for working with ts functions    


#################################################################
##              TIME SERIES: PREDICTION INTERVALS              ##
#################################################################


f = decompose(AirPassengers)
plot(f)


fit <- arima(AirPassengers, order=c(1,0,0), list(order=c(2,1,0), period=12))
fore <- predict(fit, n.ahead=24)
# error bounds at 95% confidence level
U <- fore$pred + 2*fore$se
L <- fore$pred - 2*fore$se

# plot your data with the predictions
ts.plot(AirPassengers, 
        fore$pred, 
        U, L, 
        col=c(1,2,4,4), 
        lty = c(1,1,2,2), 
        main = "AirPassengers Forecasting")

legend("topleft", c("Actual", "Forecast", "Error Bounds (95% Confidence)"), 
       col=c(1,2,4), lty=c(1,1,2),
       cex = 0.5
)
