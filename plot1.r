#librarys
library(data.table)
library(dplyr)
library(readr)
#library(sqldf)

#file url and download and unzip
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./exdata_data_household_power_consumption.zip")) {
        mydir<- paste0(getwd(),"/","exdata_data_household_power_consumption.zip")
        download.file(fileUrl, destfile = mydir)
        unzip("./exdata_data_household_power_consumption.zip")
}
#reading files
pow<- read_csv2("./household_power_consumption.txt")

#convert Date column from char to date formate
pow$Date <- as.Date(pow$Date, format = "%d/%m/%Y")
 
#filter out by data
febpow<- filter(pow, Date >= "2007-02-01", Date < "2007-02-03" )

#convert columns to numeric for graphing took to 
#long to try and figure it out while reading read_csv
febpow$Global_active_power <- as.numeric(febpow$Global_active_power)
febpow$Global_reactive_power <- as.numeric(febpow$Global_reactive_power)
febpow$Global_intensity <- as.numeric(febpow$Global_intensity)
febpow$Sub_metering_1 <- as.numeric(febpow$Sub_metering_1)
febpow$Sub_metering_2 <- as.numeric(febpow$Sub_metering_2)
febpow$Sub_metering_3 <- as.numeric(febpow$Sub_metering_3)

#create histogram file
#open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")
# create plot and send to file
hist(febpow$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
#close png device
dev.off()

#plot histogram on regular grafix device just for fun
hist(febpow$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")


