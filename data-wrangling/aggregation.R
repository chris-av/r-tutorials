# generate a fake dataset
name = c("Christian", "Rose Mary", "Cynthia", "Alexx", "Rebeccah", "Nadir", "Kelly", "Dalia")
color = c("red", "blue", "green", "orange", "yellow", "purple", "indigo", "violet")

test_data = data.frame(
  name = rep(name, 2),
  color = c(color, sort(color)),
  number = abs(round(rnorm(16,0,5)))
)


# note that some names are duplicated
# we want to use the aggregate function to find all the unique names and add up their number values
print(test_data)

# the aggregate function is powerful and can be used to summarize data frames in one go
aggregate(number ~ name, data = test_data, sum)    # for each name, add up all their number values, like a pivot
aggregate(number ~ name, data = test_data, mean)   # for each name, find the mean 
aggregate(number ~ name, data = test_data, max)    # for each name, find the max value 


