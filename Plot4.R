# Course Poject 1
# Exploratory Data Analysis on Electric Power Consumption
# Plot 4 - 4 Charts

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
power2$Date2 <- strptime(paste(power2$Date, power2$Time, sep = ' '), '%Y-%m-%d %H:%M:%S')

## Plot
par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## 1st plot
plot(power2$Date2, power2$Global_active_power, type='l', ylab='Global Active Power', xlab='')

## 2nd plot
plot(power2$Date2, power2$Sub_metering_1, type='l', col='black', ylab='Energy sub metering', xlab='')
lines(power2$Date2, power2$Sub_metering_2, col='red')
lines(power2$Date2, power2$Sub_metering_3, col='blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 'solid', cex=0.5)

## 3rd plot
plot(power2$Date2, power2$Voltage, type='l', ylab='Voltage', xlab='datetime')

## 4th plot
plot(power2$Date2, power2$Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='datetime')
dev.copy(png, 'plot4.png', height=480, width=480)
dev.off()