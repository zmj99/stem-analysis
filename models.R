#Load libraries for logistic regression, output creator, and text mining
library(broom)
library(tidyverse)
library(stargazer)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

#Load in data from cleaning script
load("~/Poli Sci Data Project/stem_student_voting_rproject/stemdata.RData")
load("~/Poli Sci Data Project/stem_student_voting_rproject/stemdata2.RData")

###################
# Logit Model Code #
###################
stemglm1 <- glm(formula = 
                X2018_vote ~ 
                class_difficulty + difficulty_comparison + politics_lecture +
                hours_outside_class + political_comm + stem_dummy, 
                data = data2, family = binomial)
summary(stemglm1)

stemglm2 <- glm(formula = 
                X2018_vote ~
                political_comm + difficulty_comparison + stem_dummy,
                data = data2, family = binomial)
summary(stemglm2)

stemglm3 <- glm(formula = 
                X2018_vote ~
                class_difficulty + politics_lecture + hours_outside_class +
                stem_dummy,
                data = data2, family = binomial)
summary(stemglm3)

stemglm1.2020 <- glm(formula = 
                  X2020_general ~ 
                  class_difficulty + difficulty_comparison + politics_lecture +
                  hours_outside_class + political_comm + stem_dummy, 
                data = data2, family = binomial)
summary(stemglm1.2020)

stemglm2.2020 <- glm(formula = 
                  X2020_general ~
                  political_comm + difficulty_comparison + stem_dummy,
                data = data2, family = binomial)
summary(stemglm2.2020)

stemglm3.2020 <- glm(formula = 
                  X2020_general ~
                  class_difficulty + politics_lecture + hours_outside_class +
                  stem_dummy,
                data = data2, family = binomial)
summary(stemglm3.2020)

#Create Regression Output with Stargazer
stargazer(stemglm1, stemglm2, stemglm3, title="2018 Vote Status", align=TRUE,
          type = "html", 
          out = "~/Poli Sci Data Project/stem_student_voting_rproject/regression_output.html",
          dep.var.labels = "Vote Status in 2018")

stargazer(stemglm1.2020, stemglm2.2020, stemglm3.2020, title="2020 Vote Intention", align=TRUE,
          type = "html", 
          out = "~/Poli Sci Data Project/stem_student_voting_rproject/regression_output2.html",
          dep.var.labels = "Whether the Respondent Anticipates They eill be Voting in the 2020 General",
          header = T)

##################
# Word Cloud Code #
##################
text <- readLines("~/Poli Sci Data Project/stem_student_voting_rproject/free_response_stem.txt")

docs <- Corpus(VectorSource(text))

inspect(docs)

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

