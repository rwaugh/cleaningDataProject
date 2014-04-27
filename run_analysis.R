# Unzip files from working directory
# Downloaded from http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

unzip("ProjectFilesDataset.zip",exdir="data")

# Libraries needed

library(data.table)  # version 1.9.2
library(reshape2)

# Set variable to select columns for features with mean and standard deviation
# as defined in features.text
dataSelect <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,345,346,347,424,425,426,503,516,529,542)

# Read in files for subjects, activities, and the 33 different features
trainData.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
testData.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
trainData.activity <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
testData.activity <- read.table("data/UCI HAR Dataset/test/Y_test.txt")
trainData.features <- read.table("data/UCI HAR Dataset/train/X_train.txt")[,dataSelect]
testData.features <- read.table("data/UCI HAR Dataset/test/X_test.txt")[,dataSelect]

# Combine the data tables
tidyData1 <- rbind(cbind(trainData.subject, trainData.activity, trainData.features), cbind(testData.subject, testData.activity, testData.features))

# Rename columns with meaningful names
names(tidyData1)[1:5] <- c("Subject","Activity","Body Accelerometer X","Body Accelerometer Y","Body Accelerometer Z")
names(tidyData1)[6:10] <- c("Gravity Accelerometer X","Gravity Accelerometer Y","Gravity Accelerometer Z","Body Accelerometer Jerk X","Body Accelerometer Jerk Y")
names(tidyData1)[11:15] <- c("Body Accelerometer Jerk Z","Body Gyroscope X","Body Gyroscope Y","Body Gyroscope Z","Body Gyroscope Jerk X")
names(tidyData1)[16:20] <- c("Body Gyrosope Jerk Y","Body Gyroscope Jerk Z","Body Accelerometer Magnitude","Gravity Accelerometer Magnitude","Body Accelerometer Jerk Magnitude")
names(tidyData1)[21:25] <- c("Body Gyroscope Magnitude","Body Gyroscope Jerk Magnitude","Fourier Body Accelerometer X","Fourier Body Accelerometer Y","Fourier Body Accelerometer Z")
names(tidyData1)[26:30] <- c("Fourier Body Accelerometer Jerk X","Fourier Body Accelerometer Jerk Y","Fourier Body Accelerometer Jerk Z","Fourier Body Gyroscope X","Fourier Body Gyroscope Y")
names(tidyData1)[31:35] <- c("Fourier Body Gyroscope Z","Fourier Body Accelerometer Magnitude","Fourier Body Accelerometer Jerk Magnitude","Fourier Body Gyroscope Magnitude","Fourier Body Gyroscope Jerk Magnitude")

# Reencode Activity names with data from activity_labels.txt
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
