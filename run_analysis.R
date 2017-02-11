## Loading Libraries as required

library(plyr)
library(tidyr)
library(datasets)
library(reshape2)

## Creating directory and downloading files for the project assignment

if (!file.exists("data")) { dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/project.zip")
 
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Part I: Read & Merges the training and the test sets to create one data set.

features<-  read.table("./UCI HAR Dataset/features.txt",header=FALSE)
features_t <- t(features)

xtrain<- read.table("./UCI HAR Dataset/train/X_train.txt",header=TRUE)
names(xtrain) <- features_t[2,]
ytrain<- read.table("./UCI HAR Dataset/train/Y_train.txt",header=TRUE)
subtrain<- read.table("./UCI HAR Dataset/train/subject_train.txt",header=TRUE)
train <- cbind2(ytrain,subtrain)
train <- cbind2(train,xtrain)



xtest<- read.table("./UCI HAR Dataset/test/X_test.txt",header=TRUE)
names(xtest) <- features_t[2,]
ytest<- read.table("./UCI HAR Dataset/test/Y_test.txt",header=TRUE)
subtest<- read.table("./UCI HAR Dataset/test/subject_test.txt",header=TRUE)
names(subtest) <- c("X1")
test <- cbind2(ytest,subtest)
test <- cbind2(test,xtest)

combine<- rbind(train,test)

# Below steps shows that the merged sets has same number of records with 
# same number of attributes as the files provided
dim(xtrain)
dim(ytrain)
dim(xtest)
dim(ytest)
dim(subtrain)
dim(subtest)
dim(train)
dim(test)
dim(combine)


## PartII: Extracts only the measurements on the mean and standard deviation 
## for each measurement. Please note I have also included meanFreq() as that is 
## not explicitly requested.
##------------------------------------------------------------------------
  combine_ss <- combine[,grepl("X1|X5|mean|std",names(combine))]


##Part III: Uses descriptive activity names to name the activities in the data set
##-----------------------------------------------------------------------

act_labels<-  read.table("./UCI/activity_labels.txt",header=FALSE)
combine_des<- merge(combine_ss,act_labels,by.x="X5",by.y="V1")
combine_des <- combine_des[,c(ncol(combine_des),2,3:(ncol(combine_des)-1))]


##Part IV: Appropriately labels the data set with descriptive variable names.
##------------------------------------------------------------------------
  names(combine_des) <- gsub("()", "", names(combine_des), fixed = TRUE)
names(combine_des) <- gsub("-","_", names(combine_des), fixed = TRUE)
names(combine_des) <- gsub("V2","ACTIVITY_NAME", names(combine_des), fixed = TRUE)
names(combine_des) <- gsub("X1","SUBJECT_NUM", names(combine_des), fixed = TRUE)

##Part V: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##---------------------------------------------------------------------
tidy_long <-melt(combine_des,id=c("ACTIVITY_NAME","SUBJECT_NUM"))

# Get AVERAGE data
tidy_wide <- aggregate(. ~ ACTIVITY_NAME + SUBJECT_NUM , data = combine_des, mean)


## Final Step: Writing the Tidy Data Set
write.table(tidy_wide,file="tidy_wide.txt",row.name=FALSE)
