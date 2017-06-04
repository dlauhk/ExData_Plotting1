# Course Poject 1
# Exploratory Data Analysis on Electric Power Consumption

#2. Extracts only the measurements on the mean and standard deviation for each measurement
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject


# Load data
library(dplyr)

features <- read.table("./features.txt")
features <- as.character(features[,2])
activity_labels <- read.table("./activity_labels.txt")
activity_labels <- as.character(activity_labels[,2])

x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/Y_train.txt", header = FALSE, sep = " ")
subject_train <- read.table("./train/subjectx_train.txt", header = FALSE, sep = " ")

x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/Y_test.txt", header = FALSE, sep = " ")
subject_test <- read.table("./test/subject_test.txt", header = FALSE, sep = " ")


# merge data
train <- data.frame(subject_train, y_train, x_train)
names(train) <- c(c("subject","activity"),features)

test <- data.frame(subject_test, y_test, x_test)
names(test) <- c(c("subject","activity"),features)

mergedata <- rbind(train,test)

# Extract only mean and standard deviation metrics

features_extract <- grep("mean|std", features)
mergedata_extract <- mergedata[,c(1,2,features_extract +2)]

# Uses descriptive activity names to name the activities in the data set

mergedata_extract$activity <- activity_labels[mergedata_extract$activity]

# Appropriately labels the data set with descriptive variable names

renamedata <- names(mergedata_extract)
renamedata <- gsub("[(][)]","",renamedata)
renamedata <- gsub("-","_",renamedata)
renamedata <- gsub("^t","TimeDomain_",renamedata)
renamedata <- gsub("^f","FrequencyDomain_",renamedata)
renamedata <- gsub("Acc","Accelerometer",renamedata)
renamedata <- gsub("Gyro","Gyroscope",renamedata)
renamedata <- gsub("mean","Mean",renamedata)
renamedata <- gsub("std","Standard_Deviation",renamedata)
names(mergedata_extract) <- renamedata

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

tidy_data <- aggregate(mergedata_extract[,3:81], by=list(activity=mergedata_extract$activity,subject=mergedata_extract$subject), FUN = mean)
write.table(tidy_data, "./tidy_data.txt")