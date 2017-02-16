# Getting and Cleaning Data Course Project

##Objective
The goal of this project is to combine the training and test data provided in the files of UCI_HAR_Dataset(provided below). From the  training and test data provided by UCI has been reduced to only the mean and standard deviation features of the data set. This data contains the selected features used to create the *tidy* dataset.  


Data file is downloaded from link provided by Coursera Instructor (see below):

* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Further information on this data set can be found at:

* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In order to build the tidy data tables in R, the following files were used. (Note: training and test have the same descriptions)

* _"UCI HAR Dataset/train/subject_train.txt"_ - Table describing which user generated the measurement sample in the row.
* _"UCI HAR Dataset/train/X_train.txt"_ - Data of the measurement samples per feature used and described by features_info.txt
* _"UCI HAR Dataset/train/y_train.txt"_ - Activity code of the action represented by the measurement sample. 
* _"UCI HAR Dataset/test/subject_test.txt"_ - Table describing which user generated the measurement sample in the row.
* _"UCI HAR Dataset/test/X_test.txt"_ - Data of the measurement samples per feature used and described by features_info.txt
* _"UCI HAR Dataset/test/y_test.txt"_ - Activity code of the action represented by the measurement sample. 
* _"UCI HAR Dataset/activity_labels.txt"_ - activity labels for each numeric code.
* _"UCI HAR Dataset/features.txt"_ - Name of each column/feature of X_test.txt.
* _"UCI HAR Dataset/features_info.txt"_ - Description of the features of X_Test.txt.
Codebook 

This documents contains a brief description of variables in the tidy dataset. 
Variables (descriptive) 
1.	Activity -  The type of activity taken at the time of observation 
2.	Subject – It is the identifier of the test subject 





####Merges the training and the test sets to create one data set.
The subject, x-data and y-data for first read and merged via cbind() to create a single data table for training and similarly for test data.

Next step, since data is taken on a sample/measurement basis, the resulting training and data tables are merged via rbind(). 

Data in columns is then labeled using the names found in features.txt to identify the feature columns for selection, the "subject" and "activity" labels are also added in this step.


### Extracting the Data

The data to be extracted from the features are only those with "mean" or "std" in their name.  This is done by using grep to determine the columns targeted in this project.

### Run the Analysis

Using the __dplyr__ library, the resulting data variable, "activitydata_tidy", is created by grouping the extracted data by the subject and activity and running a mean across the summarized features.

This reduces the rows from several thousand to 30 subjects \* 6 activities = 120.  The number of columns remain the same, with the _mean_ of the _mean_ and the _mean_ of the _standard deviation_ of each measurement.  

### Important variables from code.

* train_df - Merged training data frame from subject_data, Xdata, and ydata of training directory.
* test_df - Merged test data frame from subject_data, Xdata, and ydata of test directory.
* alldata_df - Merged train_df and test_df with labels for the columns.
* activity_cleandf - the "clean" extracted data from alldata_df with only "mean" and "std" vectors.  Also has translated "activity_name" vector to provide a name for activity number.
* activity_tidydf - final output of _tidy_ dataset, with rows grouped by subject and activity with mean of each feature vector.


### Feature vectors of Tidy Table.

* subject - the subject number from 1:30 who preformed the activity being measured.
* activity_name - the name of the activity being performed.  
** Can be "walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", or "laying"
* activity - the numbered code of the activity from 1:6

The data variables below represent the "mean" of the selected features grouped by the "subject" and "activity_name".

* tBodyAcc-[XYZ][mean|std]
* tGravityAcc-[XYZ][mean|std] 
* tBodyAccJerk-[XYZ][mean|std] 
* tBodyGyro-[XYZ][mean|std] 
* tBodyGyroJerk-[XYZ][mean|std] 
* tBodyAccMag[mean|std]
* tGravityAccMag[mean|std]
* tBodyAccJerkMag[mean|std]
* tBodyGyroMag[mean|std]
* tBodyGyroJerkMag[mean|std]
* fBodyAcc-[XYZ][mean|std]
* fBodyAccJerk-[XYZ][mean|std]
* fBodyGyro-[XYZ][mean|std]
* fBodyAccMag[mean|std]
* fBodyAccJerkMag[mean|std]
* fBodyGyroMag[mean|std]
* fBodyGyroJerkMag[mean|std]

The set of variables that were estimated from these signals are: 

XYZ : Consists of three values for each dimension of travel: X, Y, or Z.
mean|std: Mean value and Standard deviation values for this feature.

Overall there are 66 X features, with 3 additional variables (subject, activity, activity_name) for a total of 69.

*Final size of tidy table: 120 obs by 69 variables*