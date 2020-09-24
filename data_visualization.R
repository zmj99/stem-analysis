#########
# Zack Johnson
# Edited: 9/24/2020
# Do some plotting of the stem voting stuff
#########

load("~/Poli Sci Data Project/stem_student_voting_rproject/stemdata.RData")

ggplot(data = data, aes(x = STEM_representation_better_gov, color = stem_dummy)) + 
  geom_bar(stat = "count", position = "fill")

ggplot(data = data, aes(x = STEM_representation_better_gov, color = stem_dummy)) + 
  geom_bar(stat = "count", position = "stack") +
  facet_wrap(~stem_dummy)

ggplot(data = data, aes(x = feelings_on_voter_importance, color = stem_dummy)) + 
  geom_bar(stat = "count", position = "fill")

ggplot(data = data, aes(x = feelings_on_voter_importance, color = stem_dummy)) + 
  geom_bar(stat = "count", position = "stack") +
  facet_wrap(~stem_dummy)

