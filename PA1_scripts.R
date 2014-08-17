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

stepsperday<-aggregate(activity$steps, 
                       by=list(as.Date(activity$datetime, tz="")), 
                       FUN=sum, na.rm=F)

names(stepsperday)<-c("Date", "Steps")

## Print a bar chart with the total steps taken each day
library(ggplot2)
h<-ggplot(stepsperday, aes(Date, Steps))+geom_bar(stat="identity")
print(h)


mean(stepsperday$Steps, na.rm=T)
median(stepsperday$Steps, na.rm=T)

## Average number of steps per interval
Time<-as.POSIXct(strptime(formatC(activity$interval, width=4, flag="0"), 
                          "%H%M"))

stepsperinterval<-aggregate(activity$steps, by=list(Time), FUN=mean, 
                            na.rm=TRUE)

names(stepsperinterval)<-c("Time", "Steps")




