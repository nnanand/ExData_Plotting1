#set the working directory
setwd("D:/Coursera/Analytics/Exploratory Data Analysis/wd")

#import the dplyr library
library(dplyr)

#read the data from file
householdelectricitydata <- read.delim(file="household_power_consumption.txt",header=TRUE,sep=";")

#convert the data type of Date and Time column of the data to character type
householdelectricitydata$Date <- as.character(householdelectricitydata$Date)
householdelectricitydata$Time <- as.character(householdelectricitydata$Time)

#convert the data type of Global_active_power column of the data to character type then to numeric type
householdelectricitydata$Global_active_power <- as.character(householdelectricitydata$Global_active_power)
householdelectricitydata$Global_active_power <- as.numeric(householdelectricitydata$Global_active_power)

startdate <- as.Date("2007-02-01","%Y-%m-%d")
enddate <- as.Date("2007-02-02","%Y-%m-%d")

#convert the data type of Date column to date type
householdelectricitydata$Date <- as.Date(householdelectricitydata$Date,"%d/%m/%Y")

#subset the one day data
subsetdata <- subset(householdelectricitydata,Date >= startdate & Date <= enddate) 

#Add the DateTime column by using mutate function 
subsetdatawithdatetimecol <- mutate(subsetdata,DateTime = paste(subsetdata$Date,subsetdata$Time))

#covert the new DateTime column from character to POSIXlt data type
subsetdatawithdatetimecol$DateTime <- strptime(subsetdatawithdatetimecol$DateTime,"%d/%m/%Y %H:%M:%S")

#Open png device
png(filename="plot2.png",width=480,height=480,units="px")

#plot the data
with(subsetdata,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)"))

#close png device
dev.off()
