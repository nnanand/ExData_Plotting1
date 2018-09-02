
#Set the working directory

setwd("D:/Coursera/Analytics/Exploratory Data Analysis/wd")
# read data from txt file
householdelectricitydata <- read.delim(file="household_power_consumption.txt",header=TRUE,sep=";")
#convert the Date column from factor class to character class
householdelectricitydata$Date <- as.character(householdelectricitydata$Date)
#convert the Date column from character class to Date class
householdelectricitydata$Date <- as.Date(householdelectricitydata$Date,format="%d/%m/%Y")
# create date object to represent February 1
date1 <- as.Date("01/01/2017",format="%d/%m/%Y")
#create date object to represent February 2
date2 <- as.Date("02/01/2017",format="%d/%m/%Y")
#subset the data using first and second date
onedayelectricitydata <- subset(householdelectricitydata,Date >= date1 & Date <= date2)
#convert the Global_active_power from factor class to numeric class
onedayelectricitydata$Global_active_power <- as.numeric(as.character(onedayelectricitydata$Global_active_power))
#open the png device
png(filename = "plot1.png",width=480,height=480,units="px")

#plot historgram
with(onedaydata,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
#close png device
dev.off()

