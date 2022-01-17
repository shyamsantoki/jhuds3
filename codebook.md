---
author: Shyam Santoki
date: January 17, 2022
---

# Getting and Cleaning Data

## Code Book

-	About external libraries.
	-	External library ```dplyr``` is used.

-	Download the dataset.
	-	Download the dataset from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and store ZIP file in the ```Data``` folder.
	-	Extract the ZIP file there. The files will be stored in ```Data/UCI HAR Dataset``` directory.

-	Import the dataset.
	-	```features <- features.txt``` [561 rows, 2 columns]\
		The features comes from the accelerometer and gyroscope 3-axial raw signal.
	-	```activities <- activity_labels.txt``` [6 rows, 2 columns]\
		Contains a list of activities performed when the measurements were taken.
	-	```X_test <- test/X_test.txt``` [2947 rows, 561 columns]\
		Contains recorded features test data.
	-	```y_test <- test/y_test.txt``` [2947 rows, 1 columns]\
		Contains test data of activities’ code labels.
	-	```subject_test <- test/subject_test.txt``` [2947 rows, 1 column]\
		Contains test data of volunteers being observed.
	-	```X_train <- train/X_train.txt``` [7352 rows, 561 columns]\
		Contains recorded features train data.
	-	```y_train <- train/y_train.txt``` [7352 rows, 1 columns]\
		Contains train data of activities’ code labels.
	-	```subject_train <- train/subject_train.txt``` [7352 rows, 1 column]\
		Contains train data of volunteers being observed.

-	Merge the training and the test sets to create one data set.
	-	```X``` [10299 rows, 561 columns] is Created by combining ```X_train``` and ```X_test``` using ```rbind()``` function.
	-	```Y``` [10299 rows, 1 column] is Created by combining ```y_train``` and ```y_test``` using ```rbind()``` function.
	-	```Subject``` [10299 rows, 1 column] is Created by combining ```subject_train``` and ```subject_test``` using ```rbind()``` function.
	-	```data``` [10299 rows, 563 column] is Created by merging ```Subject```, ```X```, and ```Y``` using ```cbind()``` function.

-	Extract only the measurements on the mean and standard deviation for each measurement
	-	```data``` [10299 rows, 88 columns] is updated by subsetting ```data``` itself, selected column includes- ```subjects```, the ```mean``` and standard deviation (```std```) for each measurement, and ```code```.

-	Use descriptive activity names to name the activities in the data set.
	-	Replaced the values of ```code``` column of ```data``` dataframe with values of ```activity``` of ```activities``` dataframe.

-	Appropriately label the data set with descriptive variable names.
	-	Renamed ```code``` label with ```Activity```
	-	Replaced starting ```t``` character of label to ```Time```.
	-	Replaced starting ```f``` character of label to ```Frequency```.
	-	Replaced all abbreviations with whole name if it is of one word. (e.g. ```Acc``` to ```Accelerometer```).
	-	Capitalized all other abbreviations. (e.g. ```irq``` to ```IRQ```).
	-	Replaced ```tBody``` with ```TimeBody```.
	-	Now all of the labels of the data set starts with an uppercase letter.

-	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	-	```final``` [180 rows, 88 columns] is created by summarizing ```data```, taking the means of each variable for each activity and each subject, after grouped by ```Subject``` and ```Activity```.