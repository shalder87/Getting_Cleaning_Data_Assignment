The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Following Steps are undergone to get the desired output
#packages installed plyr
## 1. Merging files

The following files are merged into one data set called "final_data"

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'train/subject_test.txt  : subjected being tested

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

'test/subject_test.txt : Test subjects

## 2. Extracts only the measurements on the mean and standard deviation for each measurement

From the "final_data" object, the measurement data for the variables wich contain mean or standard deviation are subset.
alonog with the Subject and Activity name.

The "features.txt" file is used to identify the feature with mean or standard deviation, using "grep" function

the indices of the feature with mean or standard deviation are obtained in vector "mean_std_set1"
"final_data" is the dataframe, subset of the measurements on the mean and standard deviation for each measurement. 
This products 10299 objects with 81 variables.

## 3. Uses descriptive activity names to name the activities in the data set

The file "activity_labels.txt" is used to extract the activity names and store in object "activity_label".
and are showm below.
> head(activity_label)
     y         Activities
 1:  1            WALKING
 2:  2   WALKING_UPSTAIRS
 3:  3 WALKING_DOWNSTAIRS
 4:  4            SITTING
 5:  5           STANDING
 6:  6             LAYING

The activity names are then merged with the main data "final_data" back into meansstd object.

## 4. Appropriately labels the data set with descriptive variable names.
#prefix t is replaced by time
#prefix f is replaced by frequency
#Gyro is replaced by Gyroscope
#Acc is replaced by Accelerometer
#Mag is replaced by Magnitude
#BodyBody is replaced by Body


## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

"final_data" is aggregated by activity and each subject and output is obtained in "tidydata.txt"
