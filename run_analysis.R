###############################################################################

# This file is R script which allows to create a tidy data set for the Course 
# Project of Coursera "Getting and Cleaning data" Course.
# For more information of the context and the origin of the data please see the
# README of that repository.

# That R script allow us to :
# 1) Merge the training and the test sets to create one data set.
# 2) Extract only the measurements on the mean and standard deviation for each
# measurement.
# 3) Use descriptive activity names to name the activities in the data set
# 4) Appropriately label the data set with descriptive variable names
# 5) Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject

###############################################################################

## 1) Merge the training and the test sets to create one data set

# Verify if dplyr and tidyr packages are installed and launch them : 

if (!require(dplyr)){
        install.packages("dplyr")
        library(dplyr)
} else {
        library(dplyr)       
} 

if (!require(tidyr)){
        install.packages("tidyr")
        library(tidyr)
} else {
        library(tidyr)       
}

# Download, unzip and open the data set:
if (!file.exists("./UCI HAR Dataset")) { 
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                        destfile = "dowloaded_dataset.zip",
                        mode ="wb")
        unzip("dowloaded_dataset.zip")
        setwd("./UCI HAR Dataset")
} else {
        setwd("./UCI HAR Dataset")
}

# Create a data frame for activities labels and subjects :
train_lab <- read.table("./train/y_train.txt",
                        col.names = "ActivityID")
train_sub <- read.table("./train/subject_train.txt",
                        col.names = "Subject")
test_lab <- read.table("./test/y_test.txt",
                       col.names = "ActivityID")
test_sub <- read.table("./test/subject_test.txt",
                       col.names = "Subject")

# Create a data frame for test and train data using features names :
features <- read.table("features.txt",
                       col.names = c("features_number","features_name"))
feature_names <- features[,"features_name"]
train_set <- read.table("./train/X_train.txt",
                        col.names = feature_names)
test_set <- read.table("./test/X_test.txt",
                       col.names = feature_names)

# Merge all subject data frames in one :
subject_df <- bind_rows(train_sub, test_sub)

# Merge all activies data frames in one :
acitivity_df <- bind_rows(train_lab, test_lab)

# Merge all features data frames in one :
features_df <- bind_rows(train_set, test_set)

# Merge all previous data frames in one tidy data set :
merged_df <- bind_cols(subject_df, acitivity_df, features_df)

## 2) Extract only the measurements on the mean and standard deviation for each
## measurement
## &
## 3) Use descriptive activity names to name the activities in the data set

# Load activity names data frame :
activity <- read.table("activity_labels.txt", 
                       col.names = c("ActivityID", "ActivityName"))

# Modify the global data frame keeping only  measurements on the mean and 
# standard deviation and adding the decriptive name of the activities
tidy_ds <- merged_df %>%
        select(Subject, ActivityID, contains(".mean."),
               contains(".std.")) %>%
        inner_join(activity) %>%
        # just reorder the columns
        select(Subject, ActivityID, ActivityName, c(3:69))

## 4) Appropriately label the data set with descriptive variable names

# Repalce all prefix and abreviations by the right word :
names(tidy_ds)<-gsub("^t", "time", names(tidy_ds))
names(tidy_ds)<-gsub("^f", "frequency", names(tidy_ds))
names(tidy_ds)<-gsub("Acc", "Accelerometer", names(tidy_ds))
names(tidy_ds)<-gsub("Gyro", "Gyroscope", names(tidy_ds))
names(tidy_ds)<-gsub("Mag", "Magnitude", names(tidy_ds))
names(tidy_ds)<-gsub("BodyBody", "Body", names(tidy_ds))

## 5) Create a second, independent tidy data set with the average of each 
## variable for each activity and each subject
av_tidy_ds <- tidy_ds %>%
        select(-ActivityID) %>%
        group_by(ActivityName, Subject) %>%
        summarise_each(funs(if(is.numeric(.)) mean(., na.rm = TRUE)
                            else first(.))) %>%
        arrange(Subject)

# Export and save the new tyidy data set in the local folder :        
write.table(tidy_ds, file = "tidy_ds.txt")
write.table(av_tidy_ds, file = "av_tidy_ds.txt")
