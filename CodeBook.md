
# Here is an apercu of the data 

## str(TidyData)
Classes ‘data.table’ and 'data.frame':	11880 obs. of  11 variables:
 $ subject         : int  1 1 1 1 1 1 1 1 1 1 ... (ID the subject who performed the activity for each window sample. Its range is from 1 to 30.)
 $ activity        : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ... (Activity name)
 $ featDomain      : Factor w/ 2 levels "Time","Freq": 1 1 1 1 1 1 1 1 1 1 ... (Time domain signal or frequency domain signal (Time or Freq))
 $ featAcceleration: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ... (Acceleration signal (Body or Gravity)) 
 $ featInstrument  : Factor w/ 2 levels "Accelerometer",..: 2 2 2 2 2 2 2 2 2 2 ...(Measuring instrument)
 $ featJerk        : Factor w/ 2 levels NA,"Jerk": 1 1 1 1 1 1 1 1 2 2 ... (Feature: Jerk signal)
 $ featMagnitude   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 2 2 1 1 ... (Magnitude of the signals calculated using the Euclidean norm)
 $ featVariable    : Factor w/ 2 levels "Mean","SD": 1 1 1 2 2 2 1 2 1 1 ... (Variable (Mean or SD))
 $ featAxis        : Factor w/ 4 levels NA,"X","Y","Z": 2 3 4 2 3 4 1 1 2 3 ... (3-axial signals in the X, Y and Z directions (X, Y, or Z))
 $ count           : int  50 50 50 50 50 50 50 50 50 50 ... (Count of data points used to compute average)
 $ average         : num  -0.0166 -0.0645 0.1487 -0.8735 -0.9511 ... (Average of each variable for each activity and each subject)
 - attr(*, "sorted")= chr  "subject" "activity" "featDomain" "featAcceleration" ...
 - attr(*, ".internal.selfref")=<externalptr> 
 
 
## key(TidyData)
[1] "subject"          "activity"         "featDomain"       "featAcceleration" "featInstrument"  
[6] "featJerk"         "featMagnitude"    "featVariable"     "featAxis" 

## TidyData
       subject         activity featDomain featAcceleration featInstrument featJerk featMagnitude
    1:       1           LAYING       Time               NA      Gyroscope       NA            NA
    2:       1           LAYING       Time               NA      Gyroscope       NA            NA
    3:       1           LAYING       Time               NA      Gyroscope       NA            NA
    4:       1           LAYING       Time               NA      Gyroscope       NA            NA
    5:       1           LAYING       Time               NA      Gyroscope       NA            NA
   ---                                                                                           
11876:      30 WALKING_UPSTAIRS       Freq             Body  Accelerometer     Jerk            NA
11877:      30 WALKING_UPSTAIRS       Freq             Body  Accelerometer     Jerk            NA
11878:      30 WALKING_UPSTAIRS       Freq             Body  Accelerometer     Jerk            NA
11879:      30 WALKING_UPSTAIRS       Freq             Body  Accelerometer     Jerk     Magnitude
11880:      30 WALKING_UPSTAIRS       Freq             Body  Accelerometer     Jerk     Magnitude
       featVariable featAxis count     average
    1:         Mean        X    50 -0.01655309
    2:         Mean        Y    50 -0.06448612
    3:         Mean        Z    50  0.14868944
    4:           SD        X    50 -0.87354387
    5:           SD        Y    50 -0.95109044
   ---                                        
11876:           SD        X    65 -0.56156521
11877:           SD        Y    65 -0.61082660
11878:           SD        Z    65 -0.78475388
11879:         Mean       NA    65 -0.54978489
11880:           SD       NA    65 -0.58087813

## summary(TidyData)
    subject                   activity    featDomain  featAcceleration       featInstrument featJerk   
 Min.   : 1.0   LAYING            :1980   Time:7200   NA     :4680     Accelerometer:7200   NA  :7200  
 1st Qu.: 8.0   SITTING           :1980   Freq:4680   Body   :5760     Gyroscope    :4680   Jerk:4680  
 Median :15.5   STANDING          :1980               Gravity:1440                                     
 Mean   :15.5   WALKING           :1980                                                                
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                                                                
 Max.   :30.0   WALKING_UPSTAIRS  :1980                                                                
   featMagnitude  featVariable featAxis      count          average        
 NA       :8640   Mean:5940    NA:3240   Min.   :36.00   Min.   :-0.99767  
 Magnitude:3240   SD  :5940    X :2880   1st Qu.:49.00   1st Qu.:-0.96205  
                               Y :2880   Median :54.50   Median :-0.46989  
                               Z :2880   Mean   :57.22   Mean   :-0.48436  
                                         3rd Qu.:63.25   3rd Qu.:-0.07836  
                                         Max.   :95.00   Max.   : 0.97451  

