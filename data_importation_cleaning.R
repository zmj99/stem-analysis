#########
# Zack Johnson
# Edited: 9/23/2020
# Bring in and clean stem data from python work
#########

#clear lists
rm(list = ls())

#load libraries
library(tidyverse)
library(plyr)

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
  dplyr::mutate(stem_dummy = ifelse(data$major %in% stem_majors, "Stem", "Not Stem")) %>%
  dplyr::mutate(stem_dummy = factor(stem_dummy, levels = c("Not Stem", "Stem"))) %>%
  dplyr::mutate(feelings_on_voter_importance = 
           factor(feelings_on_voter_importance, levels = 
                    c("Strongly disagree", "Somewhat disagree", 
                      "Neither agree nor disagree", "Somewhat agree", "Strongly Agree"))) %>%
  dplyr::mutate(STEM_representation_better_gov =
           factor(STEM_representation_better_gov, levels = 
                    c("Definitely not", "Probably not", 
                      "Might or might not", "Probably yes", 
                      "Definitely yes")))

save(data, file = "stemdata.RData")



#################################################################################################
#################################################################################################

#load other data
data2 <- read.csv("~/Poli Sci Data Project/STEM_Student_Voting2.csv", stringsAsFactors = T)
str(data2)
data2$hours_outside_class <- revalue(data2$hours_outside_class, c("10-May"="5-10", "15-Oct"="10-15"))

data2 <- data2[-255,]
data2 <- data2[!data2$X2018_vote == "Was not eligible",]



data2 <- data2 %>%
  dplyr::mutate(difficulty_comparison = ordered(difficulty_comparison, 
                                      levels = c("Far easier", "Moderately easier", "Slightly easier",
                                                  "Approximately average", "Slightly more difficult",
                                                 "Moderately more difficult", "Far more difficult"))) %>%
  dplyr::mutate(political_comm = factor(political_comm,
                                      levels = c("Frequently","Sometimes","Occasionally","Rarely"))) %>%
  dplyr::mutate(politics_lecture = factor(politics_lecture,
                                      levels = c("Frequently","Sometimes","Occasionally","Rarely"))) %>%
  dplyr::mutate(gov_importantce = factor(gov_importantce, 
                                      levels = c("Definitely not","Probably not","Might or might not",
                                                 "Probably yes","Definitely yes"))) %>%
  dplyr::mutate(stem_dummy = ifelse(data2$major %in% stem_majors, "Stem", "Not Stem")) %>%
  dplyr::mutate(stem_dummy = factor(stem_dummy, levels = c("Not Stem", "Stem"))) %>%
  dplyr::mutate(X2020_general = factor(X2020_general, levels = c("No", "Yes"))) %>%
  dplyr::mutate(X2018_vote = factor(X2018_vote, levels = c("No", "Yes")))

data2$X2020_general <- as.numeric(data2$X2020_general) - 1
data2$X2018_vote <- as.numeric(data2$X2018_vote) - 1
data2$political_comm <- as.numeric(data2$political_comm)
data2$politics_lecture <- as.numeric(data2$politics_lecture)
data2$stem_dummy <- as.numeric(data2$stem_dummy) - 1
data2$hours_outside_class <- as.numeric(data2$hours_outside_class)
data2$difficulty_comparison <- as.numeric(data2$difficulty_comparison)

data2_stem <- data2[data2$stem_dummy == 1,]

save(data2, file = "stemdata2.RData")

#################################################################################################
#################################################################################################

data_stem <- data[data$stem_dummy == "Stem",]

write.csv(data_stem, file = "~/Poli Sci Data Project/stem_student_voting_rproject/data_stem.csv")
levels(data_stem$given_turnout_explanation)

length(grep("The belief that mathematically speaking, any one individual vote doesn't matter", 
            data_stem$given_turnout_explanation))
length(grep("The belief that government and who is elected to it aren't important", 
            data_stem$given_turnout_explanation))
length(grep("Lack of time due to course load", 
            data_stem$given_turnout_explanation))
length(grep("Lack of discussion on these topics in classes", 
            data_stem$given_turnout_explanation))
