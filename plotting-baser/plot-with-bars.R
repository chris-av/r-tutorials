
##################################################################
##                     SHOWING BARS ON PLOT                     ##
##################################################################



dates = seq(
  as.Date("2020-01-05"),
  as.Date("2020-06-05"),
  1
)

dta = data.frame(dates = dates)
dta[, "val"] = NA

for(i in 1:nrow(dta)) {
  dta[i, "val"] = rnorm(1, mean = (100* i), sd = (i * 5))
}

bars = data.frame(
  beg_dates = as.Date(c("2020-01-15", "2020-03-22")),
  end_dates = as.Date(c("2020-01-22", "2020-04-19"))
)

with(dta , {
  plot(dates, val, 
       type = "l", main = "Test Data",

       # rect are the shaded areas, see ?rect for how to construct rect's
       panel.first = rect(bars$beg_dates, -1e6, 
                          bars$end_dates, 1e6,
                          col = "grey", border = NA)
       
  )
})
