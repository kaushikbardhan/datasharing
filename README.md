This is my README file for the project coursework for Getting and Cleaning data

You can download the "tidy_wide.txt" file and save it on your working directory.
Open R console/Studio and then you can view the file tidy_wide.txt using the below command:

mytidydata <- read.table("tidy_wide.txt",header=TRUE)

Please make sure you have used header = TRUE argument.

We are requested to do the following:

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

---------------------------------------------------------------------------------
PART I: Merges the training and the test sets
---------------------------------------------------------------------------------
I first create a working directory under the home directory for this project. Then I download the file from the given location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Then I create the below datasets using the files provided. xtrain and xtest data both have 561 columns and features data has 561 rows. The names which are mentioned in features data, are the column names of xtrain and xtest. So I transpose the features data and rename the columns of xtrain and xtest.

y_train and y_test they have the activity list and subject_train and subject_test have subject list. The details of activity and subject types are mentioned in the codebook.

features: contains data of features.txt
features_t: Transposed features dataset

xtrain: contains data of x_train.txt
ytrain: contains data of y_train.txt
subtrain: contains data of suject_train.txt
train: combine ytrain, subtrain, xtrain

xtest: contains data of x_test.txt
ytest: contains data of y_test.txt
subtest: contains data of suject_test.txt
test: combine ytest, subtest, xtest

combine: Merging train and test using rbind


First I fixed the column names of train files and test files separately and then I used cbind to have a complete train set combining ytrain, subtrain and xtrain and similarly complete test set combining ytest, subtest and xtest.

---------------------------------------------------------------------------------
PartII: Extracts only the measurements on the mean and standard deviation 
---------------------------------------------------------------------------------
The variables used for this step are as follows:

combine_ss: stands for subset of combine with mean and std

I used grepl to separate the columns which has mean and std in the column names. After this step the dataset has all the columns that either has mean or std. There are total of 81 columns on the dataset at this stage.

---------------------------------------------------------------------------------
Part III: Uses descriptive activity names to name the activities in the data set:
---------------------------------------------------------------------------------
Activity names were included in the activity_labels.txt datafile which has been loaded to act_labels. I then merge the descriptive labels and rearrange the data.
1: Walking
2: Walking_upstairs
3: Walking_downstairs
4: Sitting
5: Standing
6: Laying

---------------------------------------------------------------------------------
Part IV: Appropriately labels the data set with descriptive variable names:
---------------------------------------------------------------------------------
 
I have removed "()" signs replaced "-" sign with "_" underscore sign from the column names. I also renamed the Activity Name and Subject Number columns. Rest of the Variables are described in the Codebook. I used gsub comand to rename.

---------------------------------------------------------------------------------
Part V: From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject:
---------------------------------------------------------------------------------
I used reshape2 package for this purpose. The variables used for this step are as follows:

tidy_long means tidy data in long format.
tidy_wide means tidy data in wide format

In tidy_long, melt function keeps "activity" and "subject" columns of the prior data frame as is and creates a third and fourth column named "variable" and "value" where all other 
column names and values of "combine_des" data frame goes. In tidy_wide, dcast function calculates the average of each of the "variable" quantities for each "activity" and  each
"subject" using the MEAN function.

-----------------------------------------------------------------------------------
Final Part: Writing the data of tidy_wide data frame in a text file
-----------------------------------------------------------------------------------

tidy_wide.txt is the file prepared from tdata_wide df and this is the tidy dataset uploaded with the project.


Ref: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
