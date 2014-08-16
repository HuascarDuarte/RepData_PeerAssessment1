### Read and adjust data set
temp <- tempfile()
download.file(
    "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",
    temp, method="curl")
activity <- read.csv(unz(temp, "activity.csv"))
unlink(temp)

### Find out how NA values are distributed

nadistrib<-table(activity$date, is.na(activity$steps))

nadistrib

### Create a new variable with date/time format:

activity$datetime<-as.POSIXct(
    strptime(
        paste(activity$date, formatC(activity$interval, width=4, flag="0")
              ), "%Y-%m-%d %H%M"))

### NA is an "all day" thing and there are no missing values in a day with
### measurements

stepsperday<-aggregate(activity$steps, by = list(activity$date), 
                       FUN = sum, na.rm=F)
names(stepsperday)[1]<-'date'
names(stepsperday)[2]<-'steps'
mean(stepsperday$steps, na.rm=T)
median(stepsperday$steps, na.rm=T)



