# Getting and Cleaning Data Project

## Overview:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
This project uses data which represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
* A full description of the data used in this project can be found here:
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">Human Activity Recognition Using Smartphones Data Set </a>
* The source data for this project was downloaded from here:
<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">UCI HAR Dataset </a>

## Files:
* **README.md** : This file.
* **run_analysis.R** : This file is an R script that does the following:
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set.
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* **CodeBook.md**: This file explains the variables, the data, and any transformations or work that **run_analysis.R** performs to clean up the data.
* **second_tidy_data_set.txt**: This file is a text file which contains the tidy data set created by the **run_analysis.R** script.
