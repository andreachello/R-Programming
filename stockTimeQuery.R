# A quick time-series plot and analyis on Amazon Stock using the
# quantmod library

library(data.table)
library(quantmod)
amzn = getSymbols("AMZN", auto.assign = FALSE)
amzn$AMZN.Adjusted
plot(amzn$AMZN.Adjusted)
sampleTimes = index(amzn)

# Create a datatable for the time indix of the stock
time_dt <- data.table(timeCol = sampleTimes)

#Queries:
# How many were collected in 2012
time_dt[(timeCol >= "2012-01-01") & (timeCol <= "2013-01-01"), .N]

#How many collcted on Mondays in 2012
time_dt[(timeCol >= "2012-01-01") & (timeCol <= "2013-01-01") & (weekdays(timeCol) == "Monday"), .N]
