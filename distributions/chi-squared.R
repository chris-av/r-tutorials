library(stats)

##################################################################
##           VISUALIZING THE CHI SQUARED DISTRIBUTION           ##
##################################################################

x <- seq(from = 0, to = 10, length = 200)
y_1 <- dchisq(x, 1)
y_2 <- dchisq(x, 2)
y_3 <- dchisq(x, 3)
y_4 <- dchisq(x, 4)
y_5 <- dchisq(x, 5)
y_6 <- dchisq(x, 6)
y_7 <- dchisq(x, 7)
y_8 <- dchisq(x, 8)
y_9 <- dchisq(x, 9)


# Plot the densities
plot(x, y_1, col = 1, type = "l",
     main = "Chi Squared Distribution",
     xlab = "Values",
     ylab = "Probability",
     ylim = c(0, 0.5))
lines(x, y_2, col = 2)
lines(x, y_3, col = 3)
lines(x, y_4, col = 4)
lines(x, y_5, col = 5)
lines(x, y_6, col = 6)
lines(x, y_7, col = 5)
lines(x, y_8, col = 5)
lines(x, y_9, col = 6)


# Add the legend
legend("topright", 
       c("k = 1", "k = 2", "k = 3", "k = 4", 
         "k = 5", "k = 6", "k = 7", "k = 9"), 
       col = c(1, 2, 3, 4, 5, 6, 7, 8, 9), lty = 1,
       cex = 0.6)


