library(PoEdata)
library(stargazer)  # for printing regression models


##################################################################
##              INTERPRETING CATEGORICAL VARIABLES              ##
##################################################################

data("utown")

# histogram of data only where only where utown == 0
hist(utown$price[utown$utown==0],
     col = "blue",
     density = 40,
     breaks = 20,
     xlab = "House Prices ($1000) in Golden Oaks",
     ylab = "Percent",
     main = "Histogram of Golden Oaks House Prices")

# histogram of data only where only where utown == 1
hist(utown$price[utown$utown==1],
     col = "red",
     density = 40,
     breaks = 20,
     xlab = "House Prices ($1000) in University Town",
     ylab = "Percent",
     main = "Histogram of University Town House Prices")

# regressing price on a categorical variable gives the following model
lm.utown.1 = lm(price ~ utown, data = utown)

# houses in utown, on average, cost $61,509 more than those not from utown
stargazer(lm.utown.1, type = "text", single.row = F,
          intercept.top = T,
          intercept.bottom = F,
          report = "vc*stp")

