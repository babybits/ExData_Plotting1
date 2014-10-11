
## Set the file Url to download the file.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tempZip <- "./data/household_power_consumption.zip"

## Download file
download.file(fileUrl,destfile=tempZip)

## Set working directory to data and unzip file
setwd("./data")
txtfile <- "household_power_consumption.txt"
unzip("household_power_consumption.zip","household_power_consumption.txt")

## Read file 
## data <- read.csv2(txtfile,header=TRUE,nrows=100)
data <- read.csv2(txtfile,header=TRUE)

## Subset the data only for the dates requested.
dataFeb <- data[data$Date == "1/2/2007"|data$Date == "2/2/2007",]

## remove data data frame, we don't need this anymore
rm(data)

## Convert the factor to characater first and then to numeric otherwise you get weird numbers.
dataFeb$Global_active_power <- as.numeric(as.character(dataFeb$Global_active_power))
dataFeb$Voltage <- as.numeric(as.character(dataFeb$Voltage))
dataFeb$Global_reactive_power <- as.numeric(as.character(dataFeb$Global_reactive_power))
dataFeb$Sub_metering_1 <- as.numeric(as.character(dataFeb$Sub_metering_1))
dataFeb$Sub_metering_2 <- as.numeric(as.character(dataFeb$Sub_metering_2))
dataFeb$Sub_metering_3 <- as.numeric(as.character(dataFeb$Sub_metering_3))

## Convert Date & Time variables to DateTime single Variable
dataFeb$DateTime <- as.POSIXct(paste(dataFeb$Date, dataFeb$Time), format="%d/%m/%Y %H:%M:%S")

png(file="./plot4.png",width=480,height=480)
par(mfrow = c(2, 2))
with(dataFeb, {
    plot(DateTime, Global_active_power,  type="l",xlab="", ylab="Global Active Power")
    plot(DateTime, Voltage,  type="l",xlab="datetime", ylab="Voltage")
    plot(DateTime,Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
    points(DateTime,Sub_metering_2,  type="l", col="red")
    points(DateTime,Sub_metering_3,  type="l", col="blue")
    legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=c(1,1,1))
    plot(DateTime, Global_reactive_power,  type="l",xlab="datetime", ylab="Global_reactive_power")
    })

dev.off()

