library(PoEdata)


#################################################################
##                MULTIPLE PLOTS ON SAME WINDOW                ##
#################################################################


data("usa")

# create a time series for each column
gdp.ts = ts(usa$gdp, frequency = 4, start = c(1984,1))
inf.ts = ts(usa$inf, frequency = 4, start = c(1984,1))
f.ts = ts(usa$f, frequency = 4, start = c(1984,1))
b.ts = ts(usa$b, frequency = 4, start = c(1984,1))

# create another corresponding time series, but differences
gdp.diff = diff(gdp.ts)
inf.diff = diff(inf.ts)
f.diff = diff(f.ts)
b.diff = diff(b.ts)

# in order to have multiple plots, set the parameters for the new window
# below means a window with three panels down, and two panels across
par(mfrow = c(3,2))

# you can now plot 
plot(inf.ts, 
     main = "Inflation",
     ylab = "Inflation Rate")
plot(inf.diff, 
     main = "Inflation Difference",
     ylab = "")
abline(h = 0, col = "red")
plot(f.ts, 
     main = "Federal Funds Rate",
     ylab = "FF Rate")
plot(f.diff, 
     main = "Federal Funds Rate Difference",
     ylab = "")
abline(h = 0, col = "red")
plot(b.ts, 
     main = "Bonds",
     ylab = "Bonds Rate")
plot(inf.diff, 
     main = "Bonds Rate Difference",
     ylab = "")
abline(h = 0, col = "red")

