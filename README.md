README file for run_analysis.R
==============================
The script run_analysis.R uses pre-processed data from a set of people who logged their activities using wearable technology.
The data was gathered as two separate sets: test data and training data.
The pre-processed data above is described in the accompanying codebook.

run_analysis.R script outputs a file 'qtidyData.txt' of aggregated summary information which is the set of means for a selection of observations.
The selected observations for run_analysis.R are only the means and standard deviations from the original data set.  All other observations were omitted from further transformations.

The means for the selected observations are shown as aggregated means by subject and by activity.

run_analysis.R script performs transformations and summary data as follows :

1.Merges the training and the test sets to create one data set using original data from:
  #http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
  
  1.1 Reads in the feature names so that observation data is easy to read
  1.2 Reads in the activity labels so that observation data is easy to read
  1.3 Reads in the observation data

2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Applies descriptive activity names to name the activities in the data set.
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

6.Writes out the table to a file

7. The output variables are described in the accompanying codebook.

