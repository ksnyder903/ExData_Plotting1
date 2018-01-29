



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

#build plot number one

png(filename = "plot1.png", 
    width = 480,
    height = 480, 
    bg = "transparent") #the file in the git repo has a transparent background, so i replicated that as well


hist(power$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     breaks = 12
)

dev.off()