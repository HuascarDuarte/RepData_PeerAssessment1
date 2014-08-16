### Read and adjust data set
homedir<-'/Users/Huascar/RR/data/'
file<-'activity.csv'
activity<-read.csv(paste0(homedir, file))

### Find out how NA values are distributed

nadistrib<-table(activity$date, is.na(activity$steps))

nadistrib

### NA is an "all day" thing and there are no missing values in a day with
### measurements

stepsperday<-aggregate(activity$steps, by = list(activity$date), 
                       FUN = sum, na.rm=F)
names(stepsperday)[1]<-'date'
names(stepsperday)[2]<-'steps'
mean(stepsperday$steps, na.rm=T)
median(stepsperday$steps, na.rm=T)



