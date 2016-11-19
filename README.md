# Getting and Cleaning Data - Course Project

This repository has the documentations and scripts for coursera getting and cleaning data course project, original dataset can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

However, not all the files are used to perform this analysis, only the following text files are used:
activity_labels.txt, features.txt, test/subject_test.txt, test/X_test.txt, test/y_test.txt, train/subject_train.txt, train/X_train.txt, train/y_train.txt.

This repository includes the following files:

-**README.txt**: explains what the files are and how they are connected.

-**CodeBook.txt**: describes the variables, the data, and any transformations or work performed to clean up the data.

-**run_analysis.R**: has script for performing the analysis following 5 steps in the assignment instruction.

-**tidydata.txt**: is the result of running run_analysis.R, it calculates the mean of each selected feature varible for each subject and each activity. It has 30 subjects from 1 to 30, 6 activity with discriptive labels, and 66 feature varibles with discriptive names, for example, t is replaced with time, Acc is replaced with Accelerometer, etc.
