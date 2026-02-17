#Hypothesis Testing
#Elizabeth Meyer

rm(list=ls())
library(readxl)
library(tidyverse)
library(ggplot2)
CHR <- read_excel("/Users/lizmeyer/Desktop/Project/CountyHealthNew.xlsx")

#Subsets to counties with RUCC codes 4-9
CHRRur <- subset(CHR, RUCC %in% c(4, 5, 6, 7, 8, 9))

#Median value of child poverty rate across 45 WI counties
median(CHRRur$`% Children in Poverty`)

#Codes child poverty rate into 2 groups
CHRRur$Poverty <- ifelse(CHRRur$`% Children in Poverty` < 15.8, "Below", "Above")

#T-test
TTest1 <- t.test(`# Mental Health Providers` ~ `Poverty`, data = CHRRur, alternative = "less")
TTest1

Corr1 <- cor.test(CHRRur$`# Mental Health Providers`, CHRRur$`% Children in Poverty`, alternative = "less")
Corr1

#Log-transforms child poverty rate for better viz
CHRRur$PovertyLog <- log(CHRRur$`% Children in Poverty`)

#Viz
ggplot(CHRRur, aes(x = PovertyLog, y = `# Mental Health Providers`)) +
  geom_point(color = "maroon", size = 2.5) +
  labs(title = "Relationship between % Children in Poverty and # of Mental Health Providers",
    x = "% Children in Poverty", 
    y = "# Mental\nHealth\nProviders") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title.y = element_text(angle = 0, hjust = 0.5, vjust = 0.5))




      





