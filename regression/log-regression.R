library(haven)      # for importing STATA datasets
library(stargazer)  # for printing regression models
library(stats)      # for creating a prediction from the model


#################################################################
##                          LOG MODEL                          ##
#################################################################


food <- read_dta("~/Dropbox/Documents/R/tutorials/datasets/food.dta")

food$lnfood_exp = log(food$food_exp)
food$income = log(food$income)

log_model = lm(lnfood_exp ~ income, data = food)

# base R way of summarizing a regression model
summary.lm(log_model)  # shows more measures, like standard error, p values and R squared

# I think stargazer is vastly superior in printing regression models
# stargazer(linear_model, type = "text", single.row = T, report = "vc*stp") # with no spaces between variables
stargazer(log_model, type = "text", single.row = F, report = "vc*stp") # with one space between variables, I think this is better

par(mfrow = c(2,2))

# plot the data to get an idea of what it looks like
# note the shape of how the points are distributed; how will this affect your model?
plot(food$income, food$lnfood_exp, 
     main = "Food Expenditure Data",
     pch = 20, 
     xlab = "House Income",
     ylab = "Log Weekly Food Expenditure ($)")

prediction = predict(log_model)

lines(sort(food$income),
      prediction[order(prediction)],
      col = "black",
      lwd = 1
)

# plot your residuals vs fitted
# errors should ideally be normally distributed
plot(log_model$residuals,
     main = "Residuals vs Fitted",
     xlab = "House Income", ylab = "Residuals",
     pch = 20, col = "red")
abline(h = 0, cex = 0.1)


hist(log_model$residuals, 
     main = "Histogram of Residuals",
     xlab = "Residuals", freq = F)

lines(density(log_model$residuals))

qqnorm(log_model$residuals, pch = 16, col = "red")
qqline(log_model$residuals)

