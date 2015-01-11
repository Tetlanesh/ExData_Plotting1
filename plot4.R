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



#GENERATING PNG OF PLOT 4
png(file = "plot4.png", bg = "transparent",width = 480,height = 480)

old.par <- par(no.readonly = T) #saving default drawing settings
par(mfrow = c(2, 2), mar = c(4, 4, 2, 2),oma = c(0, 0, 0, 0))

plot(power$date, power$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")

plot(power$date, power$Voltage,type="l", xlab="datetime", ylab="Voltage", main="")

plot(power$date, power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
lines(power$date, power$Sub_metering_2, col="red")
lines(power$date, power$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

plot(power$date, power$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", main="")

par(old.par) # restoring default graphics setting

dev.off()




