#Plot 3: Energy Sub Metering for each sub meters = Scatterplot

library(data.table)
library(lubridate)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

subsetted_data <- data[data$Date %in% c("1/2/2007", "1/2/2007"), ]

png(filename = "plot3.png", width = 480, height = 480)



with(sub_data, {
  
  plot(Sub_metering_1 ~ datetime, type = "l", xlab = "", ylab = "Energy sub metering")
  
  
})

points(sub_data$Sub_metering_2 ~ datetime, col = "red", type = "l")
points(sub_data$Sub_metering_3 ~ datetime, col = "blue", type = "l")
legend("topright", lty = 1, lwd = 2.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
