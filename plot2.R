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

#plot2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(selected$DTime, selected$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

