## CodeBook
This is a markdown file code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

After reading the files it was necessery bind the train and test sets using rbind.
Using lapply over columns to the created dataset using the mean and sd function gave us a vector that represents the mean and standart variation column by column.

Then using activity_labels and features it was possible to rename the variable names and activities. 

Finally using the package dplyr it was possible to group by the data set by subject and activity and calculate the mean using summarise function.



