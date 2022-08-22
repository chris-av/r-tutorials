library(stats)

#################################################################
##             VISUALIZING THE NORMAL DISTRIBUTION             ##
#################################################################

x <- seq(from = 0, to = 2, length = 200)
y_1 <- dnorm(x, 0, 1)
y_2 <- dnorm(x, 0, 2)
y_3 <- dnorm(x, 0, 3)
y_4 <- dnorm(x, 0, 4)
y_5 <- dnorm(x, 0, 5)
y_6 <- dnorm(x, 0, 6)
y_7 <- dnorm(x, 0, 7)
y_8 <- dnorm(x, 0, 8)
y_9 <- dnorm(x, 0, 9)


# Plot the densities
plot(x, y_1, col = 1, type = "l", 
     main = "Normal Distribution",
     xlab = "Values",
     ylab = "Probability",
     ylim = c(0, 0.5))
lines(x, y_2, col = 2)
lines(x, y_3, col = 3)
lines(x, y_4, col = 4)
lines(x, y_5, col = 5)
lines(x, y_6, col = 6)
lines(x, y_7, col = 7)
lines(x, y_8, col = 8)
lines(x, y_9, col = 9)


# Add the legend
legend("topright",
       c("n = (0,1)", "n = (0,2)", "n = (0,3)", "n = (0,4)", 
         "n = (0,5)", "n = (0,6)", "n = (0,7)", "n = (0,8)", "n = (0,9)"), 
       col = c(1, 2, 3, 4, 5, 6, 7, 8, 9), lty = 1,
       cex = 0.6)
