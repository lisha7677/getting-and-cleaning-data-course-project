#1.Merges the training and the test sets to create one data set.
#download zip file from url to working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset.zip")
#unzip file to a folder in working directory
unzip("dataset.zip")
#set unzipped file to be the new working directory
setwd("UCI HAR Dataset")
#read 6 activity labels 1 WALKING 2 WALKING UPSTAIRS 3 WALKING DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING
activityLabels<-read.table("activity_labels.txt")
#read 561 features
features<-read.table("features.txt",stringsAsFactors = FALSE)
#read 9 test subjects
subjectTest<-read.table("test/subject_test.txt")
#read test data
xTest<-read.table("test/X_test.txt")
#read test activity data
yTest<-read.table("test/y_test.txt")
#read 21 train subjects
subjectTrain<-read.table("train/subject_train.txt")
#read train data
xTrain<-read.table("train/X_train.txt")
#read train activity data
yTrain<-read.table("train/y_train.txt")
#combine test data
testData<-cbind(subjectTest,yTest,xTest)
#combine train data
trainData<-cbind(subjectTrain,yTrain,xTrain)
#combine test and train data
testTrain<-rbind(testData,trainData)
colnames(testTrain)<-c("subject","activity",features[,2])
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#match pattern on mean() or std in features
wantedFeatures<-grep("mean\\(\\)|std",features$V2,value = TRUE)
#extract data with mean or std in features
wantedData<-testTrain[,c("subject","activity",wantedFeatures)]
#3.Uses descriptive activity names to name the activities in the data set.
#turn activity vector into factor with levels and labels
wantedData$activity<-factor(wantedData$activity,levels = activityLabels[,1],labels = activityLabels[,2])
#4.Appropriately labels the data set with descriptive variable names.
#substitute feature names with discriptive words
names(wantedData)<-gsub("^t", "time", names(wantedData))
names(wantedData)<-gsub("^f", "frequency", names(wantedData))
names(wantedData)<-gsub("Acc", "Accelerometer", names(wantedData))
names(wantedData)<-gsub("Gyro", "Gyroscope", names(wantedData))
names(wantedData)<-gsub("Mag", "Magnitude", names(wantedData))
names(wantedData)<-gsub("BodyBody", "Body", names(wantedData))
names(wantedData)<-gsub("-mean","Mean",names(wantedData))
names(wantedData)<-gsub("-std","Std",names(wantedData))
names(wantedData)<-gsub("[()-]","",names(wantedData))
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#calculate the mean of each variable for each activity and each subject
results<-aggregate(.~subject+activity,wantedData,mean)
#order the data frame based on subject in ascending order then activity in ascending order
resultsData<-results[order(results$subject,results$activity),]
#create end result as a text file
write.table(resultsData,file = "tidydata.txt",row.names = FALSE)
