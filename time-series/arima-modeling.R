library(stats)      # for creating time series objects


# from edureka: https://www.youtube.com/watch?v=tREwXpk-agU&list=PLl4GRYVT5GQELEiCGwvDnyOlL0kdOoWRd

##################################################################
##                        ARIMA MODELING                        ##
##################################################################

# define time series object using AirPassengers
airpass_ts = ts(AirPassengers, frequency = 12, start = c(1949,1))


# this shows the breakdown of the time series; random, seasonal, tend and observed components of the data
decomposition = decompose(airpass_ts)
plot(decomposition) 




# ARIMA: Autoregressive Integrated Moving Average
# AR + I + MA (reference for the order() function)
# in order to use the ARIMA model, the time series must be stationary!
arima.model = arima(x = airpass_ts, 
                    order = c(1,0,0),
                    seasonal =  list(order = c(2,1,0),
                                     period = 12
                    )
)

future = predict(arima.model, n.ahead = 24)


# 95% confidence interval
upper.bound = future$pred + 2*future$se
lower.bound = future$pred - 2*future$se


# plot both the original time series plus our future prediction
ts.plot(airpass_ts, future$pred, upper.bound, lower.bound,
        col = c(1,2,4,4), 
        lty = c(1,1,2,2))
legend("topleft", col = c(1,2,4), lty = c(1,1,2),
       c("Actual", "Forecast", "Error Bounds (95% Forecast)"),
       cex = 0.8)

# an alternate method for plotting future predictions
plot(forecast(arima.model, h = 12))


# the auto.arima() function automatically finds the arima model that best fits the data
arima.best.fit = auto.arima(airpass_ts, approximation = F, trace = F)

