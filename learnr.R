# -*- coding: utf-8 -*-
# Comments start with number symbols.

# You can't make multi-line comments,
# but you can stack multiple comments like so.

# in Windows you can use CTRL-ENTER to execute a line.
# on Mac it is COMMAND-ENTER

# # Stuff you can do without understanding anything about programming

# In this section, we show off some of the cool stuff you can do in
# R without understanding anything about programming. Do not worry
# about understanding everything the code does. Just enjoy!

data() # browse pre-loaded data sets

data(rivers) # get this one: "Lengths of Major North American Rivers"
ls() # notice that "rivers" now appears in the workspace

head(rivers) # peek at the data set

length(rivers) # how many rivers were measured?

summary(rivers) # what are some summary statistics?

# make a stem-and-leaf plot (a histogram-like data visualization)
stem(rivers)

stem(log(rivers)) # Notice that the data are neither normal nor log-normal!
# Take that, Bell curve fundamentalists.

# make a histogram:
hist(rivers, col = "#333333", border = "white", breaks = 25) # play around with these parameters

hist(log(rivers), col = "#333333", border = "white", breaks = 25) # you'll do more plotting later

# Here's another neat data set that comes pre-loaded. R has tons of these.
data(discoveries)
plot(discoveries,
  col = "#333333", lwd = 3, xlab = "Year",
  main = "Number of important discoveries per year"
)

plot(discoveries,
  col = "#333333", lwd = 3, type = "h", xlab = "Year",
  main = "Number of important discoveries per year"
)

# Rather than leaving the default ordering (by year),
# we could also sort to see what's typical:
sort(discoveries)

stem(discoveries, scale = 2)

max(discoveries)

summary(discoveries)

# Roll a die a few times
round(runif(7, min = .5, max = 6.5))

# Draw from a standard Gaussian 9 times
rnorm(9)

# # Data types and basic arithmetic

# Now for the programming-oriented part of the tutorial.
# In this section you will meet the important data types of R:
# integers, numerics, characters, logicals, and factors.
# There are others, but these are the bare minimum you need to
# get started.

# ## INTEGERS

# Long-storage integers are written with L
5L
class(5L)
# (Try ?class for more information on the class() function.)
# In R, every single value, like 5L, is considered a vector of length 1
length(5L)
# You can have an integer vector with length > 1 too:
c(4L, 5L, 8L, 3L)
length(c(4L, 5L, 8L, 3L))
class(c(4L, 5L, 8L, 3L))

# ## NUMERICS

# A "numeric" is a double-precision floating-point number
5
class(5)
# Again, everything in R is a vector;
# you can make a numeric vector with more than one element
c(3, 3, 3, 2, 2, 1)
# You can use scientific notation too
5e4
6.02e23 # Avogadro's number
1.6e-35 # Planck length
# You can also have infinitely large or small numbers
class(Inf)
class(-Inf)
# You might use "Inf", for example, in integrate(dnorm, 3, Inf);
# this obviates Z-score tables.

# ## BASIC ARITHMETIC

# You can do arithmetic with numbers
# Doing arithmetic on a mix of integers and numerics gives you another numeric
10L + 66L # 76      # integer plus integer gives integer
53.2 - 4 # 49.2    # numeric minus numeric gives numeric
2.0 * 2L # 4       # numeric times integer gives numeric
3L / 4 # 0.75    # integer over numeric gives numeric
3 %% 2 # 1       # the remainder of two numerics is another numeric
# Illegal arithmetic yields you a "not-a-number":
0 / 0
class(NaN)
# You can do arithmetic on two vectors with length greater than 1,
# so long as the larger vector's length is an integer multiple of the smaller
c(1, 2, 3) + c(1, 2, 3)
# Since a single number is a vector of length one, scalars are applied
# elementwise to vectors
(4 * c(1, 2, 3) - 2) / 2
# Except for scalars, use caution when performing arithmetic on vectors with
# different lengths. Although it can be done,
c(1, 2, 3, 1, 2, 3) * c(1, 2)
# Matching lengths is better practice and easier to read
c(1, 2, 3, 1, 2, 3) * c(1, 2, 1, 2, 1, 2)

