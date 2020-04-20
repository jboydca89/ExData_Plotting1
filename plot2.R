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

# create plot2.png
par(bg = "white", mfrow = c(1,1))
plot(hpwr$Date, hpwr$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, "plot2.png")
dev.off()