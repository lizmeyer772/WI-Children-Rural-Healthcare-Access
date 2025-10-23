#Statistical Inference
#Elizabeth Meyer

rm(list=ls())
library(readxl)
library(dplyr)
CHR<-read_excel("/Users/lizmeyer/Desktop/Project/CountyHealthNew.xlsx")

#Subsets to counties with RUCC codes 4-9
CHRRur <- subset(CHR, RUCC %in% c(4, 5, 6, 7, 8, 9))


#Ranks counties individually and then creates a combined rank variable
HighNeedCounties <- CHRRur %>%
  filter(RUCC %in% c(4, 5, 6, 7, 8, 9)) %>%
  mutate(MHPRank = rank(`# Mental Health Providers`, ties.method = "min"),
         ChildPovRank = rank(`% Children in Poverty`, ties.method = "min"),
         SPRank = rank(`% Children in Single-Parent Households`, 
                       ties.method = "min")) %>%
  mutate(CombinedRank = MHPRank + ChildPovRank + SPRank) %>%
  arrange(CombinedRank) %>%
  select(County, `# Mental Health Providers`, `% Children in Poverty`,
         `% Children in Single-Parent Households`, `% Less than 18 Years of Age`,
         CombinedRank, RUCC) %>%
  slice_head(n = 20)

#Table
HighNeedCounties
