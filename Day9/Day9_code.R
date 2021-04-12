# Data: World Bank DataBank Education Statistics
# https://databank.worldbank.org/world_literacy1970_2020/id/a03f8d6d

library(tidyverse)
library(reshape2)

literacy <- read_csv("wl1976_2019.csv")

# Save as a data frame
literacy <- as.data.frame(literacy)

# New column names
colnames(literacy) <- c("year","ccode", "gpia", "adult_lit", "flit", "mlit")

# Remove extra characters from year column
literacy$year <- str_remove(literacy$year, "YR")
 
# Something is causing errors on class conversion of year column. 
# Remove white space, extraneous rows, useless column
str_trim(literacy$year)
literacy <- literacy[-c(45:49), -2]
# Coerce year to numeric
literacy$year <- as.numeric(literacy$year)

# Scale last 3 variables (%) to match scale of gpia
literacy[,3:5] <- literacy[,3:5] / 100

# melt the df
literacy2 <- melt(literacy, id = "year")

# plot
ggplot(literacy2, aes(x = year, y = value, color = variable)) +
  geom_line() +
  geom_point(data = literacy2[literacy2$value > 0.923,],
             pch = 21, fill = "black", size = 2, color = "red") +
  annotate("text", x = 2016, y = 0.93, label = "0.923 in 2019", color = "red") +
  scale_color_discrete(labels = c("Adjusted Gender Parity Index (GPIA)", "Adult literacy", "Female literacy", "Male literacy")) +
  labs(title = "Gender Parity in World Literacy",
       subtitle = "1976-2019",
       x = "", y = "", 
       caption = "Data: World Bank DataBank Education Statistics") +
  theme(panel.background = element_rect(fill = "lemonchiffon2"),
        panel.grid = element_blank(),
        legend.title = element_blank())

