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
#create plot with first metering points, then use lines() to add other two
plot(newdata$fullTime,as.numeric(as.character(newdata$Sub_metering_1)),xlab='',ylab='Energy sub metering',type='l')
lines(newdata$fullTime,as.numeric(as.character(newdata$Sub_metering_2)),col='red')
lines(newdata$fullTime,as.numeric(as.character(newdata$Sub_metering_3)),col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,col=c('black','red','blue'))
dev.copy(png,'plot3.png')
dev.off()

