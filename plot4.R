library(dplyr)
library("data.table")

filename <- "exdata_data_household_power_consumption.zip"  

# Loading the data
# Checking if the file exists
if (!file.exists("household_power_consumption.txt")) { 
    unzip(filename) 
}

data_header <- names(fread("household_power_consumption.txt",nrow=0))
print(data_header)

power <- fread("household_power_consumption.txt",
               select = c("Date","Time",
                          "Global_active_power",
                          "Global_reactive_power",
                          "Voltage",
                          "Sub_metering_1",
                          "Sub_metering_2",
                          "Sub_metering_3")
              )

powerDT <- subset(power, power$Date=="1/2/2007" | power$Date =="2/2/2007")

datetime <- strptime(paste(powerDT$Date, powerDT$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# subplot 1
plot(datetime, powerDT$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# subplot 2
plot(datetime,powerDT$Voltage, type="l", xlab="datetime", ylab="Voltage")

# subplot 3
plot(datetime, powerDT$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, powerDT$Sub_metering_2, col="red")
lines(datetime, powerDT$Sub_metering_3,col="blue")
legend("topright", 
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1),
       bty="n",
       cex=0.9
      ) 

# subplot 4
plot(datetime, powerDT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()