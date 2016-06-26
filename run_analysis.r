library(dplyr)

# Download and extract the data
dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data/Assignment.zip", mode="wb")
unzip("data/Assignment.zip", exdir = "data")

# Load the features and labels
features <- read.table("data/UCI HAR Dataset/features.txt") %>% tbl_df
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt") %>% tbl_df
# Rename V1 to label_index and V2 to activity for clarity (#4)
activity_labels <- activity_labels %>% rename(label_index = V1, activity = V2)

## Read and format subject
readSubject <- function(filePath, dataset){
    subject <- read.table(filePath) %>% tbl_df
    colnames(subject) <- "subject"
    ### Add column dataset to distinguish test and train datasets
    subject$dataset <- dataset
    subject$dataset <- as.factor(subject$dataset)
    subject
}

## Read and format x_test/train
readX <- function(filePath){
    x <- read.table(filePath) %>% tbl_df
    ### Rename the columns from the feature labels (#3)
    colnames(x) <- features$V2
    ### Extract the mean and std columns (#2)
    x <- x[grepl("mean\\(\\)|std\\(\\)", colnames(x))]
    ### Remove the parentheses for readability
    colnames(x) <- gsub("\\(\\)", "", colnames(x))
    x
}

## Read and format y
readY <- function(filePath){
    y <- read.table(filePath) %>% tbl_df
    y <- y %>% rename(label_index = V1)
    ### Join the label to y-test using the label_index, then select only the activity column to keep,
    ### this provides descriptive activity names (#3)
    y <- y %>%
        left_join(activity_labels, by = c("label_index" = "label_index")) %>%
        select(activity)
}

# Assemble the test dataset
subject_test <- readSubject("data/UCI HAR Dataset/test/subject_test.txt", "test")
x_test <- readX("data/UCI HAR Dataset/test/X_test.txt")
y_test <- readY("data/UCI HAR Dataset/test/Y_test.txt")
## Join the tables by column binding
test <- cbind(subject_test, y_test, x_test) %>% tbl_df

# Assemble the train dataset
subject_train <- readSubject("data/UCI HAR Dataset/train/subject_train.txt", "train")
x_train <- readX("data/UCI HAR Dataset/train/X_train.txt")
y_train <- readY("data/UCI HAR Dataset/train/Y_train.txt")
## Join the tables by column binding
train <- cbind(subject_train, y_train, x_train) %>% tbl_df

# Join the datasets
data <- rbind(test, train)


# Tidy the dataset, by gathering the columnar features into a single column called feature
## and the values into a measurement column
library(tidyr)

tidy <- data %>% gather(feature, measurement, -subject, -dataset, -activity)
tidy <- tidy %>% separate(feature, c("feature", "estimate", "axis"), extra = "drop")
tidy <- tidy %>% 
    ### Extract elements of feature column into separate columns
    mutate(
        domain = ifelse(startsWith(feature, "t"), "time", ifelse(startsWith(feature, "f"), "frequency", "unknown")),
        source = ifelse(grepl("Body", feature), "body", ifelse(grepl("Gravity", feature), "gravity", "unknown")),
        device = ifelse(grepl("Acc", feature), "accelerometer", ifelse(grepl("Gyro", feature), "gyroscope", "unknown")),
        is_jerk = grepl("Jerk", feature),
        is_magnitude = grepl("Mag", feature)
    ) %>%
    ### Remove the feature column, it's now redundant
    select(-feature)

## Get the mean of each measurement
mean_features <- tidy %>% 
    group_by(subject, dataset, activity, estimate, axis, source, device, domain, is_jerk, is_magnitude) %>%
    summarize(
        mean = mean(measurement)
    )

write.table(mean_features, file = "data/mean_features.txt", row.names = FALSE)
