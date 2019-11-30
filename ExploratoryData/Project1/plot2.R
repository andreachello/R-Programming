# Plot 2: Global Active Power Scatterplot

library(data.table)
library(lubridate)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

sub_data <- data[data$Date %in% c("1/2/2007", "1/2/2007"), ]

glob <- sub_data$Global_active_power
dates <- as.Date(sub_data$Date, format = "%d/%m/%Y")
datetime <- as.POSIXct(paste(dates, sub_data$Time))



png(filename = "plot2.png", width = 480, height = 480)
with(sub_data, plot(glob ~ datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts"))
dev.off()
