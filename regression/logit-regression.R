library(stargazer)
library(stats)
library(aod)
library(ggplot2)

##################################################################
##                       LOGIT REGRESSION                       ##
##################################################################



# here is the link to this tutorial: https://stats.idre.ucla.edu/r/dae/logit-regression/

# practicing logit regressions. First we read the data from the website
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

# we get summary data.
summary(mydata)
means = as.data.frame(sapply(mydata, mean))
sds = as.data.frame(sapply(mydata, sd))

names(means) = c("means")
names(sds) = c("standdev")

summary_stats = cbind(means, sds)
rm(means, sds)

# run a check of rank versus admit; this is just a matrix
xtabs(~admit + rank, 
      data = mydata)


# turn rank into a factor (categorical variable) for analysis
mydata$rank <- factor(mydata$rank)

# this is the logit model
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")

# for logit analysis, the summary function might look slightly better!
stargazer(mylogit, type = "text",
          report = "vc*stp", align = T, single.row = T, iqr = T)

# these are the confidence intervals based on the profiled log-likelihood     
confint(mylogit)

# these are the confidence intervals based on the regular standard errors
confint.default(mylogit)


# terms 4:6 refer strictly to the rank categorical variable
# I think the Wald Test tests mulitple parameters at the same time, similar to a hypothesis test.
wald.test(b = coef(mylogit), Sigma = vcov(mylogit), Terms = 4:6)

# p values is statistically significant in this case


# instead of using the terms argument, we can create a vector that describes the test we would like to run.
# we want to test the difference of the terms rank2 and rank3. In the cov matrix, the fourth and fifth columns.
test.vector = cbind(0,0,0,1,-1,0)
wald.test(b = coef(mylogit), Sigma = vcov(mylogit), L = test.vector)

# the p value is statistically significant


# the exponentiate function (constant e^n) gives us the odds-ratios??
exp(coef(mylogit))

# odds ratios and 95% CI; everything is exponentiated and given as an odds ratio.
exp(cbind(OR = coef(mylogit), confint(mylogit)))

newdata1 <- with(mydata, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))
# make sure that in the new data frame, the column heads have the same exact names as the variables in the statistical model

## view data frame
newdata1


# make a new variable rankP, which are the predicted values.
# rankP is the predicted probability that the given rank will be accepted into graduate school.
newdata1$rankP <- predict(mylogit, newdata = newdata1, type = "response")
newdata1


## we will now run a quick simulation. We want to see how each rank and given gre score results in a probability of acceptance into grad school. ##
newdata2 <- with(mydata, data.frame(gre = rep(seq(from = 200, to = 800, length.out = 100),
                                              4), gpa = mean(gpa), rank = factor(rep(1:4, each = 100))))
# this creates a new data frame that simulates a gre score and rank; gpa is just set to the mean.


# we are going to combine newdata2 and a prediction component. We will also include standard errors.
newdata3 <- cbind(newdata2, predict(mylogit, newdata = newdata2, type = "link",
                                    se = TRUE))
newdata3 <- within(newdata3, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})

# plogis() returns the logistic distribution
# we are plotting a distribution with confidence intervals

ggplot(newdata3, aes(x = gre, y = PredictedProb)) + geom_ribbon(aes(ymin = LL,
                                                                    ymax = UL, fill = rank), alpha = 0.2) + geom_line(aes(colour = rank),
                                                                                                                      size = 1) + ggtitle("Predicted Probability of Grad Admittance based on Rank")


# let's run a quick test to see how well our model fits.
# This is a Chi Squared test that asks whether our model fits better than a null (or empty) model.
with(mylogit, pchisq(null.deviance - deviance, df.null - df.residual, lower.tail = FALSE))
# the output is the resulting p value from the test. We can conclude that the model as a whole fits better than an empty model.
# chi squared of 41.46 (difference in deviance) with five degrees of freedom (degrees of freedom difference between the two models; "number of predictors in the mode")

