
#Downloading the datasets from the given URL.
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url,destfile = "proj_data.zip",method = "curl")
#Listing the file in order to verify the download
list.files(".")

#Checking if the folder exists inside the zip and unzipping it.
if(!file.exists("UCI HAR Dataset")){
  unzip("proj_data.zip")
}

#reading the activity labels and features dataset
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# converting the column having names in above datasets into character type
activity[,2] <- as.character(activity[,2])
features[,2] <- as.character(features[,2])

#Cleaning the feature data to make it meaningful and understandable
featuresNeeded <- grep(".*std.*|.*mean.*",features[,2])
featuresNeeded.names <- features[featuresNeeded,2]
featuresNeeded.names <- gsub("-mean","Mean",featuresNeeded.names)
featuresNeeded.names <- gsub("-std","Std",featuresNeeded.names)
featuresNeeded.names <- gsub("[-()]","",featuresNeeded.names)

#Loading the training Data

# Extracting only the features which we need from the datsets
trainActivity_X <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresNeeded]
trainActivity_Y <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Merging the training datasets first
trainData <- cbind(trainSubject,trainActivity_Y,trainActivity_X)

#Loading the Test Data

# Extracting only the required features from the dataset
testActivity_X <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresNeeded]
testActivity_Y <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merging the Test  Datasets 
testData <- cbind(testSubject,testActivity_Y,testActivity_X)


# Now merging both the test and train datasets
test_and_train_data <- rbind(trainData,testData)
colnames(test_and_train_data) <- c("Subject","Activity",featuresNeeded.names)

# factoring the Activity and Subject Data in order to froup the data w.r.t Activity and Subject
test_and_train_data$Activity <- factor(test_and_train_data$Activity,levels = activity[,1],labels = activity[,2])
test_and_train_data$Subject <- as.factor(test_and_train_data$Subject)

# Aggregating the Data for each group of activity in a subject
mean_data <- aggregate(test_and_train_data, by=list(activity = test_and_train_data$Activity, subject=test_and_train_data$Subject), mean)
mean_data[,"Subject"] = NULL
mean_data[,"Activity"] = NULL
cleanandReadyData <- mean_data

write.table(cleanandReadyData,"clean_data.txt",sep = "\t")


