## Set working directory
setwd("C:/Naavi/Coursera/R Working Directory")

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
dataFeb$Sub_metering_1 <- as.numeric(as.character(dataFeb$Sub_metering_1))
dataFeb$Sub_metering_2 <- as.numeric(as.character(dataFeb$Sub_metering_2))
dataFeb$Sub_metering_3 <- as.numeric(as.character(dataFeb$Sub_metering_3))

## Convert Date & Time variables to DateTime single Variable
dataFeb$DateTime <- as.POSIXct(paste(dataFeb$Date, dataFeb$Time), format="%d/%m/%Y %H:%M:%S")

## Plot the graph
with(dataFeb,{
    plot(DateTime,Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
    points(DateTime,Sub_metering_2,  type="l", col="red")
    points(DateTime,Sub_metering_3,  type="l", col="blue")
    legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=c(1,1,1))
})


png(file="./plot3.png",width=480,height=480)
## Plot the graph
with(dataFeb,{
    plot(DateTime,Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
    points(DateTime,Sub_metering_2,  type="l", col="red")
    points(DateTime,Sub_metering_3,  type="l", col="blue")
    legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=c(1,1,1))
})


dev.off()

