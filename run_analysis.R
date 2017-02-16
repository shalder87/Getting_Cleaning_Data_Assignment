##### Student Name : Saugata Halder
##### Course :Getting and Cleaning Data
##### Assignement: Getting and Cleaning Data Course Project

#### ##################   Description #########################
####   The R program file will download,store then read, clean, and analyze data from UCI HAR Datasheet.
####  
####      a. First it merges the training and the test sets to create one data set.
####      b. Extracts only the measurements on the mean and standard 
####           deviation for each measurement.
####      c. Uses descriptive activity names to name the activities in the data set
####      d. Appropriately labels the data set with descriptive variable names.
####      e. From the data set in step 4, creates a second, independent tidy data 
####           set with the average of each variable for each activity and each subject.
####    
####============================================================================

##-----------------------------------------------------
## Include some libraries used by functions.
library(dplyr)
library(tidyr)


filename = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile = "./UCI_HAR_Dataset.zip"

if(file.exists(destfile)) {
  stop(print("Output File Exists, delete first!"))
}

download.file(filename,destfile)
unzip(destfile)
  
  #---------------------------------------------
  # Step 0: Specify some variables to simply code.
  #---------------------------------------------
  

rawf <- file.path("UCI HAR Dataset") 
X_test<-read.table(file.path(rawf, "test" , "X_test.txt" ),stringsAsFactors = FALSE)
X_train<-read.table(file.path(rawf, "train" , "X_train.txt" ),stringsAsFactors = FALSE)
y_test<-read.table(file.path(rawf, "test" , "Y_test.txt" ),stringsAsFactors = FALSE)
y_train<-read.table(file.path(rawf, "train" , "Y_train.txt" ),stringsAsFactors = FALSE)
subject_test<-read.table(file.path(rawf, "test", "subject_test.txt"),stringsAsFactors = FALSE)
subject_train<-read.table(file.path(rawf, "train", "subject_train.txt"),stringsAsFactors = FALSE)

 
######################################################################
#### 1 .Merges the training and the test sets to create one data set.
######################################################################
  
  # Merging training data variables
  train_df <- data.frame(subject_train, X_train, y_train)
  
  # Merging test data variables
  test_df  <- data.frame(subject_test,  X_test,  y_test)
  
  # Merge test and training activity data.
  alldata_df <- rbind.data.frame(train_df,test_df)
  

  ######################################################################
  #### 2 .Label the variables sets (4)
  ######################################################################
  
  # Name of each variable.  
  # *_row is the subject of the data sample row.
  # *_ydata is the activty recorded.
  cnames <- rbind("subject", xlabels[2], "activity")
  
  # Apply the variable names to each variable.
  colnames(alldata_df) <- cnames[[1]]  # make cnames dimensionless vector.
  
  
  ######################################################################
  #### 3 .Extracts only the measurements on the mean and standard 
  ####    deviation for each measurement. 
  ######################################################################
  
  # Create mean and standard deviation regex to grep colnames.
  extract_regex <-  "mean\\(\\)|std\\(\\)" 
  
  # grep the colnames.
  extract_indexs <- grep(extract_regex,colnames(alldata_df))
  
  # add in the Subject and activity lines too.
  extract_indexs <- c(1, extract_indexs, length(cnames[[1]]))
  
  # Extract data 
  #  Note: (can't use "filter" due to non-unique names from xlabels)
  activity_cleandf <- alldata_df[, extract_indexs]
 
  
   ######################################################################
  #### 4 .Use meaningful names for Activities (3)
  ######################################################################
  
  # adds the activity name to the data based on the activity code from ylabels.
  #
  #  1 WALKING
  #  2 WALKING_UPSTAIRS
  #  3 WALKING_DOWNSTAIRS
  #  4 SITTING
  #  5 STANDING
  #  6 LAYING
  
  activity_cleandf <- mutate(activity_cleandf,activity_name = ylabels[activity,2])
  
  
  ######################################################################
  #### 5 .From the data set in step 4, creates a second, independent 
  ####    tidy data set with the average of each variable for each 
  ####    activity and each subject.
  ######################################################################
  
  #using the dplyr package functions. to get mean for each.
  activity_tidydf <- activity_cleandf %>%
                     group_by(subject,activity_name) %>%
                     summarise_each(funs(mean(., na.rm=TRUE)))
  
  #update for meaningful name of vector now that each is an average.
  colIndex = 3:(length(activity_tidydf)-1)
  names(activity_tidydf)[colIndex] <- paste("avg.",names(activity_tidydf)[colIndex] )
  
  #write table to output.
  write.table(activity_tidydf, "tidy_data.txt", row.names=FALSE)
  

  
  

  