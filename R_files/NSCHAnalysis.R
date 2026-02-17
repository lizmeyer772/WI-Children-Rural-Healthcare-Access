rm(list=ls())
library(tidyverse)
NSCH<-read.csv("/Users/lizmeyer/Desktop/Project/NSCH.csv")

#Subsets to Wisconsin only
NSCHWI <- subset(NSCH, FIPSST == 55)


#Has a MEDB Problem vs Not (WI)
NSCHWI$MEDB10ScrQ5_22

NSCHWI$NewMEDB <- ifelse(NSCHWI$MEDB10ScrQ5_22 == 95, NA, NSCHWI$MEDB10ScrQ5_22)
NSCHWI <- NSCHWI[!is.na(NSCHWI$NewMEDB), ]
  
NSCHWI$NewMEDB

MEDBTable <- table(NSCHWI$NewMEDB)
MEDBTable <- prop.table(MEDBTable) * 100
rownames(MEDBTable) = c("MEDB Problem", "No MEDB Problem")
MEDBTable

#Urban vs Rural (WI)
NSCHWI$METRO_YN

NSCHWI$NewMetro <- NSCHWI$METRO_YN

UrbRurTable <- table(NSCHWI$NewMetro)
UrbRurTable <- prop.table(UrbRurTable) * 100
rownames(UrbRurTable) = c("Urban", "Rural")
UrbRurTable

#Received MHC vs Not (WI)
NSCHWI$MentHCare_22

NSCHWI$NewMentHCare <- ifelse(NSCHWI$MentHCare_22 == 99, NA, NSCHWI$MentHCare_22)
#Combines all "No because ___" to just one "No" value
NSCHWI$NewMentHCare <- ifelse(NSCHWI$NewMentHCare == 3, 2, NSCHWI$NewMentHCare)
NSCHWI <- NSCHWI[!is.na(NSCHWI$NewMentHCare), ]

NSCHWI$NewMentHCare

MHCTable <- table(NSCHWI$NewMentHCare)
MHCTable <- prop.table(MHCTable) * 100
rownames(MHCTable) = c("Received MH Care", "Did Not Receive MH Care")
MHCTable


#MEDB Problem w/ Urban/Rural Status (WI)
MEBDURTable <- table(NSCHWI$NewMetro, NSCHWI$NewMEDB)
MEBDURTableFreq <- table(NSCHWI$NewMetro, NSCHWI$NewMEDB)
MEBDURTable <- prop.table(MEBDURTable) * 100
rownames(MEBDURTable) = c("Urban", "Rural")
colnames(MEBDURTable) = c("MEBD Problem", "No MEBD Problem")
rownames(MEBDURTableFreq) = c("Urban", "Rural")
colnames(MEBDURTableFreq) = c("MEBD Problem", "No MEBD Problem")
MEBDURTable
MEBDURTableFreq


USMEBDURTable <- table(NSCH$NewMetro, NSCH$NewMEDB)
USMEBDURTableFreq <- table(NSCH$NewMetro, NSCH$NewMEDB)
USMEBDURTable <- prop.table(USMEBDURTable) * 100
rownames(USMEBDURTable) = c("Urban", "Rural")
colnames(USMEBDURTable) = c("MEBD Problem", "No MEBD Problem")
rownames(USMEBDURTableFreq) = c("Urban", "Rural")
colnames(USMEBDURTableFreq) = c("MEBD Problem", "No MEBD Problem")
USMEBDURTable
USMEBDURTableFreq


#Viz
#Received MHC w/ Urban/Rural Status (WI)
URMHCTable <- table(NSCHWI$NewMetro, NSCHWI$NewMentHCare)
URMHCTableFreq <- table(NSCHWI$NewMetro, NSCHWI$NewMentHCare)
URMHCTable <- prop.table(URMHCTable) * 100
rownames(URMHCTable) = c("Urban", "Rural")
colnames(URMHCTable) = c("Received MH Care", "Did Not Receive MH Care")
rownames(URMHCTableFreq) = c("Urban", "Rural")
colnames(URMHCTableFreq) = c("Received MH Care", "Did Not Receive MH Care")
URMHCTable
URMHCTableFreq
#Quick math for below table
64 + 14
64/78
14/78

#Table that looks at the percentage of urban/rural children who received MHC
RecMHCTable <- matrix(c(82.05128, 17.94872), nrow = 1)
colnames(RecMHCTable) <- c("Urban", "Rural")
rownames(RecMHCTable) <- c("Received MHC")
RecMHCTable

#Converts the table to a dataframe so it works easier with ggplot2
RecMHCTableDF <- as.data.frame(RecMHCTable)
RecMHCTableDF <- pivot_longer(RecMHCTableDF, cols = everything(),
                              names_to = "Area", values_to = "Percentage")
RecMHCTableDF$Area <- factor(RecMHCTableDF$Area, levels = c("Urban", "Rural"))

#Viz
ggplot(RecMHCTableDF, aes(x = Area, y = Percentage, fill = Area)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c('navyblue', 'firebrick')) +
  labs(title = "Urban vs. Rural: Wisconsin Children's\n Mental Health Services Usage",
       x = "Area",
       y = "WI Children\nReceiving\n MH Services\nin 2022 (%)") +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, by = 20)) +
  theme_minimal(base_size = 15) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title.y = element_text(angle = 0, hjust = 0.5, vjust = 0.5))

ggsave("test.png", width = 8, height = 7, dpi = 300, bg="white")




