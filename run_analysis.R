
# Read data set
if(!file.exists("../original_data_set")){dir.create("../original_data_set")}
data_set_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_set_url,
              destfile="../original_data_set/Dataset.zip")

# Unzip dataSet
unzip(zipfile="../original_data_set/Dataset.zip",
      exdir="../original_data_set")

# 1. Merges the training and the test sets to create one data set.

# Read trainings:
x_train <- read.table("../original_data_set/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("../original_data_set/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("../original_data_set/UCI HAR Dataset/train/subject_train.txt")

# Read testing:
x_test <- read.table("../original_data_set/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("../original_data_set/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("../original_data_set/UCI HAR Dataset/test/subject_test.txt")

# Read features:
features <- read.table('../original_data_set/UCI HAR Dataset/features.txt')

# Read activity labels:
Activity_Labels = read.table('../original_data_set/UCI HAR Dataset/activity_labels.txt')

# Columun Names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"Activity_Id"
colnames(subject_train) <- "Subject_Id"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "Activity_Id"
colnames(subject_test) <- "Subject_Id"

colnames(Activity_Labels) <- c('Activity_Id','Activity_Type')

# Merge data
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
one_data_set <- rbind(merge_train, merge_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
column_names <- colnames(one_data_set)

mean_and_std <- (grepl("Activity_Id" , column_names) | grepl("Subject_Id" , column_names) | 
                   grepl("mean.." , column_names) | grepl("std.." , column_names))
extracted_mean_and_std <- one_data_set[ , mean_and_std == TRUE]

# 3. Uses descriptive activity names to name the activities in the data set
extracted_mean_and_std$Activity_Id <- as.character(extracted_mean_and_std$Activity_Id)
for (i in 1:6){
  extracted_mean_and_std$Activity_Id[extracted_mean_and_std$Activity_Id == i] <- as.character(Activity_Labels[i,2])
}
# 4. Appropriately labels the data set with descriptive variable names
names(extracted_mean_and_std)
names(extracted_mean_and_std)<-gsub("Activity_Id", "Activity", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("Acc", "Accelerometer", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("Gyro", "Gyroscope", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("BodyBody", "Body", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("Mag", "Magnitude", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("^t", "Time", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("^f", "Frequency", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("tBody", "TimeBody", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("-mean()", "Mean", names(extracted_mean_and_std), ignore.case = TRUE)
names(extracted_mean_and_std)<-gsub("-std()", "STD", names(extracted_mean_and_std), ignore.case = TRUE)
names(extracted_mean_and_std)<-gsub("-freq()", "Frequency", names(extracted_mean_and_std), ignore.case = TRUE)
names(extracted_mean_and_std)<-gsub("angle", "Angle", names(extracted_mean_and_std))
names(extracted_mean_and_std)<-gsub("gravity", "Gravity", names(extracted_mean_and_std))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
second_tidy_data_set <- aggregate(. ~Subject_Id + Activity, extracted_mean_and_std, mean)
second_tidy_data_set <- second_tidy_data_set[order(second_tidy_data_set$Subject_Id, 
                                                   second_tidy_data_set$Activity),]

write.table(second_tidy_data_set, "second_tidy_data_set.txt", row.name=FALSE)

