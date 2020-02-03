## CodeBook for course project "Getting and cleaning data"

|Variable               |Type      |Description                               |
|-----------------------|----------|------------------------------------------|
|feature_name           |character |Name of one of 561 features from UCI HAR Dataset according to file features.txt. Row represents measurement of feature specified.|
|activity_label         |character |Name of one of 6 activities, which were measured according to file activity_labels.txt. Row represents measurement while given activity takes place.|
|subject                |numeric   |Index value from 1 to 30. Each row represents measurement for one subject according to index specified.|
|average_feature_value  |numeric   |Decimal value with minimum value -0.998 and maximum value 0.975 (both rounded). Each row represents average feature value over all measurements in data set for given feature, activity and subject.|