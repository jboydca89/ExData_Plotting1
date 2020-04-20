# load libraries
library(lubridate)
library(tidyverse)

# download & read data into R
if(!file.exists("hpwr.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "hpwr.zip")
}
unzip("hpwr.zip")
hpwr <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = F)

# Combine date & time variables into Date; remove Time
# Convert Date to Date format
hpwr <- hpwr %>% mutate(Date = paste(Date,Time)) %>% select(-Time)
hpwr <- hpwr %>% mutate(Date = as.POSIXct(Date, format = "%d/%m/%Y %H:%M:%S"))
# filter proper dates
hpwr <- hpwr %>% filter(Date >= ymd("2007-02-01") & Date < ymd("2007-02-03"))

# create plot3.png
par(bg = "white")
plot(x = hpwr$Date, y = hpwr$Sub_metering_1, type = "n", main = "", xlab = "", ylab = "Energy sub metering")
with(hpwr, lines(Date, Sub_metering_1, col = "black"))
with(hpwr, lines(Date, Sub_metering_2, col = "red"))
with(hpwr, lines(Date, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.copy(png, "plot3.png")
dev.off()