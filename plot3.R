
#Read in the data
#Assumes data is in a folder called Data within the current working directory 
src = read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";")


#convert Date to class Date
src$Date = as.Date(src$Date, "%d/%m/%Y")


library(dplyr)

#limit dataset to just Feb 1,2007 and Feb 2, 2007
power = filter(src, between(Date,"2007-02-01", "2007-02-02"))



#construct plot 3

#need to convert the sub metering fields to numeric
power$daytime = as.POSIXct(paste(power$Date, power$Time))

#convert the sub metering values to numeric
power$Sub_metering_1 = as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 = as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 = as.numeric(as.character(power$Sub_metering_3))


#build the plot
png(filename = "plot3.png", 
    width = 480,
    height = 480, 
    bg = "transparent") #the file in the git repo has a transparent background, so i replicated that as well

plot(power$daytime, power$Sub_metering_1, 
     ylab = "Energy sub metering"
     ,xlab = "",
     col = "black", type = "l"
)
lines(power$daytime, power$Sub_metering_2, col = "red")
lines(power$daytime, power$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       
       col = c("black", "red", "blue"), lty = 1
)


dev.off()