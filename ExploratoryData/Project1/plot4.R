# Plot 4

library(data.table)
library(lubridate)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

sub_data <- data[data$Date %in% c("1/2/2007", "1/2/2007"), ]

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(6,5,2,6))

with(sub_data, {
  
  plot(glob ~ datetime, type = "l", xlab = "", ylab = "Global Active Power")
  plot(Voltage ~ datetime, typ = "l", ylab = "Voltage")
  
})

with(sub_data, {
  
  plot(Sub_metering_1 ~ datetime, type = "l", xlab = "", ylab = "Energy sub metering")
  
  
})

points(sub_data$Sub_metering_2 ~ datetime, col = "red", type = "l")
points(sub_data$Sub_metering_3 ~ datetime, col = "blue", type = "l")
legend("topright", lty = 1, lwd = 2.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(sub_data, plot(Global_reactive_power ~ datetime, type = "l"))

dev.off()
