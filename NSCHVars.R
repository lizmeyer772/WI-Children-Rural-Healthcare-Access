#NSCH Dataset
#Elizabeth Meyer

rm(list=ls())
library(tidyverse)
NSCH<-read.csv("/Users/lizmeyer/Desktop/Project/NSCH.csv")

#Has an MEDB (1 = Has MEDB, 2 = Does not have MEDB)
NSCH$MEDB <- ifelse(NSCH$MEDB10ScrQ5_22 == 95, NA, NSCH$MEDB10ScrQ5_22)
NSCH <- NSCH[!is.na(NSCH$MEDB), ]

#Urban/Rural Area (1 = Urban, 2 = Rural)
NSCH$Metro <- ifelse(NSCH$METRO_YN == 96, NA, NSCH$METRO_YN)
NSCH <- NSCH[!is.na(NSCH$Metro),]

#Subsets to only children with an MEDB
NSCHUS <- subset(NSCH, MEDB == 1)

#Health insurance status (1 = Insured, 2 = Uninsured)
NSCHUS$Ins <- ifelse(NSCHUS$CurrIns_22 == 99, NA, NSCHUS$CurrIns_22)
NSCHUS <- NSCHUS[!is.na(NSCHUS$Ins),]

#Type of health insurance (1 = Public, 2 = Private, 3 = Both, 4 = Uninsured)
NSCHUS$InsTypes <- ifelse(NSCHUS$instype_22 == 99, NA, NSCHUS$instype_22)
NSCHUS <- NSCHUS[!is.na(NSCHUS$InsTypes),]

#Caregiver (CG) employment status (1 = at least 1 CG employed full-time,
# 2 = at least 1 CG employed part-time, 3 = CG(s) unemployed)
NSCHUS$CGEmploy <- ifelse(NSCHUS$EmploymentSt_22 == 99, NA, NSCHUS$EmploymentSt_22)
NSCHUS <- NSCHUS[!is.na(NSCHUS$CGEmploy),]

#Family structure (1 = 2 married parents, 2 = 2 unmarried parents, 3 = single parent,
# 4 = Grandparent, 5 = Other)
NSCHUS$Family <- ifelse(NSCHUS$famstruct5_22 == 99, NA, NSCHUS$famstruct5_22)
NSCHUS <- NSCHUS[!is.na(NSCHUS$Family),]

#Federal poverty level (FPL) (1 = 0-99% FPL, 2 = 100-199% FPL, 3 = 200-399% FPL,
# 4 = 400% FPL or greater)
NSCHUS$FPL <- NSCHUS$povlev4_22

#Sex of child (1 = Male, 2 = Female)
NSCHUS$Sex <- NSCHUS$sex_22

#Race/ethnicity of child (1 = Hispanic, 2 = White, 3 = Black, 4 = Asian,
# 5 = American Indian/Alaska, 6 = Native Hawaiian and Other PI, 7 = Multi-Race)
NSCHUS$Race <- NSCHUS$race7_22

#Age group of child (1 = 0-5, 2 = 6-11, 3 = 12-17)
NSCHUS$Age <- NSCHUS$age3_22

#Adverse Childhood Experiences (ACEs) (1 = None, 2 = 1 ACE, 3 = 2 or more ACEs)
NSCHUS$Aces <- ifelse(NSCHUS$ACE2more11_22 == 99, NA, NSCHUS$ACE2more11_22)
NSCHUS <- NSCHUS[!is.na(NSCHUS$Aces),]


#Received Mental Health Care in the past 12 months (0 = No, 1 = Yes)
NSCHUS$RecMHC <- ifelse(NSCHUS$MentHCare_22 == 99, NA,
                        ifelse(NSCHUS$MentHCare_22 == 3, 2, NSCHUS$MentHCare_22))
NSCHUS <- NSCHUS[!is.na(NSCHUS$RecMHC),]
#Recodes the outcome variable
NSCHUS$RecMHC <-ifelse(NSCHUS$MentHCare_22 == 2, 0, 1)


#Final datasets I will be using

#For all children with a MEDB problem
FinalAll <- NSCHUS %>%
  subset(MEDB == 1) %>%
  select(Ins, InsTypes, CGEmploy, Family, FPL, Sex, Race, Age, Aces, Metro, MEDB, RecMHC)

FinalAll <- FinalAll %>%
  mutate_if(is.numeric, factor)

#Changes ref. categories
FinalAll$FPL <- relevel(FinalAll$FPL, ref = "3")
FinalAll$Race <- relevel(FinalAll$Race, ref = "2")

#For all children with a MEDB problem AND who are rural
FinalRural <- NSCHUS %>%
  subset(Metro == 2 & MEDB == 1) %>%
  select(Ins, InsTypes, CGEmploy, Family, FPL, Sex, Race, Age, Aces, Metro, MEDB, RecMHC)

FinalRural <- FinalRural %>%
  mutate_if(is.numeric, factor)

#Changes ref. categories
FinalRural$FPL <- relevel(FinalRural$FPL, ref = "3")
FinalRural$Race <- relevel(FinalRural$Race, ref = "2")





