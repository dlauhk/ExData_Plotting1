# Course Poject 1
# Exploratory Data Analysis on Electric Power Consumption
# Plot 1 - Histogram on Global Active Power

# Load data
fileurl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileurl, destfile = './power.zip')
unzip('./power.zip', './household_power_consumption.txt')
power <- read.table('./household_power_consumption.txt', sep=';',header=TRUE)
power$Date <- as.Date(power$Date, '%d/%m/%Y')
power2 <- power[ which( power$Date == as.Date('01/02/2007', '%d/%m/%Y') | power$Date == as.Date('02/02/2007', '%d/%m/%Y')), ]

power2$Global_active_power <- as.numeric(power2$Global_active_power)
power2$Global_reactive_power <- as.numeric(power2$Global_reactive_power)
power2$Voltage <- as.numeric(power2$Voltage)
power2$Sub_metering_1 <- as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 <- as.numeric(power2$Sub_metering_2)
power2$Sub_metering_3 <- as.numeric(power2$Sub_metering_3)

## Plot
hist(power2$Global_active_power, main='Global Active Power', xlab = 'Global Active Power (kilowatts)', col='red')
dev.copy(png, 'plot1.png', height=480, width=480)
dev.off()