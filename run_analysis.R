#1.Merges the training and the test sets to create one data set.
#download and unzip file from url to working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset.zip")
unzip("dataset.zip")
#set unzipped file to be the new working directory
setwd("UCI HAR Dataset")
#read 6 activity labels and 561 features
activityLabels<-read.table("activity_labels.txt")
features<-read.table("features.txt",stringsAsFactors = FALSE)
#read 9 unique test subjects, test data, and test activity data
subjectTest<-read.table("test/subject_test.txt")
xTest<-read.table("test/X_test.txt")
yTest<-read.table("test/y_test.txt")
#read 21 unique train subjects, train data, and train activity data
subjectTrain<-read.table("train/subject_train.txt")
xTrain<-read.table("train/X_train.txt")
yTrain<-read.table("train/y_train.txt")
#combine test and train data
testData<-cbind(subjectTest,yTest,xTest)
trainData<-cbind(subjectTrain,yTrain,xTrain)
testTrain<-rbind(testData,trainData)
colnames(testTrain)<-c("subject","activity",features[,2])
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#match pattern on 'mean()' or 'std' in features, combine subject, activity, and selected features into one table.
wantedFeatures<-grep("mean\\(\\)|std",features$V2,value = TRUE)
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
