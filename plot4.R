

#Read in the data
#Assumes data is in a folder called Data within the current working directory 
src = read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";")


#convert Date to class Date
src$Date = as.Date(src$Date, "%d/%m/%Y")


library(dplyr)

#limit dataset to just Feb 1,2007 and Feb 2, 2007
power = filter(src, between(Date,"2007-02-01", "2007-02-02"))






#construct plot 4






##add date+time to the dataset as the x-axis

power$daytime = as.POSIXct(paste(power$Date, power$Time))

##add day of week to our dataset to use as the x-axis label

power$dayname = weekdays(power$Date, abbreviate = TRUE)



#convert all the fields we'll need for plots right here:

#change from a factor to a numeric
#converting from a factor TO a numeric can be tricky, 
#so we first convert factor to character and then to numeric

power$Global_active_power = as.numeric(as.character(power$Global_active_power))

power$Voltage = as.numeric(as.character(power$Voltage))

power$Sub_metering_1 = as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 = as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 = as.numeric(as.character(power$Sub_metering_3))

power$Global_reactive_power = as.numeric(as.character(power$Global_reactive_power))

#begin constructing the plots

#start with plot T

png("plot4_new.png")

par(mfrow = c(2,2)
    , mar = c(4,4,2,2)
    
)

#plot Top Left
plot(power$daytime, power$Global_active_power
     ,type = "l"
     ,xlab = ""
     ,ylab = "Global Active Power"
)

#plot Top Right


plot(power$daytime, power$Voltage
     , type = "l"
     , xlab = "datetime"
     , ylab = "Voltage"
)



#Plot Bottom Left

plot(power$daytime, power$Sub_metering_1, 
     ylab = "Energy sub metering"
     ,xlab = "",
     col = "black", type = "l"
)
lines(power$daytime, power$Sub_metering_2, col = "red")
lines(power$daytime, power$Sub_metering_3, col = "blue")

legend("topright",
       
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       
       col = c("black", "red", "blue"), lty = 1
       ,bty = "n"
       
)

#Plot Bottom Right

plot(power$daytime, power$Global_reactive_power
     ,type = "l"
     ,xlab = "datetime"
     ,ylab = "Global_reactive_power"
)


dev.off()
