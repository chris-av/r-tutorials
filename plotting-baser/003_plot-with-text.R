library(gapminder)  # for gapminder data set


##################################################################
##                      PLOTTING WITH TEXT                      ##
##################################################################


# gapminder is a simple data frame; however, the years keep repeating. The split groups the data by year.
gapminder_split <- split(gapminder, gapminder$year)

par(mfrow=c(2,2))
for(i in 1:length(gapminder_split)){
  gap_x = unlist(gapminder_split[[i]][,"lifeExp"])
  gap_y = unlist(gapminder_split[[i]][,"gdpPercap"])
  gap_text = unlist(gapminder_split[[i]][,"country"])
  
  plot(gap_x, gap_y,
       main = paste0("GDPpc to Life Expectancy ",names(gapminder_split[i])),
       pch = 16, col = "blue",
       xlab = "Life Expectancy",
       ylab = "GDPpc",
       ylim = c(0,19000))
  
  costa_rica_df = subset(gapminder_split[[i]], gapminder_split[[i]]$country == "Costa Rica")
  
  points(unlist(costa_rica_df[,"lifeExp"]), unlist(costa_rica_df[,"gdpPercap"]), pch = 19, col = "red2", cex = 1.3)
  text(gap_x, gap_y, labels = gap_text, 
       cex = 0.8, pos = 4)
  
}

