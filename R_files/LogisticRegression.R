#Logistic Regression
#Elizabeth Meyer

rm(list=ls())
library(caret)
library(pROC)
source("/Users/lizmeyer/Desktop/Project/NSCHVars.R")

Model1 <- glm(RecMHC ~ Ins + InsTypes + CGEmploy + Family + FPL + Sex + Race
              + Age + Aces, family = binomial(link = logit), data = FinalRural)
summary(Model1)


Model2 <- glm(RecMHC ~ Age + CGEmploy + Aces + FPL + Family,
              family = binomial(link = logit), data = FinalRural)
summary(Model2)


Model3 <- glm(RecMHC ~ Aces + Family * FPL + Ins,
              family = binomial(link = logit), data = FinalRural)
summary(Model3)


#Cross Validation
Control <- trainControl(method = "cv", number = 4)

CVModel1 <- train(RecMHC ~ Ins + InsTypes + CGEmploy + Family + FPL + Sex + Race
                  + Age + Aces, data = FinalRural,
                  trControl = Control,
                  method = "glm",
                  family = binomial (link = logit),
                  metric = "Accuracy")
CVModel1

CVModel2 <- train(RecMHC ~ Age + CGEmploy + Aces + FPL + Family,
                  data = FinalRural,
                  trControl = Control,
                  method = "glm",
                  family = binomial (link = logit),
                  metric = "Accuracy")
CVModel2


CVModel3 <- train(RecMHC ~ Aces + Family * FPL + Ins,
                  data = FinalRural,
                  trControl = Control,
                  method = "glm",
                  family = binomial (link = logit),
                  metric = "Accuracy")
CVModel3


phatModel1 <- predict(Model1)
phatModel2 <- predict(Model2)
phatModel3 <- predict(Model3)

yhatModel1 <- ifelse(phatModel1 >= 0.5, 1, 0)
yhatModel2 <- ifelse(phatModel2 >= 0.5, 1, 0)
yhatModel3 <- ifelse(phatModel3 >= 0.5, 1, 0)

AccRate1 <- 100*mean(FinalRural$RecMHC == yhatModel1)
AccRate2 <- 100*mean(FinalRural$RecMHC == yhatModel2)
AccRate3 <- 100*mean(FinalRural$RecMHC == yhatModel3)

roc1 <- roc(FinalRural$RecMHC, phatModel1)
roc2 <- roc(FinalRural$RecMHC, phatModel2)
roc3 <- roc(FinalRural$RecMHC, phatModel3)

auc(roc1)
auc(roc2)
auc(roc3)



