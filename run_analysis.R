getwd()
setwd("D:/R Docs/run_analysis")
if(!file.exists("run_analysis")){
  dir.create("run_analysis")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "D:/R Docs/run_analysis/dataset.zip")
list.files("D:/R Docs/run_analysis")
dataset <- "dataset.zip"
unzip(dataset)
dataset
unzip(dataset, files=NULL, list=FALSE, overwrite=TRUE)
list.files("D:/R Docs/run_analysis/UCI HAR Dataset")
readme <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/README.txt", header = FALSE, sep ="\t", stringsAsFactors = FALSE)
readme

activity_labels <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/activity_labels.txt")
features <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/features.txt")
features_info <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/features_info.txt", header = FALSE, sep ="\t", stringsAsFactors = FALSE)
list.files("D:/R Docs/run_analysis/UCI HAR Dataset/test")
list.files("D:/R Docs/run_analysis/UCI HAR Dataset/train")
subject_test <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/test/y_test.txt")
rm(list=ls())
x_train <- read.table ("D:/R Docs/run_analysis/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table ("D:/R Docs/run_analysis/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("D:/R Docs/run_analysis/UCI HAR Dataset/train/subject_train.txt")

colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_labels) <- c("activityId", "activityType")

train_merged <- cbind(x_train, subject_train, y_train)
test_merged <- cbind(x_test, subject_test, y_test)
all_merged <- rbind (train_merged, test_merged)

ColNames_AllMerged <- colnames(all_merged)
View(ColNames_AllMerged)
head(ColNames_AllMerged)

###set a value with activityId, subjectId, mean, std

mean_and_std <- (grepl("activityId", ColNames_AllMerged) |
                   grepl("subjectId", ColNames_AllMerged) |
                   grepl("mean", ColNames_AllMerged) |
                   grepl("std", ColNames_AllMerged)
                 )

head(mean_and_std)
mean_and_std[1:10]
ColNames_AllMerged[1:10]
tail(mean_and_std)
tail(ColNames_AllMerged)


mean_and_std_subset <- all_merged [, mean_and_std == TRUE]

allmerged_actID <- merge(mean_and_std_subset, activity_labels, by = 'activityId', all.x = TRUE)

dim(allmerged_actID)


avgdataset <- aggregate(. ~subjectId + activityId, allmerged_actID, mean)
avgdataset <- avgdataset[order(avgdataset$subjectId, avgdataset$activityId),]

write.table(avgdataset, "avgdataset.txt", row.names = FALSE)















