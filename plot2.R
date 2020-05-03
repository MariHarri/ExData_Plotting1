library(lubridate)
#read in file and do some conversions and subsetting to get workable data with just the two dates
data<-read.delim('C:/Users/chris/OneDrive/Desktop/household_power_consumption.txt',header=T,sep=';')
data$fullTime<-as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,tryFormats='%d/%m/%Y')
data$Time<-hms(data$Time)
test1<-grepl('2007-02-02',data$Date)
test2<-grepl('2007-02-01',data$Date)
x1<-data[c(test1),]
x2<-data[c(test2),]
x<-rbind(x1,x2)
x$Global_active_power<-as.numeric(as.character(x$Global_active_power))
#ordered by fullTime to get weekdays on x axis
newdata<-x[order(x$fullTime),]
#create plot
plot(newdata$fullTime,newdata$Global_active_power,xlab='',ylab='Global Active Power (kilowatts)',type='l')
dev.copy(png,'plot2.png')
dev.off()
