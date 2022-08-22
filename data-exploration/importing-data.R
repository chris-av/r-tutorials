library(readr)

# readr package has most of what I need
# note that this is a fake filepath, use a real file name!!!
dta = read_delim(file = "filepath.csv", delim = ",")


# NOTE: if the data set is HUGE, then this package (like others) will try to GUESSS what the data types are
# This can have implications and can cause errors
# example: first 40k rows of UserName is empty, then row 40,001 has a name/character value
#    this may produce a parsing error because R guessed UserName column to be logical/boolean, but encountered a string further down
# for large datasets/files, it is probably safer to import the entire file as character and then modify the datatype later

# how to read from file and make all col types character by default for this import
dta = read_delim(file = "filepath.csv", 
                 delim = ",",
                 col_types = cols(.default = "c"))




