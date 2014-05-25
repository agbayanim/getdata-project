tidydataset Code Book
=====================

Experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, data captured was 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these signals, the prefix 'f' indicate frequency domain signals.

**The way the variables are named follow the pattern of:**

1. *t* denotes time-domain measurements, and *f* denotes frequency domain signals
2. *Body* denotes body acceleration signals, *Gravity* denotes gravity acceleration signals
3. *Acc* denotes signals from the accelerometer, *Gyro* denotes signals from the gyroscope
4. *Jerk* denotes the jerk signals obtained, *Mag* denotes the magnitude of the signals calculated using the Euclidean norm.
5. *mean* denotes the estimated mean values, *std* denotes the estimated standard deviation values
6. *X*, *Y*, And *Z* are the three different axial measurements.

**The transformations made from the original data set are as follows: (Note: these steps are performed automatically using run_analysis.r script file)**

1. Use the file features.txt as the headers for the X_train.txt and X_test.txt data files
2. Subset the X_train and X_test dataframes to only include the columns that contain *mean()* and *std()* in the names
3. Change the column names of the X_train and X_test dataframes to remove the parentheses
4. Use the file activity_labels.txt to convert the values in y_train.txt and y_test.txt
5. Insert the converted y_train and y_test dataframes as columns in the x_train and x_test dataframes, and call this column *activity*
6. Insert subject_train.txt as a column to X_train dataframe and subject_test.txt as a column to X_test dataframe, and call this column *subject*
7. Merge X_train and X_test dataframes into one dataframe and export as a csv file

**To create the second dataset from the tidyset above: (Note: these steps are performed at the end of the run_analysis.r script file)**

1. The package **reshape2** is required for this part
2. Melt the tidy data set created above using *subject* and *activity* as ids
3. Cast the melted data set using *mean* as the aggregating function
4. Write this data set into a csv file



