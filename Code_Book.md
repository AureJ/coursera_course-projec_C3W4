## Code Book

This document povides informtation on the two data sets that obtain using the run_analysis.R script.

They are respectivelly called tidy_ds and av_tidy_ds

# The run_analysis.R

That script performs the following step to transform the original data set to two new tidy one :

1. Download and unzip the original data set
2. Create a data frame for each kind of data (activity, subject, data)
3. Using bind_rows and bind_col, it gathers all the data frame in an one data frame
4. Modify the big data frame to have only measurements on the mean and standard deviation and use descriptive activity names to name the activities
5. Repalce all prefix and abreviations by the right word, for each variable name
6. Create a second, independent tidy data set with the average of each variable for each activity and each subject
7. Export and save the new tyidy data set in the local folder

# The data set

__tidy_ds__

The following are new variables create by the script :

* Subject (num) : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* ActivityID (num) : Each row identifies the number ID of the activity perform by the subject. Its range is from 1 to 6
* ActivityName (char) : Each row identifies the right name of activity perform by the subject. Its can take the following value :
	1. WALKING: subject was walking during the test
	2. WALKING_UPSTAIRS : subject was walking up a staircase during the test
	3. WALKING_DOWNSTAIRS: subject was walking down a staircase during the test
	4. SITTING : subject was sitting during the test
	5. STANDING : subject was standing during the test
	6. LAYING : subject was laying down during the tes

The rest of the varaible come from the original features file. They name of value are just modified by the script.

__(Extract from the UCI HAR DATASET/features_info.txt file)__ The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* timeBodyAcc-XYZ (num)
* timeGravityAcc-XYZ (num)
* timeBodyAccJerk-XYZ (num)
* timeBodyGyroscope-XYZ (num)
* timeBodyGyroscopeJerk-XYZ (num)
* timeBodyAccMagnitude (num)
* timeGravityAccMagnitude (num)
* timeBodyAccJerkMagnitude (num)
* timeBodyGyroscopeMagnitude (num)
* timeBodyGyroscopeJerkMagnitude (num)
* frequencyBodyAcc-XYZ (num)
* frequencyBodyAccJerk-XYZ (num)
* frequencyBodyGyroscope-XYZ (num)
* frequencyBodyAccMagnitude (num)
* frequencyBodyAccJerkMagnitude (num)
* frequencyBodyGyroscopeMagnitude (num)
* frequencyBodyGyroscopeJerkMagnitude (num)

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean (num)
* timeBodyAccelerometerMean (num)
* timeBodyAccelerometerJerkMean (num)
* timeBodyGyroscopeMean (num)
* timeBodyGyroscopeJerkMean (num)

__av_tidy_ds__

Same variable that for tidy_ds, except ActivityID, which represent the average of all features by kind of activity and subject.