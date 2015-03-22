setwd("~/Studying/Coursera/Data Science Specialization/3. Getting and Cleaning Data/Assignments/data")

# loading all data files
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# dim = 2947 x 1
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
# dim = 2974 x 561
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
# dim = 2947 x 1

subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# dim = 7352 x 1 
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
# dim = 7352 x 561
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
# dim = 7352 x 1

features <- read.table("./UCI HAR Dataset/features.txt")
# dim = 561 x 2
colnames(features) <- c("id", "measurement")


# 1. Merges the training and the test sets to create one data set.
subject.data <- rbind(subject.train, subject.test)
x.data <- rbind(x.train, x.test)
y.data <- rbind(y.train, y.test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# grep is a Pattern Matching and Replacement function that allows to detect in a data frame character strings; fixed = TRUE assures exact matching
matches.mean <- unique(grep("mean()", features$measurement, fixed = TRUE))
matches.std <- unique(grep("std()", features$measurement, fixed = TRUE))
matches <- sort(c(matches.mean,matches.std))
#creating a subset of x.data, selecting only those columns that contain means and standard deviations
sub.x.data <- x.data[,matches]

# 3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
#creating a vector with activity names
activity.names <- as.vector(activity$V2)
# changing the y.data data frame to factor class to simplify the replacement of activities from numeric to descriptive
y.data$V1 <- factor(y.data$V1)
#changing levels
levels(y.data$V1) <- activity.names
#turning y.data back to data frame
y.data <- as.data.frame(y.data)

# 4. Appropriately labels the data set with descriptive variable names.
names(sub.x.data) <- features$measurement[matches]
names(y.data) <- "activity"
names(subject.data) <- "subject.id"

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
#combining data to one data frame
full. Data <- cbind(subject.data, y.data, sub.x.data)
#finding average for all columns except for first (ids) and second (activities)
averages.data <- ddply(full.data, .(subject.id, activity), function(x) colMeans(x[, 3:68]))
#saving file to averages_data.txt
write.table(averages.data, "averages_data.txt", row.name=FALSE, col.names = FALSE)
