# course3week4
Getting and Cleaning Data - Course Project

The R script present in this repository run_analysis.R will do the following:

Download the dataset if its not already there in the working directory
Loads activity info
Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
Loads the activity and subject data and merges those columns with the dataset
Merges the two datasets and converts the activity and subject columns into factors
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy data.txt
