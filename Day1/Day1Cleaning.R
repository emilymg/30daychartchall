# Project using publicly available voter registration data from NCSBE.gov (file too large for git)
# NC voter registration data is updated weekly on Saturdays and is available for each county here:
# https://www.ncsbe.gov/results-data/voter-registration-data#current-data

library(tidyverse)

#Wake County, NC voter data, source NC State Board of Elections 
wake_full <- read.delim("ncvoter92_04012021.txt")

#Keep only the first 30 columns
wakevoter <- wake_full[, 1:30]
#Filter for active voters only
wakeVoterActive <- wakevoter %>%
  filter(voter_status_desc == "ACTIVE")

#Remove identifying information, keep only demographic fields
wakevoterdemo <- wakeVoterActive %>%
  select(voter_status_desc, race_code:birth_age)

#Replace coded information with full names
wakevoterdemo$gender_code <- wakevoterdemo$gender_code %>%
  str_replace_all(c("M" = "Male", "F" = "Female", "U" = "Undesignated"))

wakevoterdemo$party_cd <- wakevoterdemo$party_cd %>%
  str_replace_all(c("UNA" = "Unaffiliated", "REP" = "Republican", "DEM" = "Democrat", 
                    "CST" = "Constitution", "LIB" = "Libertarian", "GRE" = "Green"))
#Oops! I should have typed the above in all caps. Make column data uppercase for uniformity
wakevoterdemo$party_cd <- toupper(wakevoterdemo$party_cd)
wakevoterdemo$gender_code <- toupper(wakevoterdemo$gender_code)

#Another way to replace coded data: use plyr::revalue()
race_codes <- c("A" = "ASIAN", "B" = "BLACK or AFRICAN AMERICAN", "I" = "AMERICAN INDIAN or ALASKA NATIVE", 
                "M" = "TWO or MORE RACES", "O" = "OTHER", "P" = "NATIVE HAWAIIAN or PACIFIC ISLANDER", 
                "U" = "UNDESIGNATED", "W" = "WHITE")
wakevoterdemo$race_code <- plyr::revalue(wakevoterdemo$race_code, race_codes)

#Do it in fewer steps
wakevoterdemo$ethnic_code <- plyr::revalue(wakevoterdemo$ethnic_code, c("NL" = "NOT HISPANIC or LATINO", 
                                                                  "HL" = "HISPANIC or LATINO", "UN" = "UNDESIGNATED"))

#Add a column dividing voters into age groups: $age_group
wakevoterdemo <- mutate(wakevoterdemo, age_group = ifelse(birth_age %in% 18:34, "18 to 34",
                                                          ifelse(birth_age %in% 35:54, "35 to 54",
                                                                 ifelse(birth_age %in% 55:74, "55 to 74", 
                                                                        "75 and up"))))
