install.packages("plotrix")
library(plotrix)
library(tidyverse)

# Census Data quick facts: https://www.census.gov/quickfacts/fact/table/US/RHI125219#qf-headnote-a
# Downloaded table, did some formatting in Excel

us_race <- read.csv("/media/em/ADATA SE770G/datasets/us_race_percent.csv", header = FALSE, col.names = c("race", "value"))
us_race$value <- as.character(us_race$value)
us_race$value <- str_remove(us_race$value, "%")
us_race$value <- as.numeric(us_race$value)
us_race$race <- as.factor(us_race$race)

# Call values and labels for pie chart
pieval<-us_race$value
lbls <- us_race$race
# Find label positions and adjust
bc<-pie3D(pieval,explode=0.1,theta = pi/4, main="Racial makeup of the US")
bc[1:6] <- c(2.3, 5.4, 5.9, 5.9, 6.2, 6.4) 
# Add data to the labels
pielabels<-paste0(lbls, " ", pieval, "%", sep = "")
pie3D(pieval, radius = 0.9, labels = pielabels, theta = pi/4, explode = 0.1, col = colorspace::rainbow_hcl(6), main = "Racial makeup of the US", labelpos = bc)

