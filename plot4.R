library(dplyr)
library(lubridate)

rawData<-read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#get a datetime column
rawData<-mutate(rawData, DTime = paste(Date, " ",Time))
rawData$DTime<-as.POSIXct(rawData$DTime, format="%d/%m/%Y %H:%M:%S")

#get rid of unneccesary rows and columns
filtered<-filter(rawData, DTime >= "2007-02-01" & DTime < "2007-02-03")
rm(rawData)
selected<-select(filtered, c(3:10))     
rm(filtered)

#convert remaining columns
selected$Global_active_power<-as.numeric(selected$Global_active_power)
selected$Global_reactive_power<-as.numeric(selected$Global_reactive_power)
selected$Voltage<-as.numeric(selected$Voltage)
selected$Global_intensity<-as.numeric(selected$Global_intensity)
selected$Sub_metering_1<-as.numeric(selected$Sub_metering_1)
selected$Sub_metering_2<-as.numeric(selected$Sub_metering_2)
selected$Sub_metering_3<-as.numeric(selected$Sub_metering_3)

#plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

#plot (1,1) i.e. plot2
plot(selected$DTime, selected$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#plot (1,2)
plot(selected$DTime, selected$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#plot(2,1) i.e. plot3
xrange<-range((selected$DTime))
yrange<-range(selected$Sub_metering_1)
plot(xrange, yrange, type = "n", xlab = "", ylab = "Energy sub metering")
lines(selected$DTime, selected$Sub_metering_1, type = "l", col = "black")
lines(selected$DTime, selected$Sub_metering_2, type = "l", col = "red")
lines(selected$DTime, selected$Sub_metering_3, type = "l", col = "blue")

legcolors<-c("black","red","blue")
legtext<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(x = "topright", legend=legtext,  col=legcolors, lwd = c(1,1,1), bty = "n")

#plot(2,2)
plot(selected$DTime, selected$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Globa_reactive_power")

dev.off()
