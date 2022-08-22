library(PoEdata)      # for importing STATA datasets
library(stargazer)  # for printing regression models
library(stats)      # for some statistical functions


##################################################################
##                 WORKING WITH T-DISTRIBUTIONS                 ##
##################################################################


# download presidential data
data("fair4")

# construct a model using only the presidents 1916 and after.
pres.lm = lm(vote ~ growth, data = subset(fair4, fair4$year >= 1916))
stargazer(pres.lm,
          type = "text",
          intercept.bottom = T,
          digits = 5,
          report = "vc*stp"
)


# this is the t-distribution for the fair4 sample
plot(
  seq(-3,3,0.185),
  dt(seq(-3,3,0.185), df = 33),
  type = "l",
  ylim = c(0,0.6),
  main = "T-Distribution for fair4 Data",
  xlab = "x", ylab = "y"
)

# this prints the t-critical value for the hypothesis test
qt(0.05,22) # because we have two beta's, we necessarily have N - 2 degrees of freedom
summary(pres.lm)$coefficients[2,3] # the t-statistic for the model

# the confidence interval is not quite the same as in stata for the growth variable. 
# this is because the stargazer package uses the normal distribution (z score) for calculating the confidence interval
# use the ci.custom argument to use the t statistics, just like in stata
stargazer(pres.lm,
          type = "text",
          intercept.bottom = T,
          digits = 5,
          report = "vc*stp",
          ci.custom = list(confint(pres.lm, level = 0.95)),
          ci.level = .90,
          t.auto = T)

# this is the correct confidence interval; as calculated in stata, and in R (by hand)
0.88595 - qt(0.025,22)*0.18187
0.88595 + qt(0.025,22)*0.18187
paste(c("Confidence interval is ",
        0.88595 + qt(0.025,22)*0.18187,
        " , ",
        0.88595 - qt(0.025,22)*0.18187),
      collapse = "")
confint(pres.lm, level = 0.95)


pres.lm2 = lm(vote ~ inflation, data = subset(fair4, fair4$year >= 1916))
stargazer(pres.lm2,
          type = "text",
          intercept.bottom = F,
          digits = 5,
          report = "vc*stp",
          ci.custom = list(confint(pres.lm2, level = 0.95)),
          ci.level = .95,
          t.auto = T)
qt(0.05,22)
paste(c("Confidence interval is ",
        -0.44431 + qt(0.025,22)*0.59993,
        " , ",
        -0.44431 - qt(0.025,22)*0.59993),
      collapse = "")
confint(pres.lm2, level = 0.95)



