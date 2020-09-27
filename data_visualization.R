#########
# Zack Johnson
# Edited: 9/24/2020
# Do some plotting of the stem voting stuff
#########

load("~/Poli Sci Data Project/stem_student_voting_rproject/stemdata.RData")
load("~/Poli Sci Data Project/stem_student_voting_rproject/stemdata2.RData")

ggplot(data = data, aes(x = STEM_representation_better_gov, color = stem_dummy)) + 
  geom_bar(stat = "count", position = "fill") +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8))

ggplot(data = data, aes(x = stem_dummy, color = STEM_representation_better_gov)) + 
  geom_bar(stat = "count", position = "fill")+
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8))

ggplot(data = data, aes(x = feelings_on_voter_importance, color = stem_dummy)) + 
  geom_bar(stat = "count", position = "fill")+
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8))

ggplot(data = data, aes(x = stem_dummy, color = feelings_on_voter_importance, 
                        stat = "prop")) +
  geom_bar(position = "fill") +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8))

ggplot(data = data2, aes(x = class_difficulty)) +
  geom_bar() +
  facet_grid(~stem_dummy)
t.test(data2$class_difficulty[data2$stem_dummy == 0],data2$class_difficulty[data2$stem_dummy == 1])  
  
ggplot(data = data2, aes(x = difficulty_comparison)) +
  geom_bar() +
  facet_grid(~stem_dummy)
t.test(data2$difficulty_comparison[data2$stem_dummy == 0], data2$difficulty_comparison[data2$stem_dummy == 1])  
  