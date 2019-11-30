
library(data.table)
library(lubridate)

# Global data table
data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

sub_data <- data[data$Date %in% c("1/2/2007", "1/2/2007"), ]

# Plot 1: Global Active Power Histogram

png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(subsetted_data$Global_active_power), col = ' red', xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
