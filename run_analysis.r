#check if samsung data folder exists
if(!file.exists("UCI HAR Dataset")){
	stop("Cannot find data file, please change working directory.")
}


#read features.txt file into data frame which contains the names of the columns of the X_*.txt files
features <- read.table("./UCI HAR Dataset/features.txt")

#change column names of features data frame
names(features) <- c("feat.id","raw.varname")

#create dataframe which is a subset of features data frame to only include values that contain that are "mean()" or "std()"
fmeanstd <- features[grep("std\\()|mean\\()",features$raw.varname),]

#remove parentheses in fmeanstd$raw.varname and store in a new column "tidy.varname"
fmeanstd$tidy.varname <- gsub("\\()","",fmeanstd$raw.varname)

#create activities data frame which lists the different activity types measured and clean up the labels and store them under a new column called "tidy.actname"
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("activity.id","raw.activity")
activities$activity <- gsub("_"," ",tolower(activities$raw.activity))

##TEST DATA
#read y_test file into data frame - this contains the activity data; name the column "act.id"
testy <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(testy) <- "activity.id"

#merge testy and activities by act.id to get activity labels
testact <- merge(testy,activities,by="activity.id")

#read subject_test.txt into data frame - this contains the subject id; name the column "subj.id"
testsubj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(testsubj) <- "subject"

#read X_test file into data frame - this contains the measurements
testx <- read.table("./UCI HAR Dataset/test/X_test.txt")

#create dataframe subtestx which is a subset of testx dataframe to only include variables that are mean() or std() and remove testx from memory
subtestx <- testx[,fmeanstd$feat.id]
remove(testx)

#change column names of subtestx, to the names listed in fmeanstd$tidy.varname
names(subtestx) <- fmeanstd$tidy.varname

#insert activity name into the cleaned up test dataset "subtestx"
subtestx <- cbind(testact$activity,subtestx)
names(subtestx)[1] <- "activity"

#insert subject id into the cleaned up test dataset "subtestx"
subtestx <- cbind(testsubj$subject,subtestx)
names(subtestx)[1] <- "subject"

##TRAIN DATA
#read y_train file into data frame - this contains the activity data; name the column "act.id"
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(trainy) <- "activity.id"

#merge trainy and activities by act.id to get activity labels
trainact <- merge(trainy,activities,by="activity.id")

#read subject_train.txt into data frame - this contains the subject id; name the column "subj.id"
trainsubj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(trainsubj) <- "subject"

#read X_train file into data frame - this contains the measurements
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt")

#create dataframe subtrainx which is a subset of trainx dataframe to only include variables that are mean() or std() and remove trainx from memory
subtrainx <- trainx[,fmeanstd$feat.id]
remove(trainx)

#change column names of subtrainx, to the names listed in fmeanstd$tidy.varname
names(subtrainx) <- fmeanstd$tidy.varname

#insert activity name into the cleaned up test dataset "subtrainx"
subtrainx <- cbind(trainact$activity,subtrainx)
names(subtrainx)[1] <- "activity"

#insert subject id into the cleaned up test dataset "subtrainx"
subtrainx <- cbind(trainsubj$subject,subtrainx)
names(subtrainx)[1] <- "subject"

#merge the clean test and train data sets into one data set
tidydataset <- merge(subtrainx,subtestx,all=T)

#write tidydataset as a csv file with .txt extension
write.csv(tidydataset,"tidydataset.txt",row.names=FALSE)

#library reshape2 is required to run the following commands
require(reshape2)

#melt tidydataset into tidymelt using subject and activity as ids
tidymelt <- melt(tidydataset,id=c("subject","activity"))

#cast tidymelt into tidycast, using mean as the aggregate function
tidycast <- dcast(tidymelt,subject+activity~variable,fun.aggregate=mean)

#write tidycast as a csv file with .txt extension
write.csv(tidycast,"tidycast.txt",row.names=FALSE)