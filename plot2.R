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
png(filename="plot2.png", width = 480, height = 480, units = "px")

# Plot
with(elecDataSubset, plot(DT,Global_active_power,type="l", xlab = "", 
                          ylab = "Global Active Power (kilowatts)"))

# Turn off the graphics device
dev.off()
