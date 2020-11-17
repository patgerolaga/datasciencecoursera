#Getting and Cleaning Data Course Project
#Author: PJRG
#Instructions:
#1. Merge the training and the test sets to create one data set
#2. Extract only the measurements on the mean and standard deviation for each measurement
#3. Use descriptive activity names to name the activities in the data set
#4. Appropriately label the data set with descriptive variable names
#5. From the data set in step 4, creates a second, independent tidy data set with the average
#   of each variable for each activity and each subject

#Loading the data
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataSet.zip"))
unzip(zipfile = "dataSet.zip")

#Loading activity labels and features
activityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))
#Extracting mean and sd for each measurement
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

#Loading train dataset and assigning descriptive variable names
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[,featuresWanted, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"),
                         col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"),
                       col.names = c("Subject"))
train <- cbind(trainSubjects, trainActivities, train)

#Loading test dataset and assigning descriptive variable names
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[,featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"),
                        col.names = c("Activity"))
testSubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"),
                      col.names = c("Subject"))
test <- cbind(testSubjects, testActivities, test)

#Merging of train and test datasets
merged <- rbind(train,test)

#Making classLabels into descriptive activity names
merged[["Activity"]] <- factor(merged[,Activity],
                               levels = activityLabels[["classLabels"]],
                               labels = activityLabels[["activityName"]])
merged[["Subject"]] <- as.factor(merged[,Subject])
merged <- reshape2::melt(data = merged, id = c("Subject", "Activity"))
merged <- reshape2::dcast(data = merged, Subject + Activity ~ variable, fun.aggregate = mean)

#Creating an independent tidy data
data.table::fwrite(x = merged, file = "tidydata.txt", quote = FALSE)