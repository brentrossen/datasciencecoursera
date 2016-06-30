# Getting and Cleaning Data Course Project Submission

This project is a solution to the Course Project for the Getting and Cleaning Data course on Coursera. 

The project contains the run_analysis.R file. This file will download the data, run the analysis, and output data/mean_features.txt". Please also find CodeBook.md, which describes the contents of the tidy dataset.

The analysis uses dplyr and tidyr to wrangle the data from a messy format into a tidy format. Each action is commented in the .R file so the code can be read easily.

The contents of this repo satisfy all 5 requirements laid out in the project instructions (included for reference in the last section).

1. The test and training datasets are merged into a single dataset.
2. The mean and standard deviation measurements are extracted.
3. The descriptive activity names are used in the dataset by mapping each label index from activity_labels.txt to the appropriate value.
4. The features have been appropriately named by mapping features.txt onto the feature columns.
5. From the dataset created in steps 1-4, a second independent tidy dataset is derived containing the average of each variable for each activity and each subject.

# Process in run_analysis.r

1. Download and unzip https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Read features.txt and activity_labels.txt
3. Construct functions readSubject, readX, and readY. These functions read in subject_test/train.txt, X_test/train.txt, and Y_test/train.txt respectively.
    1. readSubject modifies the column name to subject.
    2. readX maps the column names from features.txt, extracts only the mean and std measurements, and removes the extraneous parentheses. 
    3. readY maps the activity names from activity_labels.txt onto the appropriate activity column.
4. Read test and training data from the files, cbind the columns together for each, then rbind the test dataset to the training dataset.
5. Take the mean of each variable for each activity and each subject.
6. Write the new tidy dataset to mean_features_wide.txt
7. [BONUS] Converts the wide form tidy dataset to a long form dataset.
    1. Gather the columns into a long form with 1 measurement per row.
    2. Separate each feature into a feature, estimate (mean/std), and axis (X, Y, Z).
    3. Extact the domain, source, device, jerk, and magnitude from the feature column.
    4. Remove the now redundant feature column.
    5. Calculate thea mean of each variable for each activity and each subject.
    6. Write the new tidy long form dataset to mean_features_long.txt

# Project Instructions (for reference)

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.