#======================================================
# Analysis of data from wearable computing
#======================================================

library(plyr)
library(dplyr)
library(tidyr)
library(data.table)

#create folder if it doesnt exist and unzip the contents
if(!file.exists("./data")) (dir.create("./data"))
folder_zip <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data/model.zip")
unzip("data/model.zip", exdir = "./data/model")

#Fetch the datasets
# ------------------------------------------ #

# Activity files
activity_test <- fread("data/model/UCI HAR Dataset/test/y_test.txt", header = FALSE)
activity_train <- fread("data/model/UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Feature files
features_test <- fread("data/model/UCI HAR Dataset/test/X_test.txt", header = FALSE)
features_train <- fread("data/model/UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Activity labels
activity_labels <- fread("data/model/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Features labels
features_labels <- fread("data/model/UCI HAR Dataset/features.txt", header = FALSE)

# Subject txts
subject_test <- fread("data/model/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- fread("data/model/UCI HAR Dataset/train/subject_train.txt", header = FALSE)


# Merge datasets
features_data <- rbind(features_test, features_train)
activity_data <- rbind(activity_test, activity_train)
subject_data <- rbind(subject_test, subject_train)

# Join activity files
# Descriptive naming

# Activity
names(activity_data) <- "Activity Num"
names(activity_labels) <- c("Activity Num", "Activity")

activity <- left_join(activity_data, activity_labels, "Activity Num")[,2]

# Subjects
names(subject_data) <- "Subject"
# Features
names(features_data) <- features_labels$V2

# One database
data <- cbind(subject_data, activity)
data <- cbind(data, features_data)

# Extract metrics needed in single dataset
subset_feature_labels <- features_labels$V2[grep("mean\\(\\)|std\\(\\)", features_labels$V2)]
data_names <- c("Subject", "activity", as.character(subset_feature_labels))
data <- subset(data, select = data_names)

# Use more descriptive names in the subsetted data set

names(data) <- gsub("^t", "times", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))

# Tidy data set
tidy_data <- aggregate(. ~Subject + activity, data, mean)
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$activity), ]

# Get table written
write.table(tidy_data, file = "tidydata.txt", row.names = FALSE)
