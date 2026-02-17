#Marquette University
#Liz Meyer
#COSC 6510
#Data Visualization for Lightning Presentation

#Clears working directory and reads in dataset
rm(list=ls())
data<-read.csv("/Users/lizmeyer/Desktop/Project/NSCH.csv")

#Installs needed libraries
library('ggplot2')
library('tidyr')

#Changes irrelevant values in MentHCare_22 to NA and combines the 2 and 3 values into just one value - 2 (No)
data$newMentHCare_22 <- ifelse(data$MentHCare_22 %in% c(99, 95), NA, data$MentHCare_22)
data$newMentHCare_22 <- ifelse(data$newMentHCare_22 == 3, 2, data$newMentHCare_22)

#Removes all NA values
newdata <- data[!is.na(data$newMentHCare_22), ]
newdata$newMentHCare_22

#Same process above for MetroYN
newdata$newMETRO_YN <- ifelse(newdata$METRO_YN == 96, NA, newdata$METRO_YN)
newdata$newMETRO_YN
newdata <- newdata[!is.na(newdata$newMETRO_YN), ]


#My original proportion table
mytable <- table(newdata$newMETRO_YN, newdata$newMentHCare_22)
mytable <- prop.table(mytable)
rownames(mytable) = c("Urban", "Rural")
colnames(mytable) = c("Received MH Care", "Did Not Receive MH Care")
mytable

#My new table that only looks at if children received MHC
mynewtable <- matrix(c(0.11846154, 0.02224664), nrow = 1)
colnames(mynewtable) <- c("Urban", "Rural")
mynewtable <- mynewtable * 100
mynewtable

#Converts the table to a dataframe so it works easier with ggplot2
mynewtable_df <- as.data.frame(mynewtable)
mynewtable_df <- pivot_longer(mynewtable_df, cols = everything(), names_to = "Area", values_to = "Percentage")
mynewtable_df$Area <- factor(mynewtable_df$Area, levels = c("Urban", "Rural"))

#Final visualization
ggplot(mynewtable_df, aes(x = Area, y = Percentage, fill = Area)) +
  geom_bar(stat = "identity", width = 0.9) +
  scale_fill_manual(values = c('navyblue', 'firebrick')) +
  labs(title = "Children's Access to Mental Healthcare",
       x = "Area",
       y = "Children who Received MHC in the Last Year (%)") +
  expand_limits(y = c(0, 20)) +
  theme_minimal(base_size = 15)

