#Frequency table of race by zip code using Base R
zipObject <- table(wakeVoterActive$zip_code, wakeVoterActive$race_code)
class(zipObject)
zip_df <- as.data.frame(zipObject)
names(zip_df) = c("zip", "race", "pop")

#Frequency table of total pop by race
raceObject <- table(wakeVoterActive$race_code)
race_df <- as.data.frame(raceObject)
names(race_df) = c("race", "rpop")
race_df

#Convert race codes to full text
race_codes <- c("A" = "ASIAN", "B" = "BLACK or AFRICAN AMERICAN", "I" = "AMERICAN INDIAN or ALASKA NATIVE", 
                "M" = "TWO or MORE RACES", "O" = "OTHER", "P" = "NATIVE HAWAIIAN or PACIFIC ISLANDER", 
                "U" = "UNDESIGNATED", "W" = "WHITE")
zip_df$race <- plyr::revalue(zip_df$race, race_codes)

pop_top10_zip <- zip_df %>%
  group_by(zip) %>%
  summarize(total_pop = sum(pop)) %>% 
  arrange(desc(total_pop)) %>%
  head(n = 10)

#Join zip_df with pop_top10_zip to filter for largest 10 zip codes only
top10_full <- inner_join(zip_df, pop_top10_zip, by = "zip")

#Define color palette
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#Plot top 10
p_top10 <- top10_full %>%
  ggplot(aes(zip, pop, color = race, size = pop)) +
  geom_jitter(aes(size = pop), width = 0.1, height = 0.5, shape = 19) +
  scale_colour_manual(values = cbbPalette)
p_top10 + theme(axis.text.x = element_text(angle = 90))  +     
  labs(title = "Wake County Active Voters: Racial Distribution in the 10 most populous zip codes", 
       x = "zip code", 
       y = "population", 
       caption = "Data Source: https://www.ncsbe.gov/results-data/voter-registration-data#current-data")
