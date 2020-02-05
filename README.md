## Course project "Getting and cleaning data"

### Files overview
Project folder consists of following files:

* `run_analysis.R` - this is R script file, which reads data, makes an analysis and produces result file.
* `CodeBook.html` - description of result file structure and data.
* `CodeBook.md` - source for `CodeBook.html`. Source is not properly formatted, so better use `CodeBook.html` for guidance.
* `README.md` - source for project description. Visible on GitHub.
* `README.html` - project description. Contains description of project, motivation and main idea.
* `LICENSE` - MIT license.
* `datasciencecoursera.Rproj` - R Studio project file.

Project work is based on [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Script expects following input data to be in project directory to produce output result:

* `UCI HAR Dataset/activity_labels.txt` - activity names paired with their indices.
* `UCI HAR Dataset/features.txt` - names of all features extracted from RAW data in original HAR research.
* `UCI HAR Dataset/test/subject_test.txt` - test part of data on subjects of activities
* `UCI HAR Dataset/test/X_test.txt` - test part of data on feature values
* `UCI HAR Dataset/test/y_test.txt` - test part of activities data
* `UCI HAR Dataset/train/subject_train.txt` - train part of data on subjects of activities
* `UCI HAR Dataset/train/X_train.txt` - train part of data on feature values
* `UCI HAR Dataset/train/y_train.txt` - train part of activities data

Script produces file `analysis_result.txt` in a project directory. 

### Script overview
Script combines data from following sources. First part of data set is a features. Second part of set is activity data, which goes in separate file. Third part of set is subject data, which also goes in separate file. Script combines these three parts of set in a similar way for both test and train data folders and than unites test and train data in one set. Now data set satisfies first requirement:
```
Merges the training and the test sets to create one data set.
```


Column with activity data transforms from indexed form to named activities. index->name transformation performed according to the dictionary `activity_labels.txt`. Names for feature columns are provided by file `features.txt`. Name for activity data column is hard coded into script: _activity_label_. Name for subject data column hard coded as well: _subject_. Now data set satisfies third and forth requirements:
```
Uses descriptive activity names to name the activities in the data set
```
```
Appropriately labels the data set with descriptive variable names. 
```
Script filters columns by name to select only mean and std features. It can be easiely done with name filtering by patterns `mean()` and `std()`. These patterns are specified in `feature_info.txt` file as labels for mean and standart deviation features. Activity data column and subject data column are preserved as well. Now data set satisfies second requirement:
```
Extracts only the measurements on the mean and standard deviation for each measurement. 
```
[Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf) paper describes a case when data table contains values in column headers and suggests melting such a table to make two new columns: one for values from column names and one for table values. In our case there are feature types in column headers of data set. Script uses `pivot_long` to melt columns headers into one column `feature_name`. Column values goes into temporal column `feature_value`. 

Script summarizes `feature_value` as last transformation to data set: it counts average of `feature_value` for each group with uniquie set of `feature_name`, `activity_label` and `subject`. Result is set into new column `average_feature_value`. Now data set satisfies fifth requirement:
```
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```
As a last step resulting data put into file `analysis_result.txt`. Description of result file you can find in `CodeBook.html`.