#####################run_analysis##############
setwd("C:/Users/JAI/Downloads/Cousera Data Science Specialization/3. data cleaning videos/week4/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")

#merging train & test datasets
train <- read.table("train/X_train.txt",header = F)
train_colnames <- read.table("features.txt")
colnames(train) <- train_colnames$V2

test <- read.table("test/X_test.txt",header = F)
test_colnames <- read.table("features.txt")
colnames(test) <- test_colnames$V2
train_test <- rbind(train,test)

label_train <- read.table("train/y_train.txt")
label_test <- read.table("test/y_test.txt")
label <- rbind(label_train,label_test)

subject_train <- read.table("train//subject_train.txt")
subject_test <- read.table("test//subject_test.txt")
subject <- rbind(subject_train,subject_test)


#mean & std deviations measurements
a <- grep("mean\\(\\)|std\\(\\)",colnames(train_test))
train_test <- train_test[a]

#activity labels
activity <- read.table("activity_labels.txt")
colnames(label) <- "ID"
colnames(activity)[1] <- "ID"
label <- merge(label,activity,by="ID")
label <- label[2]
colnames(label) <- "activity"
colnames(subject) <- "subject"

#combined dataset
data <- cbind(train_test,label,subject)
write.table(data, "merged_data.txt")

#
data2 <- aggregate(x = data[-68], by = list(data$activity,data$subject), FUN = "mean")
write.table(data2, "data_with_means.txt")
