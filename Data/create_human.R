# Read the data

hd <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Explore the datasets

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

View(hd)
View(gii)

# Rename Variables

# Rename variables.

newHdNames <- c("HDI.R", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.HDI")

newGiiNames <- c("GII.R", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

names(hd)  <- newHdNames
names(gii) <- newGiiNames

View(hd)
View(gii)


# Mutating “Gender inequality” data

gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)

View(gii)


# Joining the two datasets

library(dplyr)
human <- inner_join(hd, gii, by = "Country")

View(human)
# This "human" dataset has 195 observations and 19 variables.


# Save the dataset

write.csv(human, file = "data/human.csv")

