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
               select = c("Date","Global_active_power"))

powerDT <- subset(power, power$Date=="1/2/2007" | power$Date =="2/2/2007")

png("plot1.png", width=480, height=480)
hist(as.numeric(powerDT$Global_active_power),
     col  = "red",
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)")
dev.off()