# Unzip files from working directory
# Downloaded from http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

unzip("getdata_projectfiles_UCI HAR Dataset.zip",exdir="data")

# Libraries needed

library(data.table)  # version 1.9.2
library(reshape2)

# Set variable to select columns for features with mean and standard deviation
# as defined in features.text

featureHeaders <- read.table("data/UCI HAR Dataset/features.txt")
matchMeanStd <- c("mean\\(\\)", "std\\(\\)")
dataSelect <- grep(paste(matchMeanStd,collapse="|"), featureHeaders$V2, value=FALSE)
dataNames <- grep(paste(matchMeanStd,collapse="|"), featureHeaders$V2, value=TRUE)

# Read in files for subjects, activities, and the 33 different features
trainData.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
testData.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
trainData.activity <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
testData.activity <- read.table("data/UCI HAR Dataset/test/Y_test.txt")
trainData.features <- read.table("data/UCI HAR Dataset/train/X_train.txt")[,dataSelect]
testData.features <- read.table("data/UCI HAR Dataset/test/X_test.txt")[,dataSelect]

# Combine the data tables
tidyData1 <- rbind(cbind(trainData.subject, trainData.activity, trainData.features), cbind(testData.subject, testData.activity, testData.features))

# Rename columns
names(tidyData1) <- c("Subject","Activity", c(dataNames))

# Reencode Activity names
tidyData1$Activity[tidyData1$Activity==1] <- "Walking"
tidyData1$Activity[tidyData1$Activity==2] <- "Walking_Upstairs"
tidyData1$Activity[tidyData1$Activity==3] <- "Walking_Downstairs"
tidyData1$Activity[tidyData1$Activity==4] <- "Sitting"
tidyData1$Activity[tidyData1$Activity==5] <- "Standing"
tidyData1$Activity[tidyData1$Activity==6] <- "Laying"

# Melt data and reshape to get averages
meltedData <- melt(tidyData1, id=c("Subject","Activity"))
tidyData2 <- dcast(meltedData, Subject + Activity ~ variable, mean)

# Output data to files
# write.table(tidyData1, file = "data/tidyData1.txt", sep = ",")
# Above not needed for this assignment

write.table(tidyData2, file = "data/tidyData2.txt", sep = ",")
