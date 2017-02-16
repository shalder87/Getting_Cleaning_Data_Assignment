# Run Analysis on Human Activity Recognition Data from UCI.

This project will read the training and test data measurements from UCI.

The included scripts will read, merge, process, and analyse data in order to tidy it up for analysis.

## Running the Script

Inside the working directory, source("run_analysis.R").

The script is assuming the unzipped directory of the data is already there.  
If not, then run __download_uci_data()__.

Otherwise, just type __run_analysis()__

This function will return the tidy data table and create an equivalent output file : _activitydata_tidy.txt_.

### Important variables

* _train_df_ - Merged training data frame from subject_data, Xdata, and ydata of training directory.
* _test_df_ - Merged test data frame from subject_data, Xdata, and ydata of test directory.
* _alldata_df_ - Merged train_df and test_df with labels for the columns.
* _activity_cleandf_ - the "clean" extracted data from alldata_df with only "mean" and "std" vectors.  Also has translated "activity_name" vector to provide a name for activity number.
* _activity_tidydf_ - final output of _tidy_ dataset, with rows grouped by subject and activity with mean of each feature vector.

### Dependency

* dplyr - used to aggregate and run mean calculation.

## Files:

### README.md

This markdown file.

### run_analysis.R

This project will read and download data into the working directory and 
perform the following steps to clean the data.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Included in this file are two functions:

1. run_analysis() : Performs the 5 steps to analyse the activity data provide by UCI.
2. download_uci_data() : allows user to download data used for this exercise.  Further described by the DATA subsection below. 

### CodeBook.md

Method of creating and descriptions of the tidy data table returned by running "run_analysis()".

### activitydata_tidy.txt

The table of data written by "run_analysis()".  Included for versioning. This generated data is detailed in CodeBook.md

## Data:

Data file is downloaded from link provided by Coursera Instructor (see below):

* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Further information on this data set can be found at:

* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In general, this data is taken from 30 volunteers using body trackers to determine what activities they were doing.  

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

## Credit:

For generating and sharing this data, a special thanks goes to:

>Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
>Smartlab - Non Linear Complex Systems Laboratory
>DITEN - Università degli Studi di Genova.
>Via Opera Pia 11A, I-16145, Genoa, Italy.
>activityrecognition@smartlab.ws
>www.smartlab.ws