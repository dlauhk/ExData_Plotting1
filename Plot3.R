# Course Poject 1
# Exploratory Data Analysis on Electric Power Consumption
# Plot 3 - Line Chart on Energy Sub Metering

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
par(mfrow=c(1, 1))
plot(power2$Date2, power2$Sub_metering_1, type='l', col='black', ylab='Energy sub metering', xlab='')
lines(power2$Date2, power2$Sub_metering_2, col='red')
lines(power2$Date2, power2$Sub_metering_3, col='blue')
legend('topright', cex=0.8, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 'solid')
dev.copy(png, 'plot3.png', height=480, width=480)
dev.off()