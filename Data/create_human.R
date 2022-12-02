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



## Second Part (Continuation from the last week)

# Mutate the data

library(stringr)
str(human$GNI)

human$GNI <- str_replace(human$GNI, pattern = ",", replace = "") %>% 
  as.numeric
str(human$GNI)

#Exclude the unnecessary variable

library(dplyr)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
complete.cases(human)

View(human)
dim(human)


#Remove rows with missing values
human <- human %>% filter(complete.cases(human))

#Remove the observations which relate to regions instead of countries
last <- nrow(human) - 7
human <- human[1:last, ]

# Define the row names of the data
rownames(human) <- human$Country
human$Country <- NULL
dim(human)

# Save the dataset (Overwrite the previous one)
write.csv(human, file = "data/human.csv")
