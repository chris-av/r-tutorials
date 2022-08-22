library(PoEdata)


##################################################################
##                        EXPLORING DATA                        ##
##################################################################

data("food")


# how to calculate the mean
mean(food$food_exp)
mean(food$income)

# how to find the variance for a variable
var(food$food_exp)
var(food$income)

# how to find the median of a variable
median(food$food_exp)
median(food$income)

# how to find the minimum of a variable
min(food$food_exp)
min(food$income)

# how to find the maximum of a variable
max(food$food_exp)
max(food$income)

# how to find the standard deviation of a variable
sd(food$food_exp)
sd(food$income)

# simple function for finding the mean for each column
colMeans(food)

# alternate method for running a function across each column of a dataset
sapply(food, mean)
sapply(food, min)
sapply(food, max)

