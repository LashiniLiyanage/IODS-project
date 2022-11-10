Name: "Lashini Liyanage"

Date: "09.11.2022"

# Data Wrangling script for the Assignment 2

# Reading Data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Structure of the data
str(lrn14)

# Dimension of the data
dim(lrn14)

View(lrn14)

# There are 183 rows (the observations) and 60 columns (the variables) in the original data set. 

library(dplyr)

# Creating the analysis dataset

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)

# Re-checking the analysis dataset
dim(learning2014)
View(learning2014)

# Saving the analysis dataset
write.csv(learning2014, file='data/learning2014.csv')

# Reading and checking the saved dataset
# I saved this using a new name (learning2014_), so I can check whether the data is wrangled and saved correctly. 
learning2014_ <- read.csv("learning2014.csv")

str(learning2014_)
dim(learning2014_)
head(learning2014_)
View(learning2014_)

# The new datasethas 166 observations and 7 variables and everything seems to be okay