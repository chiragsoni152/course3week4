library(reshape2)

#below is the filename to be downloaded
filename <- "getdata_dataset.zip"

## Download the data as given in the project description, can be downloaded from link provided:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load the activity labels and features present
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation and load the datasets
features_needed <- grep(".*mean.*|.*std.*", features[,2])
features_needed.names <- features[features_needed,2]
features_needed.names = gsub('-mean', 'Mean', features_needed.names)
features_needed.names = gsub('-std', 'Std', features_needed.names)
features_needed.names <- gsub('[-()]', '', features_needed.names)
datatrain <- read.table("UCI HAR Dataset/train/X_train.txt")[features_needed]
activity_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
datatrain <- cbind(subject_train, activity_train, train)
datatest <- read.table("UCI HAR Dataset/test/X_test.txt")[features_needed]
activity_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
datatest <- cbind(subject_test, activity_test, datatest)

# merge datasets and add labels
final_data <- rbind(datatrain, datatest)
colnames(final_data) <- c("subject", "activity", features_needed.names)

# Activity and subjects need to be present as factors, below script will convert them into factors
final_data$activity <- factor(final_data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
final_data$subject <- as.factor(final_data$subject)

final_data.melted <- melt(final_data, id = c("subject", "activity"))
final_data.mean <- dcast(final_data.melted, subject + activity ~ variable, mean)

# below code used to write tidy data to a text file, rown.names = FALSE avoids printing row numbers
write.table(final_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
