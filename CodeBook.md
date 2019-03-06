# CodeBook

This is the CodeBook for the project, which provides a detailed explanation of the data cleaning process. The data is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## 1.Read in the data

- subject_test/train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- set_test/train: original test or train set data.

- label_test/train: test/train activity labels.

- feature_name: name of variables in set_test/train.

- test/train: comprised of three tables, subject, label and set.

## 2.Merge the training and the test sets

- total: comprised of test and train

## 3.Extract only the measurements on the mean and std

- used: a vector identifies the columns contain the mean and std.
- total: the outcome data after selecting corresponding columns.

## 4.Use descriptive activity names

- activity: data about how each activity is coded.
- meanandstd: after merging total with activity and rearranging columns, this is what we get

## 5.Appropriately rename the columns

Basically, we remove the unnecessary parenthesis and change ways of abbreviation, like use "time" for "t" and "freq" for "f". We also remove duplicated "Body" and Change "-" to "_" to make the names more understandable.

## 6.Summarize the data with the average of each variable for each activity and each subject

- columnMean: a function to get the column means for the columns that we need
- tidydt: after applying ddply function from plyr package, this is the result that we get for summarizing the data. 

For detailed explanation of variable names, you can refer to the features_info.txt. 