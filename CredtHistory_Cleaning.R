library(dplyr)

#--------Loading the dataset------#

setwd("F:\\E-learn\\Jigsaw\\EDA\\T1\\T1. Data Preprocessing - Data Exploration - code snippets")

cr<-read.csv("Credit.csv",na.strings=c("",NA))

#--------Exploring Data to gain knowledge about it------#


#first thing is to understand dimesnions of the dataset, variables & dataset level summaries

dim(cr)

names(cr)
#There are two columns which seem like duplicates of two other colums. 
#On further inspection of those two variables it is clear that they are infact duplicate columns.

#Since they are two duplicate colums, we need to remove them first, as thery are not adding any extra value to the analysis.

cr=cr[,-c(1,12)]
dim(cr) #no.of colums have been reduced to 16 from 18
names(cr)


summary(cr) #Gives us dataset level summary and shows no.of missing values in each variable

#Almost all the variables have missing values. 2 variables have thousands of them, while remaining have less than 10
#since the data has over a lakh of observations, we can afford to remove the mising value observations from variables with less than 10 missing values

index=which(is.na(cr$age))
cr=cr[-index,] #two observations have been removed

#the above two steps can be repeated for other variables as well


summary(cr)

#I can observe few variables with unexpected values. Let's study them individually to understand more

#-------Handling Anomalies-------#

summary(cr$RevolvingUtilizationOfUnsecuredLines) #Ratio variable

cr%>%filter(RevolvingUtilizationOfUnsecuredLines==0)%>%nrow()

cr%>%filter(RevolvingUtilizationOfUnsecuredLines>=0.99)%>%nrow()

#Quite a few numbers more than 0.99, need to discuss with domain expert for more details on this

#Percentile breakup

quantile(cr$RevolvingUtilizationOfUnsecuredLines,p=c(1:100)/100)


#Assuming 2 can be the maximum limit, we can either drop these observations which are more than 2
#Or cap the variable with max. as 2
#In this case I am opting for the first option

cr%>%filter(RevolvingUtilizationOfUnsecuredLines<=2)%>%nrow()

cr%>%filter(RevolvingUtilizationOfUnsecuredLines<=2)->cr

dim(cr)

summary(cr$age) #it's unlikely that one can have a credit card and his/her age is 0

head(arrange(cr,age))

quantile(cr$age,p=c(1:100)/100)

cr%>%filter(age!=0)->cr #removed the observation where age is 0


summary(cr$Gender)
summary(cr$Region)

summary(cr$MonthlyIncome) #MonthlyIncome varibale has 0 values, can be checked with the domain expert for more details

cr%>%filter(MonthlyIncome==0)%>%nrow()

#Assumming that they are missing values

#Replacing 0s with NAs

cr$MonthlyIncome=ifelse(cr$MonthlyIncome==0,NA,cr$MonthlyIncome)

quantile(cr$MonthlyIncome,p=c(1:100)/100,na.rm = TRUE) #Usine na.rm=TRUE as there are null variables

cr%>%filter(MonthlyIncome>25000)%>%nrow() #Checking how many values are more than 25000 as the maximum seems very high


summary(cr$Rented_OwnHouse)

summary(cr$Occupation)
summary(cr$Education)

summary(cr$NumberOfTime30.59DaysPastDueNotWorse) #There are a few observations with very high values

quantile(cr$NumberOfTime30.59DaysPastDueNotWorse,p=c(1:100)/100)

cr%>%filter(NumberOfTime30.59DaysPastDueNotWorse>90)%>%nrow()

quantile(cr$NumberOfTime30.59DaysPastDueNotWorse,p=c(990:1000)/1000,na.rm=TRUE)


# Assuming large numbers are missing values

cr$NumberOfTime30.59DaysPastDueNotWorse<-ifelse(cr$NumberOfTime30.59DaysPastDueNotWorse==98,NA,cr$NumberOfTime30.59DaysPastDueNotWorse)

cr$NumberOfTime30.59DaysPastDueNotWorse<-ifelse(cr$NumberOfTime30.59DaysPastDueNotWorse==96,NA,cr$NumberOfTime30.59DaysPastDueNotWorse)


summary(cr$DebtRatio) #There are extremely large values being a Ratio not expected, let's explore more


cr%>%filter(DebtRatio>1)%>%nrow()
cr%>%filter(DebtRatio==0)%>%nrow()

quantile(cr$DebtRatio,p=c(1:100)/100,na.rm=TRUE)

#Cap at 2

cr$DebtRatio=ifelse(cr$DebtRatio>2,2,cr$DebtRatio)


summary(cr$NumberOfOpenCreditLinesAndLoans)

quantile(cr$NumberOfOpenCreditLinesAndLoans,p=c(1:100)/100,na.rm=TRUE)

#Higher magnitude numbers represent missing value

cr$NumberOfOpenCreditLinesAndLoans<-ifelse(cr$NumberOfOpenCreditLinesAndLoans==58,NA,cr$NumberOfOpenCreditLinesAndLoans)

cr$NumberOfOpenCreditLinesAndLoans<-ifelse(cr$NumberOfOpenCreditLinesAndLoans==57,NA,cr$NumberOfOpenCreditLinesAndLoans)

cr$NumberOfOpenCreditLinesAndLoans<-ifelse(cr$NumberOfOpenCreditLinesAndLoans==56,NA,cr$NumberOfOpenCreditLinesAndLoans)

