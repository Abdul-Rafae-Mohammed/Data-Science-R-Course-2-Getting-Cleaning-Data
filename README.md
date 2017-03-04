# Data-Science-R-Course-2-Getting-Cleaning-Data
Data Science Specialization
Course - 2
Getting and Cleaning Data: Course Project

Introduction

This repository is the course project for Getting and Cleaning Data Course. It has 4 file including README , run_analysis.R , CodeBook.md
and tidy dataset.

The Uncleaned Datasets

1) features
               There are total of 561 features and are unlabeled and can be found in the X_test.txt and in X_train.txt
2) activities
               The activity labels are in the Y_test.txt file and in Y_train.txt. 
3) Subjects
               The subjects are in the subject_test.txt file  and in subjects_train.txt.


The script and the tidy dataset

The script is called run_analysis.R which will merge the test and training sets together after cleaning them of the ambiguities. 
Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.