# ## CHARACTERS

# There's no difference between strings and characters in R
"Horatio"
class("Horatio")
class("H")
# Those were both character vectors of length 1
# Here is a longer one:
c("alef", "bet", "gimmel", "dalet", "he")
length(c("Call", "me", "Ishmael"))
# You can do regex operations on character vectors:
substr("Fortuna multis dat nimis, nulli satis.", 9, 15)
gsub("u", "ø", "Fortuna multis dat nimis, nulli satis.")
# R has several built-in character vectors:
letters
month.abb

# ## LOGICALS

# In R, a "logical" is a boolean
class(TRUE)
class(FALSE)
# Their behavior is normal
TRUE == TRUE
TRUE == FALSE
FALSE != FALSE
FALSE != TRUE
# Missing data (NA) is logical, too
class(NA)
# Use | and & for logic operations.
# OR
TRUE | FALSE
# AND
TRUE & FALSE
# Applying | and & to vectors returns elementwise logic operations
c(TRUE, FALSE, FALSE) | c(FALSE, TRUE, FALSE)
c(TRUE, FALSE, TRUE) & c(FALSE, TRUE, TRUE)
# You can test if x is TRUE
isTRUE(TRUE) # TRUE
# Here we get a logical vector with many elements:
c("Z", "o", "r", "r", "o") == "Zorro"
c("Z", "o", "r", "r", "o") == "Z"

# ## FACTORS

# The factor class is for categorical data
# Factors can be ordered (like childrens' grade levels) or unordered (like colors)
factor(c("blue", "blue", "green", NA, "blue"))
# Levels: blue green
# The "levels" are the values the categorical data can take
# Note that missing data does not enter the levels
levels(factor(c("green", "green", "blue", NA, "blue")))
# If a factor vector has length 1, its levels will have length 1, too
length(factor("green"))
length(levels(factor("green")))
# Factors are commonly seen in data frames, a data structure we will cover later
data(infert) # "Infertility after Spontaneous and Induced Abortion"
levels(infert$education)

# ## NULL

# "NULL" is a weird one; use it to "blank out" a vector
class(NULL)
parakeet <- c("beak", "feathers", "wings", "eyes")
parakeet
parakeet <- NULL
parakeet

# ## TYPE COERCION

# Type-coercion is when you force a value to take on a different type
as.character(c(6, 8))
as.logical(c(1, 0, 1, 1))
# If you put elements of different types into a vector, weird coercions happen:
c(TRUE, 4)
c("dog", TRUE, 4)
as.numeric("Bilbo")

# Also note: those were just the basic data types
# There are many more data types, such as for dates, time series, etc.

# # Variables, loops, if/else

# A variable is like a box you store a value in for later use.
# We call this "assigning" the value to the variable.
# Having variables lets us write loops, functions, and if/else statements

# ## VARIABLES

# Lots of way to assign stuff:
x <- 5 # this is possible (editorial: this reads `x = 5` before auto-formatter.)
y <- "1" # this is preferred
TRUE -> z # this works but is weird

# ## LOOPS

# We've got for loops
for (i in 1:4) {
  print(i)
}
# We've got while loops
a <- 10
while (a > 4) {
  cat(a, "...", sep = "")
  a <- a - 1
}
# Keep in mind that for and while loops run slowly in R
# Operations on entire vectors (i.e. a whole row, a whole column)
# or apply()-type functions (we'll discuss later) are preferred

# IF/ELSE
# Again, pretty standard
if (4 > 3) {
  print("4 is greater than 3")
} else {
  print("4 is not greater than 3")
}

# ## FUNCTIONS

# Defined like so:
jiggle <- function(x) {
  x <- x + rnorm(1, sd = .1) # add in a bit of (controlled) noise
  return(x)
}
# Called like any other R function:
set.seed(2716057)
jiggle(5) # 5±ε. After set.seed(2716057), jiggle(5)==5.005043

# # Data structures: Vectors, matrices, data frames, and arrays

