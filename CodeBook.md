The run_analysis.R script performs data cleaning as described by 5 step process in course project's definition.

## Assigning data to variables:
- `test<-./test/X_test.txt`:2947 rows,561 columns
  contains recorded features test data
- `activity_test<-./test/y_test.txt`:2947 rows,1 column
  contains test data of activities code lables
- `subject_test<-./test/subject_test.txt`:2947 rows, 1 column
  contains test data of 9/30 subjects who were part of experiment
- `train<-./train/X_train.txt`:2947 rows,561 columns
  contains recorded features train data
- `activity_train<-./train/y_train.txt`:2947 rows,1 column
  contains train data of activities code lables
- `subject_train<-./train/subject_train.txt`:2947 rows, 1 column
  contains train data of 21/30 subjects who were part of experiment
- `variable_names<-features.txt`: 561 rows, 2 columns The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

## Merges the training and the test sets to create one data set
- `traintest_clubbed<-rbind(train,test)`:10,299 rows,561 columns train and test data set clubbed together through `rbind`
- `activity_clubbed<-rbind(activity_train,activity_test)`:10,299 rows,1 column activities from train and test dataset clubbed together
- `subject_clubbed<-rbind(subject_train,subject_test)`:10,299 rows,1 column subject from train and test dataset clubbed together
- `activity_test_train<-cbind(activity_clubbed,traintest_clubbed)`:10,299 rows,562 columns activity clubbed with `traintest_clubbed`
- `finaltesttrain<-cbind(subject_clubbed,activity_test_train)`:10,299 rows, 563 columns subject clubbed with `activity_test_train`

## Extracts only the measurements on the mean and standard deviation for each measurement
- `mean_sd_final` (10299 rows, 88 columns) is created by subsetting `finaltesttrain` dataset, selecting only columns: `subject`, `activity` and the measurements on the `mean` and `standard deviation` (`std`) for each measurement

## Uses descriptive activity names to name the activities in the data set
- Entire numbers in `activity` column of the `finaltesttrain` replaced with corresponding activity taken from second column of the activities variable
  then the first 2 columns i.e. `subject`,`activity` taken from `finaltesttrain` and clubbed with `mean_sd_final` to get our final dataset `tidydata`.

## Appropriately labels the data set with descriptive variable names
- All `Acc` in column’s name replaced by `Accelerometer`
- All `Gyro` in column’s name replaced by `Gyroscope`
- All `BodyBody` in column’s name replaced by `Body`
- All `Mag` in column’s name replaced by `Magnitude`
- All start with character `f` in column’s name replaced by `Frequency`
- All start with character `t` in column’s name replaced by `Time`

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- `finaldata` (180 rows, 88 columns) is created by sumarizing `tidydata` taking the `means` of each variable for each activity and each subject, after groupped by subject and activity.
- Export `finaldata` into finaldata.txt` file.
