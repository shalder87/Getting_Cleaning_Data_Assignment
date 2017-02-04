######Download File######
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./read_data")){dir.create("./read_data")}
download.file(url,destfile = "./read_data/Dataset.zip",method="curl")

######Unzip File & setting up File path#########
unzip(zipfile="./read_data/Dataset.zip",exdir="./read_data")
rawf <- file.path("./read_data","UCI HAR Dataset")


#######Loading the Files#########################
testset<-read.table(file.path(rawf, "test" , "X_test.txt" ),header = FALSE)
trainset<-read.table(file.path(rawf, "train" , "X_train.txt" ),header = FALSE)
label_test<-read.table(file.path(rawf, "test" , "Y_test.txt" ),header = FALSE)
label_train<-read.table(file.path(rawf, "train" , "Y_train.txt" ),header = FALSE)
subject_test<-read.table(file.path(rawf, "test", "subject_test.txt"),header = FALSE)
subject_train<-read.table(file.path(rawf, "train", "subject_train.txt"),header = FALSE)


########### Question 1 Merges the training and the test sets to create one data set.###############

merge_test <- rbind(testset, trainset)
merge_label<- rbind(label_test, label_train)
merge_subject<- rbind(subject_test, subject_train)
###Labeling the files#####
names(merge_label)<-c("label")
names(merge_subject)<-c("subject")
features_name<-read.table(file.path(rawf,"features.txt"),header = FALSE)
names(merge_test )<-features$V2
##########################

combine1<-cbind(merge_subject,merge_label)
final_data<-cbind(combine1,merge_test)



################  Question 2:Extracts only the measurements on the mean and standard deviation for each measurement####


mean_std_set<-features_name$V2[grep("mean\\(\\)|std\\(\\)", features_name$V2)]
mean_std_set1<-grep("mean\\(\\)|std\\(\\)", features_name$V2,value=TRUE)

final_data1<-final_data[,c(mean_std_set1,"label","subject")]
str(final_data1)

#####################Question 3:Descriptive activity names to name the activities in the data set######

activity_label <- read.table(file.path(rawf, "activity_labels.txt"),header = FALSE)

activity_name<-sapply(final_data$label,function(x) x<-activity_label[match(x,activity_label[,1]),2])
final_data<-cbind(activity_name,final_data)
###################Question 4 :Appropriately labels the data set with descriptive variable names.######
#prefix t is replaced by time
names(final_data)<-gsub("^t", "time", names(final_data))

#prefix f is replaced by frequency
names(final_data)<-gsub("^f", "frequency", names(final_data))

#Gyro is replaced by Gyroscope
names(final_data)<-gsub("Gyro", "Gyroscope", names(final_data))

#Acc is replaced by Accelerometer
names(final_data)<-gsub("Acc", "Accelerometer", names(final_data))

#Mag is replaced by Magnitude
names(final_data)<-gsub("Mag", "Magnitude", names(final_data))

#BodyBody is replaced by Body
names(final_data)<-gsub("BodyBody", "Body", names(final_data))


##################Question 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.##################
install.packages("plyr")
library(plyr);
final_data2<-aggregate(. ~subject + label, final_data, mean)
final_data2<-final_data2[order(final_data2$subject,final_data2$label),]
write.table(final_data2, file = "tidydata.txt",row.name=FALSE)



