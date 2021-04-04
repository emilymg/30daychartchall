install.packages("RColorBrewer")
library(tidyverse)
library(RColorBrewer)
library(scales)
library(DataExplorer)

#Plot active voters by age group, color by gender
p_ageGen <- ggplot(wakevoterdemo, aes(x = age_group, fill = gender_code)) +
  geom_bar() 
p_ageGen + scale_fill_brewer(palette = "Dark2") +
  scale_y_continuous(breaks = c(50000, 100000, 150000, 200000, 250000),
                     labels = comma_format(big.mark = ",",
                                           decimal.mark = ".")) +
  labs(title = "Wake County Active Voters by Age and Gender",
       caption = "Data Source: https://www.ncsbe.gov/results-data/voter-registration-data#current-data",
       fill = "Gender") +
  theme(axis.title.x = element_blank(), 
        axis.title.y = element_blank())

#Plot active voters by party affiliation, color by gender
p_partyGen <- ggplot(wakevoterdemo, aes(x = party_cd)) +
  geom_bar(aes(fill = gender_code)) +
  scale_y_continuous(breaks = c(50000, 100000, 150000, 200000, 250000), labels = comma_format(big.mark = ",",
                                                                                              decimal.mark = ".")) +
  scale_fill_brewer(palette = "Dark2") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank()) +
  labs(title = "Wake County Active Voters",
       subtitle = "Party Affiliation by Gender",
       caption = "Data Source: https://www.ncsbe.gov/results-data/voter-registration-data#current-data",
       fill = "Gender")

p_partyGen

#set a target vector to filter for 3rd parties
target <- c("CONSTITUTION", "GREEN", "LIBERTARIAN")

#plot 3rd parties alone to zoom in
p_zoom3rd <- wakevoterdemo %>%
  filter(party_cd %in% target) %>%
  ggplot(aes(x = party_cd)) +
  geom_bar(aes(fill = gender_code)) +
  scale_fill_brewer(palette = "Dark2") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank()) +
  labs(title = "Wake County Active Third Party Voters",
       subtitle = "Party affiliation by gender",
       caption = "Data Source: https://www.ncsbe.gov/results-data/voter-registration-data#current-data",
       fill = "Gender")

p_zoom3rd