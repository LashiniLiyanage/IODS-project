# Load the original data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep =" ", header = TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   sep = '\t', header = TRUE)

library(dplyr)
library(tidyverse)

# Column names of data
names(BPRS)
names(RATS)

# Glimpse of the data
glimpse(BPRS)
glimpse(RATS)

# Structure of the data 
str(BPRS)
str(RATS)

# Dimension of the data
dim(BPRS)
dim(RATS)

# Summaries of the data
summary(BPRS)
summary(RATS)

# Convert the categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID) 
RATS$Group <- factor(RATS$Group)

# Convert dataset to long form and add variables
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% 
  mutate(weeks = as.integer(substr(weeks, 5, 5))) %>%
  arrange(weeks) 

RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)

# Compare column names of long and wide data
names(BPRSL); names(BPRS)
names(RATSL); names(RATS)

# Compare dimension of the long and wide data
dim(BPRSL); dim(BPRS)
dim(RATSL); dim(RATS)

# Compare glimpse of the long and wide data
glimpse(BPRSL); glimpse(BPRS)
glimpse(RATSL); glimpse(RATS)

# Compare structure of the long and wide data 
str(BPRSL); str(BPRS)
str(RATSL); str(RATS)

# Compare summaries of the long and wide data
summary(BPRSL); summary(BPRS)
summary(RATSL); summary(RATS)


### BPRS
## There are 11 columns in wide form where there is only 4 columns in long form. 
## In the long format all the weeks come under one categorical variable
## There is a new column in long format as bprs
## There are 360 observations and 4 variables in long form while there's only 40 observations and 11 variables in wide form

###RATS
## There are 13 columns in wide form where there is only 5 columns in long form. 
## In the long format all the WD come under one categorical variable
## There are two new columns in long format as weight and time
## There are 176 observations and 5 variables in long form while there's only 16 observations and 13 variables in wide form


# Save the data (in long format)
write_csv(BPRSL, "data/BPRSL.csv")
write_csv(RATSL, "data/RATSL.csv")

# Save data in RDS-format (to preserve factor types)
saveRDS(BPRSL, "data/BPRSL.rds")
saveRDS(RATSL, "data/RATSL.rds")