library(PoEdata)
library(stargazer)

# for time series analysis, consider using the package 'xts


#################################################################
##                    TIME SERIES MOEDELING                    ##
#################################################################


data("okun")


# start the time series at 1985, Q2. 
# For quarters, freq should be 4
okun.ts = ts(okun,start = c(1985,2),freq=4)

# custom function for creating the row names for a ts object
# so that when we view the df we know what each row represents
ts.row.names = function(tsobject){
  
  # check_times = as.Date(time(tsobject))
  
  times = time(tsobject)
  cycles = cycle(tsobject)
  
  times_df = as.data.frame(times)
  times_df[,"y"] = cycles
  
  
  if (frequency(tsobject) == 4) {
    
    times_df[,"result"] = paste0(
      gsub("\\..+", "", times_df$x),
      " ",
      "Q",
      times_df$y
    )
    
    return(times_df$result)
    
  } else if (frequency(tsobject) == 12) {
    
    times_df[,"result"] = paste0(
      gsub("\\..+", "", times_df$x),
      " ",
      month.abb[times_df$y]
    )
    
    return(times_df$result)
    
  }
  
}


rownames(okun.ts) = ts.row.names(okun.ts)



# the following is a finite distributed lag model. 
# Merely regress the DIFFERENCE (dependent) variable on the lags of the explanatory variable.
okun2 = data.frame(u = c(okun$u),
                       du = c(0, diff(okun$u, lag = 1)),
                       g = c(okun$g),
                       g.1 = c(NA,okun$g[1:97]),
                       g.2 = c(rep(NA, 2),okun$g[1:96]),
                       g.3 = c(rep(NA, 3),okun$g[1:95]))
rownames(okun2) = ts.row.names(ts(okun, start = c(1985,2), frequency = 4))

okun.dlm = lm(du ~ g + g.1 + g.2 + g.3, data = okun2)
okun.dlm.2 = lm(du ~ g + g.1 + g.2, data = okun2)

stargazer(okun.dlm,okun.dlm.2,
          type = "text",
          report = "vc*stp",
          digits = 4,
          intercept.bottom =  F)



plot(okun.ts)










