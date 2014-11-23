#run_analysis.R
#This script does the following:

#1.Merges the training and the test sets to create one data set using original data from:
  #http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
  
  #1.1 Read in the feature names so we can set them as easy-to-read column names later
  featureNames <- read.table("features.txt") 
  fnames <- featureNames$V2
  
  #1.2 Read in the activity labels
  activityLabels <- read.table("activity_labels.txt")

  #1.3 Read in the two sets of observation data: observations, activity values, subject values - for test and training
  teData <- read.table("X_test.txt")
  testActivityData <- read.table("y_test.txt")  
  colnames(testActivityData) <- "TAD1"
  testSubjectData <- read.table("subject_test.txt")
  colnames(testSubjectData) <- "TSD1"
    
  
  trData <- read.table("X_train.txt")
  trainActivityData <- read.table("y_train.txt")
  colnames(trainActivityData) <- "TAD1"
  trainSubjectData <- read.table("subject_train.txt")
  colnames(trainSubjectData) <- "TSD1"
  
  #Bind the test and training activity values 
  yActivData = rbind(testActivityData,trainActivityData)
  subjectData = rbind(testSubjectData,trainSubjectData)
  
  #Bind the activity and subject values as one data set so that we can column bind them to the observation data next
  ASData <- cbind(yActivData,subjectData)
  

  #1.4 Merge data into one data set.
  mergedData = merge(teData,trData,all=TRUE)
  #Name all the columns with easy-to-read feature labels
  colnames(mergedData) <- fnames
  
  #Now bind the activity and subject data
  newMerge <- cbind(mergedData,ASData)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
  library(stringr)
  #Get just the means and std dev observations
  meansData <- newMerge[,str_detect(names(newMerge),"mean\\(\\)")]
  stdData <- newMerge[,str_detect(names(newMerge),"std\\(\\)")]
  actData <- newMerge[,str_detect(names(newMerge),"TAD1")]
  subjData <- newMerge[,str_detect(names(newMerge),"TSD1")]
  extractData <- cbind(meansData,stdData,actData,subjData)
    
  
#3.Uses descriptive activity names to name the activities in the data set.
 #Change activity data into factors and change their values to easy-to-read labels
  extractData$actData <- as.factor(extractData$actData)
  levels(extractData$actData)[levels(extractData$actData)=="1"] <- "Walking"
  levels(extractData$actData)[levels(extractData$actData)=="2"] <- "Walking_upstairs"
  levels(extractData$actData)[levels(extractData$actData)=="3"] <- "Walking_downstairs"
  levels(extractData$actData)[levels(extractData$actData)=="4"] <- "Sitting"
  levels(extractData$actData)[levels(extractData$actData)=="5"] <- "Standing"
  levels(extractData$actData)[levels(extractData$actData)=="6"] <- "Laying"
  
    
#4.Appropriately labels the data set with descriptive variable names.
  #Done above when merging data at note 1.4

  
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  library(data.table)
  dt <- as.data.table(extractData)
  tidyData<- dt[, lapply(.SD, mean), by = c("subjData","actData")]
  setnames(tidyData, "subjData", "subject")
  setnames(tidyData, "actData", "activity")
  
  # sort by subject and activity
  qtidyData <- tidyData[order(subject,activity),]
  
  #Write out the table to a file
  write.table(qtidyData, file = "q1tidydata.txt", append = FALSE, quote = TRUE, sep = " ",
              eol = "\n", na = "NA", dec = ".", row.names = FALSE,
              col.names = TRUE, qmethod = c("escape", "double"),
              fileEncoding = "")
  
  #----------------------------------------------------------------------------------------------------------
