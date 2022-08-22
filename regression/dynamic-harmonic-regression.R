library(fpp2)
library(stats)


#################################################################
##                 DYNAMIC HARMONIC REGRESSION                 ##
#################################################################



cafe04 <- window(auscafe, start=2004)
plots <- list()
par(mfrow = c(3,2))
for (i in seq(6)) {
  fit <- auto.arima(cafe04, xreg = fourier(cafe04, K = i),
                    seasonal = FALSE, lambda = 0)
  plot(forecast(fit,
                xreg=fourier(cafe04, K=i, h=24)))
  legend("topleft", c("95 CI", "80 CI"), cex = 0.7, fill = c(blues9[5], blues9[2]))
}