# ## ONE-DIMENSIONAL

# Let's start from the very beginning, and with something you already know: vectors.
vec <- c(8, 9, 10, 11)
vec
# We ask for specific elements by subsetting with square brackets
# (Note that R starts counting from 1)
vec[1]
letters[18]
LETTERS[13]
month.name[9]
c(6, 8, 7, 5, 3, 0, 9)[3]
# We can also search for the indices of specific components,
which(vec %% 2 == 0)
# grab just the first or last few entries in the vector,
head(vec, 1)
tail(vec, 2)
# or figure out if a certain value is in the vector
any(vec == 10)
# If an index "goes over" you'll get NA:
vec[6]
# You can find the length of your vector with length()
length(vec)
# You can perform operations on entire vectors or subsets of vectors
vec * 4
vec[2:3] * 5
any(vec[2:3] == 8)
# and R has many built-in functions to summarize vectors
mean(vec)
var(vec)
sd(vec)
max(vec)
min(vec)
sum(vec)
# Some more nice built-ins:
5:15
seq(from = 0, to = 31337, by = 1337)

# ## TWO-DIMENSIONAL (ALL ONE CLASS)

# You can make a matrix out of entries all of the same type like so:
mat <- matrix(nrow = 3, ncol = 2, c(1, 2, 3, 4, 5, 6))
mat
# Unlike a vector, the class of a matrix is "matrix", no matter what's in it
class(mat)
# Ask for the first row
mat[1, ]
# Perform operation on the first column
3 * mat[, 1]
# Ask for a specific cell
mat[3, 2]

# Transpose the whole matrix
t(mat)

# Matrix multiplication
mat %*% t(mat)

# cbind() sticks vectors together column-wise to make a matrix
mat2 <- cbind(1:4, c("dog", "cat", "bird", "dog"))
mat2
class(mat2)
# Again, note what happened!
# Because matrices must contain entries all of the same class,
# everything got converted to the character class
c(class(mat2[, 1]), class(mat2[, 2]))

# rbind() sticks vectors together row-wise to make a matrix
mat3 <- rbind(c(1, 2, 4, 5), c(6, 7, 0, 4))
mat3
# Ah, everything of the same class. No coercions. Much better.

# ## TWO-DIMENSIONAL (DIFFERENT CLASSES)

# For columns of different types, use a data frame
# This data structure is so useful for statistical programming,
# a version of it was added to Python in the package "pandas".

students <- data.frame(
  c("Cedric", "Fred", "George", "Cho", "Draco", "Ginny"),
  c(3, 2, 2, 1, 0, -1),
  c("H", "G", "G", "R", "S", "G")
)
names(students) <- c("name", "year", "house") # name the columns
class(students) # "data.frame"
students
class(students$year)
class(students[, 3])
# find the dimensions
nrow(students)
ncol(students)
dim(students)

# + active=""
# ?data.frame
# -

# There are many twisty ways to subset data frames, all subtly unalike
students$year
students[, 2]
students[, "year"]

# An augmented version of the data.frame structure is the data.table
# If you're working with huge or panel data, or need to merge a few data
# sets, data.table can be a good choice. Here's a whirlwind tour:
# install.packages("data.table") # download the package from CRAN
require(data.table) # load it
students <- as.data.table(students)
students # note the slightly different print-out
students[name == "Ginny"] # get rows with name == "Ginny"
students[year == 2] # get rows with year == 2
# data.table makes merging two data sets easy
# let's make another data.table to merge with students
founders <- data.table(
  house = c("G", "H", "R", "S"),
  founder = c("Godric", "Helga", "Rowena", "Salazar")
)
founders
setkey(students, house)
setkey(founders, house)
students <- founders[students] # merge the two data sets by matching "house"
setnames(students, c("house", "houseFounderName", "studentName", "year"))
students[, order(c("name", "year", "house", "houseFounderName")), with = F]

# data.table makes summary tables easy
students[, sum(year), by = house]

# To drop a column from a data.frame or data.table,
# assign it the NULL value
students$houseFounderName <- NULL
students

