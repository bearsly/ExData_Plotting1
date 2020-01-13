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
                          "Sub_metering_1",
                          "Sub_metering_2",
                          "Sub_metering_3")
              )

powerDT <- subset(power, power$Date=="1/2/2007" | power$Date =="2/2/2007")

datetime <- strptime(paste(powerDT$Date, powerDT$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


png("plot3.png", width=480, height=480)

# Plot 3
plot(datetime, powerDT$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(datetime, powerDT$Sub_metering_2,col="red")
lines(datetime, powerDT$Sub_metering_3,col="blue")
legend("topright", 
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), 
       lwd=c(1,1)
      )

dev.off()