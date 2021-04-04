# Household Debt Service and Financial Obligations Ratios
#Federal Reserve Data
# https://www.federalreserve.gov/releases/housedebt/default.htm

install.packages("reshape2")

library(tidyverse)
library(zoo)
library(reshape2)

# Read in the data
debt <- read_csv("FRB_FOR.csv")

# Convert to a data frame
debt <- as.data.frame(debt)

# Remove useless columns
remove <- c(1:5)
debt2 <- debt[-remove, ]

#Convert columns 2:5 to numeric
debt2[, 2:5] <- sapply(debt2[, 2:5], as.numeric)
str(debt2)

# Rename columns
dCnames <- c("quarter", "debt_ratio", "mortgage", "consumer", "fin_obli")
colnames(debt2) <- dCnames

# Convert the $quarter column to a time series object using the 'zoo' package
debt2$quarter <- as.yearqtr(debt2$quarter)          # New skill!!

# Define column legend labels as original text
leg_labels <- colnames(debt[2:5])

# Melt the df to variable/value columns to plot multiple lines
debt_m <- melt(debt2, id=c("quarter")) 

# Plot the time series
ggplot(debt_m, aes(x = quarter, y = value, color = variable)) +
  geom_line() +
  scale_color_manual(labels = leg_labels, values = c("red", "orange", "blue", "green")) +
  scale_x_continuous(labels = c("1980", "1990", "2000", "2010", "2020")) +      #replace ugly quarter labels
  labs(title = "Household Debt Service and Financial Obligations Ratios, 1980-2020",
                 caption = "Federal Reserve Household Finance Data  https://www.federalreserve.gov/releases/housedebt/default.htm",
                 x = "year",
                 y = "% total disposable personal income",
       color = "\n")     #remove legend title; type a new name before \n to replace with a new title instead




