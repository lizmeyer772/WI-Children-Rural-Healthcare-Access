rm(list=ls())
library("tidyverse")
library("readxl")

#Wisconsin Population Age Dataset
PopAge<-read.csv("/Users/lizmeyer/Desktop/Project/WisconsinPopAge.csv")

#Subsets the data so analysis is focused on the year 2023
PopAge2023 <- subset(PopAge, YEAR == 5)

#Combines the under 5 population, ages 5-13 population, and ages 14-17 population
#into one under 18 population variable
PopAge2023$PopUnder18 <- rowSums(PopAge2023[, c("UNDER5_TOT", "AGE513_TOT",
                                                "AGE1417_TOT")])

#Percentage of population under 18
PopAge2023$PopUnder18Perc <- (PopAge2023$PopUnder18 / PopAge2023$POPESTIMATE) * 100
#add rounding?
  
#Table of under 18 population by county name
MyTable <- aggregate(PopUnder18 ~ CTYNAME, data = PopAge2023, FUN = sum)

#Rural-Urban Continuum Codes Dataset
RUCC <- read_excel("/Users/lizmeyer/Desktop/Project/RUCC.xlsx")

#Subsets RUCC county codes to Wisconsin counties only
WIRUCC <- subset(RUCC, State == "WI")


#County Health Rankings Dataset
CountyHealth1 <- read_excel("/Users/lizmeyer/Desktop/Project/CountyHealth.xlsx",
                            sheet = "Select Measure Data")
CountyHealth2 <- read_excel("/Users/lizmeyer/Desktop/Project/CountyHealth.xlsx",
                            sheet = "Additional Measure Data")

#CountyHealth1 = Mental Health Providers, Primary Care Physicians?,
#Children in Poverty, Children in Single-Parent Households?

#CountyHealth2 = Uninsured Children, Median Household Income?

#Social Determinants of Health Dataset
SDOH <- read.csv("/Users/lizmeyer/Desktop/Project/SDOH.csv")

#Subsets the data so Wisconsin counties only
SDOHWI <- subset(SDOH, StateAbbr == "WI")

Measures <- unique(SDOHWI$Measure) 
Measures

NSCH <- read.csv("/Users/lizmeyer/Desktop/Project/NSCH.csv")

NSCHWI <- subset(NSCH, FIPSST == 55)

