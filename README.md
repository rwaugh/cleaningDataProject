cleaningDataProject
===================

Final project for [Getting and Cleaning Data](https://class.coursera.org/getdata-002)

This projects takes accelerometer data and creates averages of the variables using R.

## Raw Data

The raw data for this project comes from the
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
which measured information from accelerometers on Samsung Galaxy S smartphones that had been attached to 30 different subjects as they engaged in 6 different activities.

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

The data archive was downloaded from the following URL on April 27, 2014:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This file must be placed in the working directory before the R program is run. The file is unzipped by the R program in this repository. Only six files are of interest in this analysis. These contain training data and test data which will be joined.

- "UCI HAR Dataset/train/subject_train.txt"
- "UCI HAR Dataset/test/subject_test.txt"
- "UCI HAR Dataset/train/Y_train.txt"
- "UCI HAR Dataset/test/Y_test.txt"
- "UCI HAR Dataset/train/X_train.txt"
- "UCI HAR Dataset/test/X_test.txt"

## Files in Repository

This repository contains three files.

1. This README.md file describing the project and how it was completed.
2. The output file, tidyData2
3. The R script, run_analysis.R which processed the data.

## Variables in Output File

Subject: One of 30 numbered subjects
Activity: On of 6 activities listed above
Features: Mean and standard deviation for the set of features from the original data set, see next section.

### Feature Selection (from features_info.txt in data set) 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

## Steps in Creating Output

The data set was downloaded using R version 3.0.2 with the following code.

    if (!file.exists("data")) {
      dir.create("data")
    }
    fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip")

The data file was then processed by the run_analysis.R script in this repository.

That script unzips the file, reads the resultingfiles into data tables, picking out only the variables with mean() and std() in their names. These tables are combined into a single table and headers added. This table is broken down with the melt function and recombined into a table showing the average values for each variable for each subject/activity pairing.

