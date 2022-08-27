library(PoEdata)    # for importing london dataset
library(stargazer)  # for printing regression models
library(margins)    # for generating marginal effects data frame


##################################################################
##                 CALCULATING MARGINAL EFFECTS                 ##
##################################################################

data("london")
london$lntotalexp = log(london$totexp)

# attach(london)

model1 = lm(wtrans ~ lntotalexp + age + nk,
            data = london)

stargazer(type = "text",model1,
          intercept.bottom = F,
          report = "vc*stp",
          digits = 4)

# model using the log of total experience, age and number of kids
model1 = lm(wtrans ~ lntotalexp + age + nk,
            data = london)

# we print the marginal effects of each estimated beta
margins.model1 = margins(model1)
print(summary(margins.model1), digits = 6) # same as stata
