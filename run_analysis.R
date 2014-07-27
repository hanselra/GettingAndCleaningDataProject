rm(list=ls())
setwd("~/Documents/AAAS_2013_2014/R_Stats/courserastuff/GettingandCleaningData/project/")


## 1. Merges the training and the test sets to create one data set.
#test folder
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
xy_test<-cbind(subject_test, y_test, x_test)

#train folder
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
xy_train<-cbind(subject_train, y_train, x_train)

bigdata<-rbind(xy_test, xy_train)
SubjectId<-bigdata[,1]
Activity<-bigdata[,2]

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#read in features.txt to get names
features<-read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
featurenames<-c(features$V2)
colnames(bigdata)<-c("SubjectID", "Activity", featurenames)
meandata<-bigdata[,grepl("mean", colnames(bigdata)) & !grepl("BodyBody", colnames(bigdata))]
stddata<-bigdata[,grepl("std", colnames(bigdata)) & !grepl("BodyBody", colnames(bigdata))]

onlymeansandsd<-cbind(SubjectId, Activity, meandata, stddata)

#3 Uses descriptive activity names to name the activities in the data set
Activity<-gsub("1", "Walking", Activity)
Activity<-gsub("2", "Walking_Upstairs", Activity)
Activity<-gsub("3", "Walking_Downstairs", Activity)
Activity<-gsub("4", "Sitting", Activity)
Activity<-gsub("5", "Standing", Activity)
Activity<-gsub("6", "Laying", Activity)
onlymeansandsd<-cbind(SubjectId, Activity, meandata, stddata)



#4. Appropriately labels the data set with descriptive variable names. 
cn<-colnames(onlymeansandsd)
t0<-gsub("Mag-std\\()", "Magnitude_Standard_Deviation", cn)
t1<-gsub("-std\\()", "Standard_Deviation_", t0)
t2<-gsub("-mean\\()", "Mean_", t1)

t3<-gsub("-X", "X_Direction", t2)
t4<-gsub("-Y", "Y_Direction", t3)
t5<-gsub("-Z", "Z_Direction", t4)

t6<-gsub("tBody", "Time_Body_", t5)
t7<-gsub("tGravity", "Time_Gravity_", t6)
t8<-gsub("fBody", "Frequency_Body_", t7)
t9<-gsub("Acc", "Acceleration_", t8)
t10<-gsub("Gyro", "Gyroscope_", t9)
t11<-gsub("Mag", "Magnitude_", t10)
t12<-gsub("Jerk", "Jerk_", t11)
t13<-gsub("-meanFreq\\()", "Mean_Frequency_", t12)
t14<-gsub("_nitude", "", t13)
t15<-gsub("Acceleration_Magnitude_Mean_Frequency_", "Acceleration_Magnitude_Mean_Frequency", t14)
t16<-gsub("Body_Acceleration_Magnitude_Mean_", "Body_Acceleration_Magnitude_Mean", t15)
t17<-gsub("Gravity_Acceleration_Magnitude_Mean_", "Gravity_Acceleration_Magnitude_Mean", t16)
t18<-gsub("Jerk_Magnitude_Mean_", "Jerk_Magnitude_Mean", t17)
t19<-gsub("Time_Body_Gyroscope_Magnitude_Mean_", "Time_Body_Gyroscope_Magnitude_Mean", t18)

colnames(onlymeansandsd)<-t19

#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_data<-aggregate(onlymeansandsd[3:72], by=list(onlymeansandsd$SubjectId, onlymeansandsd$Activity), FUN=mean, na.rm=TRUE)

write.table(tidy_data, "tidy_data.txt")
print(tidy_data)