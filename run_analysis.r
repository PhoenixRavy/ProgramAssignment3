# if needed only
#install.packages("data.table")
#install.packages("reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path <- getwd()
path

#download the zip file 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "Dataset.zip"
if (!file.exists(path)) {dir.create(path)}
download.file(url, file.path(path, f))

#decompress the zip file and make the file execute
execute <- file.path("C:", "Program Files (x86)", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", execute, "\""), parameters, paste0("\"", file.path(path, f), "\""))
system(cmd)

#put the file in the folder i created UCI HAR Dataset and  what are the available files
pathIn <- file.path(path, "UCI HAR Dataset")
list.files(pathIn, recursive=TRUE)

#read the file 
SubjectTrain <- fread(file.path(pathIn, "train", "subject_train.txt"))
SubjectTest  <- fread(file.path(pathIn, "test" , "subject_test.txt" ))
ActivityTrain <- fread(file.path(pathIn, "train", "Y_train.txt"))
ActivityTest  <- fread(file.path(pathIn, "test" , "Y_test.txt" ))
ActivityTrain <- fread(file.path(pathIn, "train", "Y_train.txt"))
ActivityTest  <- fread(file.path(pathIn, "test" , "Y_test.txt" ))

filetdt<- function (f) {
    df <- read.table(f)
    dt <- data.table(df)
}
dtTrain <- fileToDataTable(file.path(pathIn, "train", "X_train.txt"))
dtTest  <- fileToDataTable(file.path(pathIn, "test" , "X_test.txt" ))

# 1.Merges the training and the test sets to create one data set.
Subject <- rbind(SubjectTrain, SubjectTest)
setnames(dtSubject, "V1", "subject")
Activity <- rbind(ActivityTrain, ActivityTest)
setnames(Activity, "V1", "activityNum")
dt <- rbind(dtTrain, dtTest)

#merge columns
Subject <- cbind(dtSubject, Activity)
dt <- cbind(dtSubject, dt)

#define key
setkey(dt, subject, activityNum)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
Features <- fread(file.path(pathIn, "features.txt"))
setnames(Features, names(Features), c("featureNum", "featureName"))

Features <- Features[grepl("mean\\(\\)|std\\(\\)", featureName)]

#column numbers convert to a vector of variable names matching columns in 
Features$featureCode <- Features[, paste0("V", featureNum)]
head(Features)
Features$featureCode


select <- c(key(dt), Features$featureCode)
dt <- dt[, select, with=FALSE]


# 3.Uses descriptive activity names to name the activities in the data set
ActivityNames <- fread(file.path(pathIn, "activity_labels.txt"))
setnames(ActivityNames, names(ActivityNames), c("activityNum", "activityName"))

# 4.Appropriately labels the data set with descriptive variable names.
dt <- merge(dt, ActivityNames, by="activityNum", all.x=TRUE)

#define the key 
setkey(dt, subject, activityNum, activityName)

dt <- data.table(melt(dt, key(dt), variable.name="featureCode"))

#merge nam activity
dt <- merge(dt, Features[, list(featureNum, featureCode, featureName)], by="featureCode", all.x=TRUE)

dt$activity <- factor(dt$activityName)
dt$feature <- factor(dt$featureName)

grepthis <- function (regex) {
    grepl(regex, dt$feature)
}
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepthis("^t"), grepthis("^f")), ncol=nrow(y))
dt$featDomain <- factor(x %*% y, labels=c("Time", "Freq"))
x <- matrix(c(grepthis("Acc"), grepthis("Gyro")), ncol=nrow(y))
dt$featInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepthis("BodyAcc"), grepthis("GravityAcc")), ncol=nrow(y))
dt$featAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
x <- matrix(c(grepthis("mean()"), grepthis("std()")), ncol=nrow(y))
dt$featVariable <- factor(x %*% y, labels=c("Mean", "SD"))
## Features with 1 category
dt$featJerk <- factor(grepthis("Jerk"), labels=c(NA, "Jerk"))
dt$featMagnitude <- factor(grepthis("Mag"), labels=c(NA, "Magnitude"))
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepthis("-X"), grepthis("-Y"), grepthis("-Z")), ncol=nrow(y))
dt$featAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))

r1 <- nrow(dt[, .N, by=c("feature")])
r2 <- nrow(dt[, .N, by=c("featDomain", "featAcceleration", "featInstrument", "featJerk", "featMagnitude", "featVariable", "featAxis")])
r1 == r2

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
setkey(dt, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
dtTidy <- dt[, list(count = .N, average = mean(value)), by=key(dt)]

