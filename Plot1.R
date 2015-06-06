
# Plot1.R
# Exploratory Data Analysis - Course Project 1. 
# 
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
#head (data)

# convert Data Column to date format 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset the data 
date1 <- as.Date ("01/02/2007", format="%d/%m/%Y") 
date2 <- as.Date ("02/02/2007", format="%d/%m/%Y") 
subset_data <- subset(data, subset=(Date >= date1 & Date <= date2))

####################################################################################################
# Plot 1: Histogram 
# x-axis: Global Active Power
# y-axis: Frequency 
# divide var: Global_active_power/ 1000 to get kiloWatt
####################################################################################################
png("plot1.png", width=480, height=480, units =  "px")
  hist(as.numeric(subset_data$Global_active_power), 
       main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", 
       ylab="Frequency", 
       col="Red")
dev.off()# Don't forget to close the PNG device!

