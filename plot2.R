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
               select = c("Date","Time","Global_active_power"))

powerDT <- subset(power, power$Date=="1/2/2007" | power$Date =="2/2/2007")

datetime <- strptime(paste(powerDT$Date, powerDT$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalActivePower <- as.numeric(powerDT$Global_active_power)

png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, 
	type="l", 
	xlab="", 
	ylab="Global Active Power (kilowatts)")
dev.off()