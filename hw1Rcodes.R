hw <- read.csv("hw1_data.csv",TRUE,",")
class(hw)
head(hw)
data <- data.frame(hw)
hw[2,]
hw[1:2,]
hw1_data[1:3,]
is.na.data.frame(hw)
hw1_data[1,]
hw1_data[,1]
sum(is.na(hw1_data[,1]))
good <- complete.cases(hw1_data[,1])
head(hw1_data[good,])
head(hw1_data[,1])
colMeans(hw1_data,na.rm=TRUE)
x[x==10]ozone <- hw1_data[,1]
temp <- hw1_data[,4]
solar <- data.frame(ozone>=32,temp>=91)
colMeans(solar)
mean(is.na(hw1_data[32:61,4]))
head(is.na(hw1_data[32:61,4]))
colMeans(hw1_data[32:61,],na.rm=TRUE)
head(hw1_data[,1>31])
colMeans(complete.cases(hw1_data[,2]))
colMeans(hw1_data)
