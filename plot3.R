# plot3.R
#-------------------------------------------------------------------
# Author: doug3230
# Version: 2015-09-13
# Description: This script generates a line graph of time of day versus
#              sub-metering for a household over the days of
#              2007-02-01 and 2007-02-02. There are 3 areas where
#              sub-metering is measured. They are respectively:
#              1) the kitchen, 2) the laundry room, and
#              3) the electric water heater & the air conditioner
#              Said graph is stored in the file plot3.png
#-------------------------------------------------------------------
DATA_FILE <- "household_power_consumption.txt"
TEMP_FILE <- "temp.zip"
START_LINE <- 66638
END_LINE <- 69517

#Download and unzip the data file if necessary
if (!file.exists(DATA_FILE)) {
  FILE_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(FILE_URL, destfile=TEMP_FILE)
  DATA_FILE <- unz(filename=TEMP_FILE, open="r")
}

#Read in the data
data <- read.table(DATA_FILE, header=FALSE, sep=";", na.strings="?",
                   skip=START_LINE - 1, nrows=END_LINE - START_LINE + 1)
#Add the header
colnames(data) <- colnames(read.table(DATA_FILE, header=TRUE, sep=";", nrows=1))

#Combine the dates and times together
full_times <- strptime(paste(data$Date, "-", data$Time), format="%d/%m/%Y - %H:%M:%S")

#Create png
png(filename="plot3.png", width=480, height=480, units="px")

#Add plot to png
plot(full_times, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(full_times, data$Sub_metering_2, type="l", col="red")
points(full_times, data$Sub_metering_3, type="l", col="blue")
legend("topright", col = c("black", "blue", "red"), lty=1,
       legend = c("Sub_metering_1", "Sub_metering_1", "Sub_metering_3"))

#Save to png
dev.off()

#Remove temporary file if downloaded
if (file.exists(TEMP_FILE)) {
  unlink(TEMP_FILE)
}