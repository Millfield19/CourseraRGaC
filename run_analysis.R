#run_analysis.R
#Millfield19 29.04.2020

#.R file for the Coursera R course week 4 Peer-graded 
#Assignment: Getting and Cleaning Data Course Project

run_analysis <- function () {
      
      #if folder data not exist create one
      if(!file.exists("./data")) {dir.create("./data")}
      
      #if the zip file with data not exist download it
      if(!file.exists("data/getdata_projectfiles_UCI HAR Dataset.zip")) {
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%
                  2FUCI%20HAR%20Dataset.zip"
            download.file(fileURL,destfile = "./data/getdata_projectfiles_UCI HAR Dataset.zip")
      }
      
      #if the zip file is not unzipped unzip it
      if(!file.exists("./data/UCI HAR Dataset")) {
            unzip("./data/getdata_projectfiles_UCI HAR Dataset.zip",exdir = "./data")
      }
      
      
      #open data in train and test
      #in the folder test will be used "subsect_test.txt", "X_test.txt" and "y_test.txt"
      #in the folder train will be used "subsect_train.txt", "X_train.txt" and "y_train.txt"
      setwd("C:/R/CourseraRGaC/data/UCI HAR Dataset/test")
      subject_test <- read.table("subject_test.txt", stringsAsFactors = FALSE, header = FALSE)
      x_test <- read.table("X_test.txt", stringsAsFactors = FALSE, header = FALSE)
      y_test <- read.table("y_test.txt", stringsAsFactors = FALSE, header = FALSE)
      
      setwd("C:/R/CourseraRGaC/data/UCI HAR Dataset/train")
      subject_train <- read.table("subject_train.txt", stringsAsFactors = FALSE, header = FALSE)
      x_train <- read.table("X_train.txt", stringsAsFactors = FALSE, header = FALSE)
      y_train <- read.table("y_train.txt", stringsAsFactors = FALSE, header = FALSE)
      
      
      setwd("C:/R/CourseraRGaC/data/UCI HAR Dataset")
      
      
      #-----------Step1:bind all the data to a big file----------------------------
      #rbind train and test data for each variable
      subjectall <- rbind(subject_test,subject_train)
      xall <- rbind(x_test,x_train)
      yall <- rbind(y_test,y_train)
      
      #cbind rbinded subject, x and y data
      alldata <- cbind(subjectall,xall,yall)
      
      #---------------Step4: set the names in the binded file-----------------------     
      #set the names in the combinded data frame
      #get the names from the features.txt file stored in the second collumn (V2)
      featurenames <- read.table("features.txt",stringsAsFactors = FALSE, header = FALSE)
      
      colnames(alldata) <- c( "subject", featurenames$V2, "activity" )
      
      
      #-------Step2: get the only the mean and std----------------------------
      #get the col that have mean() std() in it
      #I used \\b to start and end my string, otherwise meanFreq was in
      #+1 for jumping the first row (subject)
      meanscol <- grep("\\bmean()\\b", featurenames$V2 ) +1
      stdscol <- grep("\\bstd()\\b", featurenames$V2 ) +1
      
      #create a new object that stores only the means
      meansandstds <- alldata[,c(1,c(meanscol,stdscol),563)]
      
      
      
      #--------Step3:-------------------------------------
      #get the names from the activity_labels.txt file stored in the second collumn (V2)
      activitynames <- read.table("activity_labels.txt",stringsAsFactors = FALSE, header = FALSE)
      
      #match the numbers in meansandstds$activity with their names
      meansandstds$activity <- activitynames$V2[ match( meansandstds$activity, activitynames$V1 ) ]
      
      
      
      #--------------Step5: --------------------------------------
      #tidydata is create as mean(average) of each activity and subject from the data from step3
      tidydata <- aggregate( . ~ subject + activity, data = meansandstds, FUN = mean ) 
      
      #if folder output not exist create one
      setwd("C:/R/CourseraRGaC")
      if(!file.exists("./output")) {dir.create("./output")}
      
      #create/write if to a new file the desired data
      write.table( tidydata, "output/tidydata.txt", row.names = FALSE )
      
      
}