##PLOT 3

##load key libraries
library(dplyr)
library(R.utils)

##file url
u <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##check and download household power consumptin  file 
if (!file.exists("household_power_consumption.zip")) {
  download.file(u, destfile = "household_power_consumption.zip") 
}

##unzip file
unz("household_power_consumption.zip") 

##read file
hpc <- read.table("household_power_consumption.txt", sep =";", dec = ".", 
                  header = TRUE, na.strings ="?", stringsAsFactors = FALSE, 
                  check.names=FALSE, comment.char="", quote='\"')

##Converted to date and saved back to itself
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

## Subsetting the data
hpc_sub <- subset(hpc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


## Converting dates
datetime <- paste(as.Date(hpc_sub$Date), hpc_sub$Time)
hpc_sub$Datetime <- as.POSIXct(datetime)

## Plot 3
with(hpc_sub, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()