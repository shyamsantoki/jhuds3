#	Downloading and preparing data
library(dplyr)
if (!dir.exists("Data")) {
	dir.create("Data")
}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Data/UCI.zip", method="curl")
unzip("Data/UCI.zip", files=NULL, exdir="Data")
features <- read.table("Data/UCI HAR Dataset/features.txt", col.names=c("n","feature"))
activities <- read.table("Data/UCI HAR Dataset/activity_labels.txt", col.names=c("code", "activity"))
X_test <- read.table("Data/UCI HAR Dataset/test/X_test.txt", col.names=features[['feature']])
y_test <- read.table("Data/UCI HAR Dataset/test/y_test.txt", col.names="code")
subject_test <- read.table("Data/UCI HAR Dataset/test/subject_test.txt", col.names="subject")
X_train <- read.table("Data/UCI HAR Dataset/train/X_train.txt", col.names=features[['feature']])
y_train <- read.table("Data/UCI HAR Dataset/train/y_train.txt", col.names="code")
subject_train <- read.table("Data/UCI HAR Dataset/train/subject_train.txt",  col.names="subject")

# Q1:
#   Merges the training and the test sets to create one data set.
X <- rbind(X_train, X_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
rm(X_test, X_train, y_test, y_train, subject_test, subject_train)
data <- cbind(Subject, X, Y)

# Q2:
#   Extracts only the measurements on the mean and standard deviation for each measurement.
data <- data %>% select(subject, contains("mean"), contains("std"), code)

# Q3:
#   Uses descriptive activity names to name the activities in the data set
data[['code']] <- activities[data[['code']], 'activity']

# Q4:
#   Appropriately labels the data set with descriptive variable names. 
names(data) <- gsub("subject", "Subject", names(data))
names(data) <- gsub("code", "Activity", names(data))
names(data) <- gsub("^t", "Time", names(data))
names(data) <- gsub("^f", "Frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("std", "STD", names(data))
names(data) <- gsub("mad", "MAD", names(data))
names(data) <- gsub("max", "Max", names(data))
names(data) <- gsub("min", "Min", names(data))
names(data) <- gsub("sma", "SMA", names(data))
names(data) <- gsub("irq", "IQR", names(data))
names(data) <- gsub("mean", "Mean", names(data))
names(data) <- gsub("tBody", "TimeBody", names(data))
names(data) <- gsub("freq", "Frequency", names(data))
names(data) <- gsub("energy", "Energy", names(data))
names(data) <- gsub("entropy", "Entropy", names(data))
names(data) <- gsub("arCoeff", "ArCoeff", names(data))
names(data) <- gsub("maxInds", "MaxIndex", names(data))
names(data) <- gsub("meanFreq", "MeanFrequency", names(data))
names(data) <- gsub("skewness", "Skewness", names(data))
names(data) <- gsub("kurtosis", "Kurtosis", names(data))
names(data) <- gsub("correlation", "Correlation", names(data))
names(data) <- gsub("bandsEnergy", "BandsEnergy", names(data))
names(data) <- gsub("angle", "Angle", names(data))

# Q5:
#   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final <- data %>% group_by(Subject, Activity) %>% summarise_all(list(mean=mean))
write.table(final, "final.txt", row.name=FALSE)