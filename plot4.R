# Download and unzip the data file
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"./household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")

# Read the data file into a data frame
elecData <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

# Convert date and time to Date/Time classes
elecData$DT <- paste(elecData$Date, elecData$Time)
elecData$DT <- strptime(elecData$DT, "%d/%m/%Y %H:%M:%S")
elecData$Date <- as.Date(elecData$Date,format="%d/%m/%Y")

# Subset data for dates of interest
elecDataSubset <- subset(elecData,elecData$Date == as.Date("2007-02-01") 
                         | elecData$Date == as.Date("2007-02-02"))

# Open graphics device
png(filename="plot4.png", width = 480, height = 480, units = "px")

# Define plot area (2 rows and 2 columns)
par(mfrow = c(2,2))

# First plot
with(elecDataSubset, plot(DT, Global_active_power, type="l", xlab = "", 
                          ylab = "Global Active Power"))
# Second plot
with(elecDataSubset, plot(DT, Voltage, type="l", xlab = "DateTime"))

# Third plot
with(elecDataSubset, plot(DT, Sub_metering_1, type="l", xlab = "", col = "black",
                          ylab = "Energy sub metering"))
with(elecDataSubset, points(DT, Sub_metering_2, type="l", col = "red"))
with(elecDataSubset, points(DT, Sub_metering_3,type="l", col = "blue"))
legend("topright", lty = 1, cex = 0.6, bty = "n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Fourth plot
with(elecDataSubset, plot(DT,Global_reactive_power,type="l", xlab = "datetime"))

# Turn off the graphics device
dev.off()
