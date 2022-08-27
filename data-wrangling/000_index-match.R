test_data = data.frame(full_name = c("Chris", "Bob", "Mark"), stringsAsFactors = F)


database = data.frame(full_name = c("Chris", "Jeremy", "Justin", "Stephany", "Jorge", "Matthew", "Bernice", "Bob"),
                      location = c("Los Angles", "New York", "Instanbul", "Kyiv", "Asuncion", "Mexico", "Ottawa", "Qatar"),
                      val = rnorm(8, sd = 1, mean = 5),
                      stringsAsFactors = F)

# all values that could be found in the database are found
# note that this does not break even if there is a missing value
test_data[, "location"] = database[cbind(
  match(test_data$full_name, database$full_name),
  match("location", names(database))
)]


# you can convert this into a helper function for reuse
indexMatch = function(df_new, df_src, col_match_on, col_return) {
  vctr = as.data.frame(df_src)[cbind(
    match(df_new[, col_match_on], df_src[, col_match_on]),
    match(col_return, names(df_src))
  )]
  return (vctr)
}


test_data[, "location"] = indexMatch(df_new = test_data, 
                                     df_src = database, 
                                     col_match_on = "full_name", 
                                     col_return = "location")



