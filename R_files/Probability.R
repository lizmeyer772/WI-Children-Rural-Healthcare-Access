#Probability
#Elizabeth Meyer

rm(list=ls())
source("/Users/lizmeyer/Desktop/Project/NSCHVars.R")

#Sum of 2+ Aces
TwoAces <- sum(FinalRural$Aces == 2)

#Sum of Below Poverty Line
BelowFPL <- sum(FinalRural$FPL == 1)

#Sum of 2+ Aces AND Below Poverty Line
TwoAcesBelowFPL <- sum(FinalRural$Aces == 2 & FinalRural$FPL == 1)

#N
Total <- nrow(FinalRural)

#Proportion of 2+ Aces
PropAces <- (TwoAces / Total)

#Proportion of Below Poverty Line
PropFPL <- (BelowFPL / Total)

#Proportion of 2+ Aces AND Below Poverty Line
PropAcesFPL <- TwoAcesBelowFPL / Total

#Probability of 2+ Aces GIVEN Below Poverty Line
CondProb <- PropAcesFPL / PropFPL
CondProb
