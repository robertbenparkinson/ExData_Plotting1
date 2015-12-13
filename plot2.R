##Get the full data set
##Had problems trying to use "dlypr" library

hpc <- read.table("household_power_consumption.txt", sep =";", dec = ".", header = TRUE, na.strings ="?",
                  stringsAsFactors = FALSE, check.names=FALSE, comment.char="", quote='\"')

##Converted to date and saved back to itself
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

## Subsetting the data
hpc_sub <- subset(hpc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


## Converting dates
datetime <- paste(as.Date(hpc_sub$Date), hpc_sub$Time)
hpc_sub$Datetime <- as.POSIXct(datetime)

## Plot 2
plot(hpc_sub$Global_active_power~hpc_sub$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()