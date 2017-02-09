library(dplyr)
######Download File######
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./read_data")){dir.create("./read_data")}
download.file(url,destfile = "./read_data/Dataset.zip",method="curl")

######Unzip File & setting up File path#########
unzip(zipfile="./read_data/Dataset.zip",exdir="./read_data")
rawf <- file.path("./read_data","UCI HAR Dataset")


#######Loading the Files#########################
X_test<-read.table(file.path(rawf, "test" , "X_test.txt" ),header = FALSE)
X_train<-read.table(file.path(rawf, "train" , "X_train.txt" ),header = FALSE)
y_test<-read.table(file.path(rawf, "test" , "Y_test.txt" ),header = FALSE)
y_train<-read.table(file.path(rawf, "train" , "Y_train.txt" ),header = FALSE)
subject_test<-read.table(file.path(rawf, "test", "subject_test.txt"),header = FALSE)
subject_train<-read.table(file.path(rawf, "train", "subject_train.txt"),header = FALSE)

features <- read.table(file.path(rawf, "features.txt"),header = FALSE)
activity_labels <- read.table(file.path(rawf, "activity_labels.txt"),header = FALSE)

######################################################################
#### 1 .Merges the training and the test sets to create one data set.
######################################################################
X<-rbind(X_train,X_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)


######################################################################
#### 2 .Extracts only the measurements on the mean and standard 
####    deviation for each measurement. 
######################################################################
mean_vector<-apply(X,2,mean)
sd_vector<-apply(X,2,sd)


######################################################################
#### 3 .Uses descriptive activity names to name the activities in 
####    the data set
#### 4 .Appropriately labels the data set with descriptive variable 
####    names. 
######################################################################

y_new<-merge(y,activity_labels)
names(X)<-paste(features[,1],features[,2],sep='_')

#######################
### remaning other variables, to be easier to read
#######################

names(subject)<-"subject"
names(y_new)<-c("Activity","Activity_Description")

######################################################################
#### 5 .From the data set in step 4, creates a second, independent 
####    tidy data set with the average of each variable for each 
####    activity and each subject.
######################################################################


## new_data represents the dataset to modify
new_data<-cbind(subject,X,y_new)

### group the new_data by subject, Activity, and Activity_Description to be 
### easier to calculate the average of each variable
new_data_2<-group_by(new_data,subject,Activity,Activity_Description)


### columns to apply the mean
cols <- names(new_data_2)[!(names(new_data_2) %in% c('subject','Activity'
                                                     ,'Activity_Description'))]
dots <- sapply(cols ,function(x) substitute(mean(x), list(x=as.name(x))))


final_data<-do.call(summarise, c(list(.data=new_data_2), dots))

write.table(final_data,file="tidydata.txt",row.name=FALSE)
tidydata