# Drop a row by subsetting
# Using data.table:
students[studentName != "Draco"]
# Using data.frame:
students <- as.data.frame(students)
students[students$house != "G", ]

# ## MULTI-DIMENSIONAL (ALL ELEMENTS OF ONE TYPE)

# Arrays creates n-dimensional tables
# All elements must be of the same type
# You can make a two-dimensional table (sort of like a matrix)
array(c(c(1, 2, 4, 5), c(8, 9, 3, 6)), dim = c(2, 4))
# You can use array to make three-dimensional matrices too
array(c(c(c(2, 300, 4), c(8, 9, 0)), c(c(5, 60, 0), c(66, 7, 847))), dim = c(3, 2, 2))

# ## LISTS (MULTI-DIMENSIONAL, POSSIBLY RAGGED, OF DIFFERENT TYPES)

# Finally, R has lists (of vectors)
list1 <- list(time = 1:40)
list1$price <- c(rnorm(40, .5 * list1$time, 4)) # random
list1
# You can get items in the list like so
list1$time # one way
list1[["time"]] # another way
list1[[1]] # yet another way
# You can subset list items like any other vector
list1$price[4]

# Lists are not the most efficient data structure to work with in R;
# unless you have a very good reason, you should stick to data.frames
# Lists are often returned by functions that perform linear regressions

# # The apply() family of functions

# Remember mat?
mat
# Use apply(X, MARGIN, FUN) to apply function FUN to a matrix X
# over rows (MAR = 1) or columns (MAR = 2)
# That is, R does FUN to each row (or column) of X, much faster than a
# for or while loop would do
apply(mat, MAR = 2, jiggle)
# Other functions: ?lapply, ?sapply

# Don't feel too intimidated; everyone agrees they are rather confusing

# The plyr package aims to replace (and improve upon!) the *apply() family.
# install.packages("plyr")
require(plyr)
# ?plyr

# # Loading data

# "pets.csv" is a file on the internet
# (but it could just as easily be a file on your own computer)
# install.packages("RCurl")
require(RCurl)
pets <- read.csv(textConnection(getURL("https://learnxinyminutes.com/docs/pets.csv")))
pets
head(pets, 2) # first two rows
tail(pets, 1) # last row

# To save a data frame or matrix as a .csv file
write.csv(pets, "pets2.csv") # to make a new .csv file
# set working directory with setwd(), look it up with getwd()

# Try ?read.csv and ?write.csv for more information

# # Statistical Analysis

# Linear regression!
linearModel <- lm(price ~ time, data = list1)
linearModel # outputs result of regression
summary(linearModel) # more verbose output from the regression
coef(linearModel) # extract estimated parameters
summary(linearModel)$coefficients # another way to extract results
summary(linearModel)$coefficients[, 4] # the p-values

# ## GENERAL LINEAR MODELS

# Logistic regression
set.seed(1)
list1$success <- rbinom(length(list1$time), 1, .5) # random binary
glModel <- glm(success ~ time,
  data = list1,
  family = binomial(link = "logit")
)
glModel # outputs result of logistic regression
summary(glModel) # more verbose output from the regression

# # Plots

# ## BUILT-IN PLOTTING FUNCTIONS

# Scatterplots!
plot(list1$time, list1$price, main = "fake data")
# Plot regression line on existing plot
abline(linearModel, col = "red")

# Get a variety of nice diagnostics
plot(linearModel)

# Histograms!
hist(rpois(n = 10000, lambda = 5), col = "thistle")

# Barplots!
barplot(c(1, 4, 5, 1, 2), names.arg = c("red", "blue", "purple", "green", "yellow"))

# GGPLOT2
# But these are not even the prettiest of R's plots
# Try the ggplot2 package for more and better graphics
# install.packages("ggplot2")
require(ggplot2)
# ?ggplot2
pp <- ggplot(students, aes(x = house))
pp + geom_bar()

ll <- as.data.table(list1)
pp <- ggplot(ll, aes(x = time, price))
pp + geom_point()
# ggplot2 has excellent documentation (available http://docs.ggplot2.org/current/)
