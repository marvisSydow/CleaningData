# Getting and Cleaning Data Course Project
# Author: M.S.
# Creation Date: 28Jan2024
# Packages Used: dplyr

folderpath <- "./Getting and Cleaning Data/UCI HAR Dataset"
setwd(paste0(getwd(),folderpath))

# Meta data: Will be used for variable names (Task 4)
features <- read.table("./features.txt")
activity_labs <- read.table("./activity_labels.txt",col.names=c("ActivityCode","Activity"))

# Read in order of Subjects and assign appropriate labels (Task 4)
subject_train <- read.table("./train/subject_train.txt");colnames(subject_train)<- "SubjectID"
subject_test <- read.table("./test/subject_test.txt");colnames(subject_test)<- "SubjectID"
table(subject_train);table(subject_test)

# Read in measurement/experiment data: X train, y train, X test y-test
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
table(y_train);table(y_test)

colnames(X_train) <- as.vector(features$V2) #4
colnames(X_test) <- as.vector(features$V2)

# Task 3: Use descriptive activity names to name the activities in the data set
colnames(y_train) <- "ActivityCode"; colnames(y_test) <- "ActivityCode" #4

#Task 1: Merges activities to subjects by for the training and the test sets separately.
y_train_lab <- merge(y_train,activity_labs,by.x="ActivityCode",by.y="ActivityCode",sort=FALSE)
y_test_lab <- merge(y_test,activity_labs,by.x="ActivityCode",by.y="ActivityCode",sort=FALSE)

# TRAIN Subjects and Labels
y_train_lab$ActivityCode <- factor(y_train_lab$ActivityCode)
tr_tst <- c("TRAIN")
subj_activ_train <- cbind(subject_train,y_train_lab,tr_tst)

train <- cbind(subj_activ_train,X_train)

# TEST subject and Labels
tr_tst <- c("TEST")
y_test_lab$ActivityCode <- factor(y_test_lab$ActivityCode)
subj_activ_test <- cbind(subject_test,y_test_lab,tr_tst)

test <- cbind(subj_activ_test,X_test)

# Bring TRAIN and TEST data together vertically into - analysis dataset: adset
adset_raw <- rbind(train,test)

# Task 2: Extract only the measurements on the mean and standard deviation for each measurement
mean_std_cols <- grep("mean|std",features$V2,value=TRUE)
keep_cols <- c("SubjectID","Activity",mean_std_cols)
adset <- adset_raw[,keep_cols]

# Task 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject 
library(dplyr)
varmeans <- adset %>% 
            group_by(SubjectID,Activity ) %>%
            summarise_at(vars(-group_cols()), mean,na.rm=TRUE) 

# Generate output dataset as file
write.table(varmeans,"tidy_dataset.txt")
