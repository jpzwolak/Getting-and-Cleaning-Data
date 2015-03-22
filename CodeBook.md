# Code Book
## Data
The dataset used in this project comes from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) study. You can read more about it [here](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).

## Variables
Data from the downloaded files are named after the actual files, that is:
* `subject.test`, `x.test`, `y.test`,  `subject.train`, `x.train`, `y.train`, `features`

Less obvious names:
* `activities` - data from the `activity_labels.txt` file 
* `subject.data`, `x.data`, `y.data` - the previous datasets merged for further analysis; the "subject", "x" and "y" parts indicate which sets are combined; in each case I combined `*.train` with `*.test` data (in this order)
* `matches.mean`, `matches.std` and `matches` - lists of indexes for which the measurement name contains mean ("mean") or standard derivation ("stud") and a list created from combining both lists
*  `sub.x.data` - data frame containing only measurements with "mean" and "std" in the description
*  `activity.names` - vector with activity names
*  `averages.data ` - data frame with averages of each variable for each activity and each subject

## Transformations or work
1. I started by inserting a command allowing to set up the working directory so that it is easier for others to adapt my code.
2. I loaded all the provided data, naming them according to rules presented in the Variables section. To get a better feel for what the data is like, I checked the dimensions for each of the files as well as the summary using `str()` and `summary()`. In the file I saved only the dimension so that I can refer to them when I will merge data frames. 
3. I added names to the `feature` data frame to make an identification of the variables in this set easier.
4. I merged the training and the test sets using the `rbind()` command (`merge()` would mess up the order of rows by triong to match indexes).
5. I extracted the measurements on the mean and standard deviation for each measurement using the `grep()` command (the "Pattern Matching and Replacement function"), allowing to detect in a data frame character strings. I enforced the `fixed = TRUE` argument to assure exact matching (since it was not specified in the assigmnent, I decided to select only means and standard deviations, and not the mean freuencies). Then I created a subset of `x.data`, selecting only those columns that contain means and standard deviations.
6. I added descriptive activity names by creating a vector with activity names and then using them as factors. To do so, I changed the `y.data` data frame to factor class (to simplify the replacement of activities from numeric to descriptive) and I replaced the labels. At the and I turned `y.data` back to data frame format.
7. I relabeled all data sets with descriptive variable names using a simple `names()` command.
8. To create a second data set with the average of each variable for each activity and each subject I first combined all the data into one data frame using the `cbind()` command (again, `merge()` would mess up the data frame). Than I loaded the `plyr` package to use the `ddply()` function (function that allows to "Split data frame, apply function, and return results in a data frame.", from the R Documentation). My new data frame was saved in a file `averages_data.txt` using the `write.table()` command.
