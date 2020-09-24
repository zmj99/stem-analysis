#########
# Zack Johnson
# Edited: 9/23/2020
# Bring in and clean stem data from python work
#########

#load libraries
library(tidyverse)

#load data
data <- read.csv("~/Poli Sci Data Project/STEM_Student_Voting.csv", stringsAsFactors = T)
str(data)

stem_majors <- c("A E", "A ECL", "ACSCI", "AER E", "AGRON", 
                 "AN S", "AST", "BIOCH", "BIOL", "C E", "CHEM", 
                 "CPR E", "COM S", "CH E", "CCE E", "CON E", "CUFSH", 
                 "CYB E", "D EX", "DIETA", "DS", "DY S", "E E", 
                 "ENGR","ENSCS", "GEN", "GEOL", "GLOBE", "HORT",
                 "I E", "I TEC", "KIN", "MATH", "MICR", "MTEOR", 
                 "NS A", "MAT E", "M E", "P IND", "STAT", "S E", "PHYS")

#create stem dummy and order the ordered variables correctly
data <- data %>%
  mutate(stem_dummy = ifelse(data$major %in% stem_majors, "Stem", "Not Stem")) %>%
  mutate(stem_dummy = factor(stem_dummy, levels = c("Stem", "Not Stem"))) %>%
  mutate(feelings_on_voter_importance = 
           factor(feelings_on_voter_importance, levels = 
                    c("Strongly disagree", "Somewhat disagree", 
                      "Neither agree nor disagree", "Somewhat agree", "Strongly Agree"))) %>%
  mutate(STEM_representation_better_gov =
           factor(STEM_representation_better_gov, levels = 
                    c("Definitely not", "Probably not", 
                      "Might or might not", "Probably yes", 
                      "Definitely yes")))

save(data, file = "~/Poli Sci Data Project/stem_student_voting_rproject/stemdata.RData")

