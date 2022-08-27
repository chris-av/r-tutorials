library(stats)

##################################################################
##            VISUALIZING THE STUDENT T DISTRIBUTION            ##
##################################################################


x <- seq(from = 0, to = 2, length = 200)
y_1 <- dt(x, 1)
y_2 <- dt(x, 2)
y_3 <- dt(x, 3)
y_4 <- dt(x, 4)
y_5 <- dt(x, 5)
y_6 <- dt(x, 6)
y_7 <- dt(x, 7)
y_8 <- dt(x, 8)
y_9 <- dt(x, 9)


# Plot the densities
plot(x, y_1, col = 1, type = "l", 
     main = "Student T Distribution",
     xlab = "Values",
     ylab = "Probability")
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
       c("1 df", "2 df", "3 df", "4 df", 
         "5 df", "6 df", "7 df", "8 df", "9 df"), 
       col = c(1, 2, 3, 4, 5, 6, 7, 8, 9), lty = 1,
       cex = 0.6)
