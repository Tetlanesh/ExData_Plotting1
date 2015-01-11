library(sqldf) #only needed if using sql approach to load the file
library(data.table) #only needed if using fread/grep approach to load the file
Sys.setlocale("LC_TIME", "English") #to ensure that graphs contains english names of weekdays


#If you have non-windows system or have instaled and added grep.exe directory to your path enviromental
#variable on windows (GNU grep for Windows for example) than leave it as it is
#otherwise uncoment the read.csv.sql line and comment out the fread 
#fread/grep approach is many times faster so You may consider instaling GNU grep for Windows if on PC


#downloading and unzipping data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
unzip("household_power_consumption.zip")

#reading only two first days of february 2007 into variable
power <- fread('grep "^[12]/2/2007" household_power_consumption.txt',na.strings="?")
#power <- read.csv.sql('household_power_consumption.txt',"select * from file where Date in ('1/2/2007','2/2/2007')", sep = ';', header = T) #uncomment if cant use fread/grep

#fixing names (if using grep) and fixing date to be in proper datetime format
setnames(power,c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
date<-paste(power$Date, power$Time , sep=" ")
power$date<-as.data.frame(strptime(date, "%d/%m/%Y %H:%M:%S"))




#GENERATING PNG OF PLOT 2
png(file = "plot2.png", bg = "transparent",width = 480,height = 480)

plot(power$date, power$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")

dev.off()
