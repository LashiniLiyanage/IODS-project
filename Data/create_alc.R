Name: "Lashini Liyanage"

Date: "15.11.2022"

# Data Wrangling script for the Assignment 3

# The data sets were retrieved from the UCI Machine Learning Repository 
# (https://archive.ics.uci.edu/ml/datasets/Student+Performance)


# Reading Data
mat <- read.csv("student-mat.csv", sep=";", header=TRUE)
View(mat)

por <- read.csv("student-por.csv", sep=";", header=TRUE)
View(por)


# Structure of the data
str(mat)
str(por)


# Dimension of the data
dim(mat)
dim(por)


# Joining two datasets

library(dplyr)

free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))


# Removing duplicate records

alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}


# Creating new columns

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)


# Re-checking the data

View(alc)

glimpse(alc)


# Saving the analysis dataset

write.csv(alc, file='data/alc.csv')




