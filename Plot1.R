
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

## Plot the graph, with title and labels as specified with Red Color.
hist(dataFeb$Global_active_power, main="Global Active Power",  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Copy from screen to png file
## dev.copy(png,"./plot1.png")
dev.print(png, file="./plot1.png", width=480, height=480)

dev.off()

