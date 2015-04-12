# plot2.R

library(data.table)
library(lubridate)

# Download the data file if we don't already have it.
filename <- "power_consumption.zip"
if (!file.exists(filename)) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", filename, method="curl")
    unzip(filename)
}
unzipped_file_name <- "household_power_consumption.txt"

# Read the data into data.table pc (for 'power consumption').
pc <- fread(unzipped_file_name, na.strings = "?")

# Conver Time column to date objects
pc$Time <- dmy_hms(paste(pc$Date, pc$Time))

# Convert the Date column to date objects and drop rows outside the target dates.
pc$Date <- as.Date(strptime(pc$Date, "%d/%m/%Y"))
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
pc <- pc[Date == date1 | Date == date2]

# Convert columns to numeric
pc$Global_active_power <- as.numeric(pc$Global_active_power)
pc$Global_reactive_power <- as.numeric(pc$Global_reactive_power)
pc$Global_intensity <- as.numeric(pc$Global_intensity)
pc$Voltage <- as.numeric(pc$Voltage)
pc$Sub_metering_1 <- as.numeric(pc$Sub_metering_1)
pc$Sub_metering_2 <- as.numeric(pc$Sub_metering_2)
pc$Sub_metering_3 <- as.numeric(pc$Sub_metering_3)

# plot 2
png(filename = "plot2.png",
    width = 480,
    height = 480)
plot(pc$Time, pc$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