cr$NumberOfOpenCreditLinesAndLoans<-ifelse(cr$NumberOfOpenCreditLinesAndLoans==54,NA,cr$NumberOfOpenCreditLinesAndLoans)

cr$NumberOfOpenCreditLinesAndLoans<-ifelse(cr$NumberOfOpenCreditLinesAndLoans>24,NA,cr$NumberOfOpenCreditLinesAndLoans)

summary(cr$NumberOfTimes90DaysLate)

quantile(cr$NumberOfTimes90DaysLate,p=c(1:100)/100)

quantile(cr$NumberOfTimes90DaysLate,p=c(990:1000)/1000,na.rm=TRUE)

#Higher numbers represent missing value

cr$NumberOfTimes90DaysLate<-ifelse(cr$NumberOfTimes90DaysLate==98,NA,cr$NumberOfTimes90DaysLate)

cr$NumberOfTimes90DaysLate<-ifelse(cr$NumberOfTimes90DaysLate==96,NA,cr$NumberOfTimes90DaysLate)

summary(cr$NumberRealEstateLoansOrLines)

quantile(cr$NumberRealEstateLoansOrLines,p=c(1:100)/100)

quantile(cr$NumberRealEstateLoansOrLines,p=c(990:1000)/1000,na.rm=TRUE)

cr%>%filter(NumberRealEstateLoansOrLines==54)%>%nrow()

cr$NumberRealEstateLoansOrLines<-ifelse(cr$NumberRealEstateLoansOrLines==54,NA,cr$NumberRealEstateLoansOrLines)

cr$NumberRealEstateLoansOrLines<-ifelse(cr$NumberRealEstateLoansOrLines==32,NA,cr$NumberRealEstateLoansOrLines)

cr$NumberRealEstateLoansOrLines<-ifelse(cr$NumberRealEstateLoansOrLines>9,NA,cr$NumberRealEstateLoansOrLines)

summary(cr$NumberOfTime60.89DaysPastDueNotWorse)

quantile(cr$NumberOfTime60.89DaysPastDueNotWorse,p=c(1:100)/100,na.rm=TRUE)

cr$NumberOfTime60.89DaysPastDueNotWorse<-ifelse(cr$NumberOfTime60.89DaysPastDueNotWorse==98,NA,cr$NumberOfTime60.89DaysPastDueNotWorse)

cr$NumberOfTime60.89DaysPastDueNotWorse<-ifelse(cr$NumberOfTime60.89DaysPastDueNotWorse==96,NA,cr$NumberOfTime60.89DaysPastDueNotWorse)


summary(cr$NumberOfDependents)
str(cr$NumberOfDependents)

unique(cr$NumberOfDependents)

cr$NumberOfDependents=as.character(cr$NumberOfDependents) #It has to be a charcter variable not factor variable

#------Missing Value Treatment------#

##Approach towards missing value treatment and data binning

summary(cr)

## See the behaviour of dv wrt the idv which has missing values to arrive  at a missing value imputation


#NumberOfTime30.59DaysPastDueNotWorse
(table1=table(cr$NumberOfTime30.59DaysPastDueNotWorse,cr$Good_Bad))

(bad_rate=table1[,1]/rowSums(table1))

ind2=which(is.na(cr$NumberOfTime30.59DaysPastDueNotWorse))

(table2=table(cr$Good_Bad[ind2]))
(table2=table(cr$Good_Bad[ind2])/length(ind2))

#If we closely observe the output of the code from lines 189 & 194, we can figure out that these missing values can be 6

cr$NumberOfTime30.59DaysPastDueNotWorse[ind2]=6

summary(cr$NumberOfTime30.59DaysPastDueNotWorse)


##Divide into deciles and see the event rate

cr%>%quantile(cr$MonthlyIncome,10,na.rm = TRUE)
cr%>%mutate(quantile=ntile(MonthlyIncome,10))%>%group_by(Good_Bad,quantile)%>%summarize(N=n())%>%filter(Good_Bad=="Bad")->dat

cr%>%mutate(quantile=ntile(MonthlyIncome,10))%>%group_by(quantile)%>%summarize(N=n())->dat1

dat$Percentage<-dat$N/dat1$N

#Replace with values in 8th quantile
#What is 8th quantile?
quantile(cr$MonthlyIncome,p=(0:10)/10,na.rm=T)
(7536.9+9154.6)/2

cr$MonthlyIncome[is.na(cr$MonthlyIncome)]<-8345.75
summary(cr$MonthlyIncome)

##Data Prepration requires binnig data and then collapsing the number of bins
#Age variable

cr%>%mutate(Quantile=ntile(age,10))%>%group_by(Good_Bad,Quantile)%>%summarize(N=n())%>%filter(Good_Bad=="Bad")->dat2

cr%>%mutate(Quantile=ntile(age,10))%>%group_by(Quantile)%>%summarize(N=n())->dat3

dat2$Percent<-dat2$N/dat3$N

quantile(cr$age,p=(0:10)/100,na.rm=T)

##Partitioning data##
set.seed(100)
indexP<-sample(1:nrow(cr),0.70*nrow(cr),replace = F)
train_cr<-cr[indexP,]
test_cr<-cr[-indexP,]

##Be cautious of balanced and unbalanced samples
#Use caret() 

library(caret)
indexPC<-createDataPartition(y=cr$Good_Bad,times = 1,p=0.70,list=F)
train_crC<-cr[indexPC,]
test_crC<-cr[-indexPC,]

table(train_crC$Good_Bad)/nrow(train_crC)
table(test_crC$Good_Bad)/nrow(test_crC)

