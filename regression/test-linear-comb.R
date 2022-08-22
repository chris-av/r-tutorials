library(PoEdata)      # for importing STATA datasets
library(stargazer)  # for printing regression models
library(multcomp)   # for testing regression models


#################################################################
##            TEST LINEAR COMBINATION OF PARAMETERS            ##
#################################################################

data("food")

# create a model
lm.food = lm(food_exp ~ income,
             data = food)

# print your model, note the beta values
stargazer(lm.food,
          single.row = F,
          type = "text",
          intercept.bottom = F,
          intercept.top = T,
          report = "vc*stp")

# we want to test what our model predicts for specific values

# predict.food = predict(lm.food)
intercept = coef(lm.food)[1]
beta = coef(lm.food)[2]

# this is one point prediction
# what does our model predict if we have 20 for income
intercept + 10*beta
intercept + 20*beta
intercept + 30*beta

# the predict function takes a dataframe in its second argument
# I think the data frame name of the desired values to be predicted HAS to match with the original data frame.
predict(lm.food, data.frame(income = c(10,20,30)))

# this will give the estimated standard error and t value.
summary(glht(lm.food, linfct = c("income = 20")))


# This layout explains each term of the linear combination function.
# I think this gets the t statistic using the model
# this code is from Hack-R on StackExchange who wrote this for me on Stack Exchange
# https://stackoverflow.com/questions/46018122/r-adding-constant-in-linear-combination-glht
hypo_tester <- function(expenditure, income_per_week_hundreds, mod){
  t = sum(
    (mod$coefficients[1] +                                     # constant
       income_per_week_hundreds*mod$coefficients[2] -          # b2*x
       expenditure) /                                          # c (right side)
      sqrt(
        vcov(mod)[1] +                                         # Var(intercept)
          income_per_week_hundreds^2 * vcov(mod)[4] +          # x^2 * var(b2)
          2 * income_per_week_hundreds *  vcov(mod)[2])        # 2 * x * cov(intercept, b2)
  )
  return(t)
}

hypo_tester(250, 10, lm.food)
hypo_tester(250, 20, lm.food)
hypo_tester(250, 30, lm.food)

