---
title: "README"
author: "RachaelHansel"
date: "July 27, 2014"
output: html_document
---
The "run_analysis.R" file runs the analysis specified in the course project for the Getting and Cleaning Data course.

The file assumes that the data is located in a directory called "UCI HAR Dataset" and this directory is in the current working directory.  

The first part of the script reads the data in from the "UCI HAR Dataset/test" and "UCI HAR Dataset/train" directories. Each file is then combined to form a data frame for the test and train data.  Then the data is merged togethor into one data frame using rbind().
Column 1 and 2 are explicitly named as "SubjectID", and "Activity" to avoid problems in further combination and renaming.  The merged data ("bigdata") is a 10299 x 563 data frame. Only the first 2 columns are names, as mentioned earlier.

The second part of the script reads the names of the other 561 columns from "UCI HAR Dataset/features.txt". The names of the columns are incorporated into "bigdata" using the colnames() command.  We are interested in obtaining columns with the mean and standard of each measurement.  The grepl() command is used to get only columns with "mean" and "std" contained within the names.  There are some spurious columns with names that are not in the original data descriptions (orignal data descriptions can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  These spurious columns have names that contain "BodyBody" and were not included in the final data set.

The third part of the script changes the "Activity" column from numbers to descriptive names for the activities (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying) using the gsub() command.

The fourth part of the script changes all the column names from crypitic titles to more human-readalbe language.   The gsub() command is used for this procedure.

The fifth and final part of the script uses the aggregate() command to create a second data set called "tidydata".  This data set contains the average of each variable (column name) for each activity and each subject. The final data is stored in a data frame called tidydata

