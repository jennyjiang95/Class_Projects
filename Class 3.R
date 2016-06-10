# Lession 3 Data Structures in R

# Data Types
# Numeric
# Integer
# Character: text/ strings ALWAYS in quotes. 
# Logic: TRUE and FALSE
# Complex

# Null: empty, no data type
# NA: denotes a missing value
# Inf: positive infinity
# NaN: not a number

# Vector: only one type of data type
# create with c() 
# a seq of consecutive numbers. : seq (1:6) or 1:6 

x <- c (1,0, FALSE, TRUE)
class (x)

# Named Vectors

x <-c (first = "a", second = "b", third = "c")
x["second"]
x [c ("first", "second")]
#MUST KNOW THE DATA TYPE

# Lists: recursive, can contain list 

# Data Frame. equal-length vectors. 

# Each colume must be atomic, data frame doesn't have to be atomic. 
# Data frame are a list of lists. 
# use $, or [[]]
# single [] will return a data frame

df <- data.frame(x = seq (1,3), y = c ("a", "b", "c"), z = c (T, F, F))

df["x"] <- c ("one", "two", "three")























