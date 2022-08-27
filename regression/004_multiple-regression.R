library(PoEdata)    # for importing br dataset
library(stargazer)  # for printing regression models


##################################################################
##               MULTIPLE / NON LINEAR REGRESSION               ##
##################################################################

data("br")

# Let us suppose that the econometric model we want to estimate is NOT linear.
# Lets create a new column where square feet is squared. 
br$sqft2 = br$sqft^2

nlm.br = lm(price ~ sqft2, data = br)    # this will be the non-linear model
lm.br = lm(price ~ sqft, data = br)      # this will be the linear model


# my favorite options for formatting my table
# use "style =" for some cool styles. the "aer" looks pretty cool.
stargazer(nlm.br, lm.br, type = "text", single.row = F,
          column.labels = c("Quadratic", "Linear"),
          notes.align = "r", intercept.top = T, intercept.bottom = F,
          report = "vc*stp"
          # style = "aer"
          # out = "~/Desktop/model2"
          )


#Notice that this histogram is very skewed to the right to the right (it has a long tail to the right)
#To ameliorate this, we can create a log variable of price. This will make the distribution look somewhat more normal. 
hist(br$price,
     xlab = "Price",
     col = "blue",
     density = 50,
     angle = 45,
     breaks = 70,
     main = "Histogram of Sales Price")


# take the log of prices
br$lnprice = log(br$price)


# now see the new distribution. Should look more normal
hist(br$lnprice,
     xlab = "Price",
     col = "red",
     density = 50,
     angle = 45,
     breaks = 70,
     main = "Histogram of Logarithmic Sales Price")

# plot the square feet to price. 
# notice how the data is shaped: kinda curves upward
plot(br$sqft, br$price,
     main = "Square Feet to Price",
     pch = 20, col = "light blue",
     xlab = "Total Square Feet",
     ylab = "Sales price $")


# predict using the model
predictedcounts <- predict(nlm.br)


# plot your x values and new predicted values, sorted
# to prevent crazy lines, you have to sort both the sqft and the prediction values to get a clean graph
lines(sort(br$sqft),
      predictedcounts[order(predictedcounts)],
      col = "black",
      lwd = 1
)


