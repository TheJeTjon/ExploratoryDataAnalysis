# Plot3.R
# Exploratory Data Analysis - Course Project 1. 
####################################################################################################
# Prep stuff 
####################################################################################################
library (datasets)        #library for base plots

# Working dirs for different machines 
dell    <- "C:/Users/Jerry/DropBox/_Coursera/4. Exploratory Data Analysis/Week 1"
mydir   <- dell  
init  <- function(dir=mydir){setwd(dir) }
init()

####################################################################################################
# Download
####################################################################################################
downloadUrl   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFolder    <- "./data"
destFileName  <- paste (destFolder, "/exdata-data-household_power_consumption.zip", sep = "")
destZipDir    <- paste (destFolder, "/CourseProject_1", sep ="")  
dataFile      <- paste (destZipDir, "/household_power_consumption.txt", sep = "") 

# check if folder exists, if not create 
if (!file.exists(destFolder)) {dir.create(destFolder)}

# check if destination file exists, if not download  
if (!file.exists(destFileName)) {  download.file(downloadUrl, destFileName, method = "auto")}

# check if data file exists, if not unzip   
if (!file.exists(dataFile)) { unzip (destFileName, overwrite = TRUE, exdir = destZipDir) }


####################################################################################################
# Load the data 
# path: .\data\CourseProject_1\household_power_consumption.txt
# We will only be using data from the dates 2007-02-01 and 2007-02-02
# strptime() and as.Date()
####################################################################################################
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?", dec=".")

# convert Data Column to date format 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset the data 
date1 <- as.Date ("01/02/2007", format="%d/%m/%Y") 
date2 <- as.Date ("02/02/2007", format="%d/%m/%Y") 
subset_data <- subset(data, subset=(Date >= date1 & Date <= date2))

# concatenate the columns Date and Time 
subset_data$timestamp <-  as.POSIXct(paste(subset_data$Date, subset_data$Time))

#Take note of the fact that there are two types of datetime objects:  POSIXct and POSIXlt. 
# Plot 3: Plot 
# x-axis timestamp 
# y-axis: Sub_metering_1, Sub_metering_3, Sub_metering_3 
# type = l (lines)

png("plot3.png", width=480, height=480, units =  "px")

with(subset_data, {
  plot(subset_data$Sub_metering_1~subset_data$timestamp, type="l",
       ylab="Energy Sub metering", xlab="", col= "Black")
  lines(subset_data$Sub_metering_2~subset_data$timestamp,col='Red')
  lines(subset_data$Sub_metering_3~subset_data$timestamp,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
