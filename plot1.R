# load libraries
library(lubridate)
library(tidyverse)

# download & read data into R
if(!file.exists("hpwr.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "hpwr.zip")
}
unzip("hpwr.zip")
hpwr <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = F)

# convert Date & Time variables to classes Date & Time
# filter rows to dates specified in assignment
hpwr <- hpwr %>% mutate(Date = dmy(Date), Time = hms(Time)) %>% filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02"))

# create plot1.png
par()
with(hpwr, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", bg = "white"))
dev.copy(png, "plot1.png")
dev.off()