run_analysis <- function() {
  library(readr) # to read files as tibbles
  library(dplyr) # to pipe data
  library(tidyr) # to process data
  
  # assumes files are in project directory
  activity_labels_path <- "./UCI HAR Dataset/activity_labels.txt"
  features_path <- "./UCI HAR Dataset/features.txt"
  train_features <- "./UCI HAR Dataset/train/X_train.txt"
  test_features <- "./UCI HAR Dataset/test/X_test.txt"
  train_labels <- "./UCI HAR Dataset/train/y_train.txt"
  test_labels <- "./UCI HAR Dataset/test/y_test.txt"
  train_subject <- "./UCI HAR Dataset/train/subject_train.txt"
  test_subject <- "./UCI HAR Dataset/test/subject_test.txt"
  output_file <- "./analysis_result.txt"
  
  # read data from files
  t1x <- read_table2(test_features, col_names = F)
  t1y <- read_table2(test_labels, col_names = c("activity_index"))
  t1s <- read_table2(test_subject, col_names = c("subject"))
  t2x <- read_table2(train_features, col_names = F)
  t2y <- read_table2(train_labels, col_names = c("activity_index"))
  t2s <- read_table2(train_subject, col_names = c("subject"))
  feature_names <- read_lines(features_path, skip_empty_rows = T)
  activity_labels <- read_table(
    activity_labels_path, 
    col_names = c("activity_index", "activity_label")
  )
  
  # make one set of data
  # at first binding data, activity and subject both for test and train set
  t1 <- cbind(t1x, t1y, t1s)
  t2 <- cbind(t2x, t2y, t2s)
  # and after that binding test set and train set
  features <- as_tibble(rbind(t1, t2))
  # name columns according to feature names, last two columns are named manually
  names(features) <- c(feature_names, "activity_index", "subject")
  
  result <- features %>%
    # extract mean and std features, save activity and subject
    select(activity_index, subject, contains("mean()"), contains("std()")) %>%
    # replace activity indexes with activity names
    left_join(activity_labels, by = c("activity_index")) %>%
    select(-activity_index) %>%
    select(activity_label, everything()) %>%
    # transform data to long tidy form with measure type as one of variable
    pivot_longer(
      -(activity_label:subject),
      names_to = "feature_name", 
      values_to = "feature_value"
    ) %>%
    # produce new data set according to course project task
    group_by(feature_name, activity_label, subject) %>%
    summarize(average_feature_value = mean(feature_value)) 
  
  # save data set to file
  write.table(result, file = output_file, row.names = F)
}