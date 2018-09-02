#set the working directory
setwd("D:/Coursera/Analytics/Exploratory Data Analysis/wd")
#import the dplyr library
library(dplyr)
#read the data from file
householdelectricitydata <- read.delim(file="household_power_consumption.txt",header=TRUE,sep=";")
#convert the data type of Date and Time column of the data to character type
householdelectricitydata$Date <- as.character(householdelectricitydata$Date)
householdelectricitydata$Time <- as.character(householdelectricitydata$Time)

startdate <- as.Date("2007-02-01","%Y-%m-%d")
enddate <- as.Date("2007-02-02","%Y-%m-%d")

#convert the data type of Date column to date type
householdelectricitydata$Date <- as.Date(householdelectricitydata$Date,"%d/%m/%Y")

#subset the one day data
subsetdata <- subset(householdelectricitydata,Date >= startdate & Date <= enddate)

#convert the data type of columns of the subset data to numeric type
subsetdata$Global_active_power <- as.character(subsetdata$Global_active_power)
subsetdata$Global_active_power <- as.numeric(subsetdata$Global_active_power)
subsetdata$Voltage <- as.character(subsetdata$Voltage)
subsetdata$Voltage <- as.numeric(subsetdata$Voltage)
subsetdata$Sub_metering_1 <- as.character(subsetdata$Sub_metering_1)
subsetdata$Sub_metering_1 <- as.numeric(subsetdata$Sub_metering_1)
subsetdata$Sub_metering_2 <- as.character(subsetdata$Sub_metering_2)
subsetdata$Sub_metering_2 <- as.numeric(subsetdata$Sub_metering_2)
subsetdata$Sub_metering_3 <- as.character(subsetdata$Sub_metering_3)
subsetdata$Sub_metering_3 <- as.numeric(subsetdata$Sub_metering_3)
subsetdata$Global_reactive_power <- as.character(subsetdata$Global_reactive_power)
subsetdata$Global_reactive_power <- as.numeric(subsetdata$Global_reactive_power)

#Add the DateTime column by using mutate function 
subsetdatawithdatetimecol <- mutate(subsetdata,DateTime = paste(subsetdata$Date,subsetdata$Time))
#covert the new DateTime column from character to POSIXlt data type
subsetdatawithdatetimecol$DateTime <- strptime(subsetdatawithdatetimecol$DateTime,"%d/%m/%Y %H:%M:%S")

#Open png device
png(filename="plot4.png",width=480,height=480,units="px")
#set the parameters to draw plots in 2 rows and 2 columns
par(mfrow=c(2,2))
#plot the data row wise
with(subsetdatawithdatetimecol,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(subsetdatawithdatetimecol,plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(subsetdatawithdatetimecol,plot(DateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
points(subsetdatawithdatetimecol$DateTime,subsetdatawithdatetimecol$Sub_metering_1,type="l")
points(subsetdatawithdatetimecol$DateTime,subsetdatawithdatetimecol$Sub_metering_2,type="l",col="red")
points(subsetdatawithdatetimecol$DateTime,subsetdatawithdatetimecol$Sub_metering_3,type="l",col="blue")
legend(x="topright",col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.7)
with(subsetdatawithdatetimecol,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))
#close png device
dev.off()