## Data is from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Read in the data 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           header=FALSE, col.names="subjectNum")
set_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                       header=FALSE)
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                         header=FALSE, col.names="label")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                           header=FALSE, col.names="subjectNum")
set_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                       header=FALSE)
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                         header=FALSE, col.names="label")

feature_name <- read.table("./UCI HAR Dataset/features.txt", 
                           col.names = c("num", "varName"))

## Rename the columns of `set_test` and `set_train`
names(set_test) <- feature_name$varName
names(set_train) <- feature_name$varName

## Combine three tables (subject, label and set) into one table for 
## test and train, respectively. Then remove unnecessary tables.
test <- cbind(subject_test, label_test, set_test)
train <- cbind(subject_train, label_train, set_train)
rm(subject_test, subject_train, set_test, set_train, label_test, 
   label_train, feature_name)

# Assignment 1: merge the training and the test sets to create one data set
total <- rbind(train, test)

# Assignment 2: extract only the measurements on the mean and std for each measurements
used <- grep("mean\\(\\)|std\\(\\)", names(total))
total <- total[,c(1:2,used)]

# Assignment 3: use descriptive activity names to name the activities in the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE,
                       col.names=c("num","activity"))
meanandstd <- merge(total, activity, by.x="label", by.y="num")
meanandstd <- meanandstd[,c(2,69,3:68)]

# Assignment 4: appropriately labels the data set with descriptive variable names
## Remove "()" after "mean" and "std"
names(meanandstd) <- sub("\\(\\)", "", names(meanandstd))
## Change "t" to "time"
names(meanandstd) <- sub("^t", "time", names(meanandstd))
## Change "f" to "freq"
names(meanandstd) <- sub("^f", "freq", names(meanandstd))
## Remove duplicated "Body"
names(meanandstd) <- sub("BodyBody", "Body", names(meanandstd))
## Change "-" to "_"
names(meanandstd) <- gsub("-", "_", names(meanandstd))

# Assignment 5: creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject
library(plyr)
columnMean <- function(x){
    colMeans(x[,3:68])
} 
tidydt <- ddply(meanandstd, .(subjectNum, activity), columnMean)

## Write out the file 
write.table(tidydt, file="tidydt.txt", row.names=FALSE)
