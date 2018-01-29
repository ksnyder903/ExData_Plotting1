
#Read in the data
#Assumes data is in a folder called Data within the current working directory 
src = read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";")


#convert Date to class Date
src$Date = as.Date(src$Date, "%d/%m/%Y")


library(dplyr)

#limit dataset to just Feb 1,2007 and Feb 2, 2007
power = filter(src, between(Date,"2007-02-01", "2007-02-02"))

#change from a factor to a numeric
#converting from a factor TO a numeric can be tricky, 
#so we first convert factor to character and then to numeric

power$Global_active_power = as.numeric(as.character(power$Global_active_power))


#build plot number two



##add date+time to the dataset as the x-axis

power$daytime = as.POSIXct(paste(power$Date, power$Time))

##add day of week to our dataset to use as the x-axis label

power$dayname = weekdays(power$Date, abbreviate = TRUE)

png(filename = "plot2.png", 
    width = 480,
    height = 480, 
    bg = "transparent") #the file in the git repo has a transparent background, so i replicated that as well

plot(power$daytime, power$Global_active_power
     ,type = "l"
     ,xlab = ""
     ,ylab = "Global Active Power (kilowatts)"
)

dev.off()