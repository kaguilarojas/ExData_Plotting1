# Read the full .txt document, assumes the data file is on the same folder as the script

full_data <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        colClasses = c("character", "character", rep("numeric",7)), 
                        na = "?")

# Convert Date
full_data$Date <- as.Date(full_data$Date, format="%d/%m/%Y")

# Get data only for the specified dates
subset_data <- subset(full_data, Date=="2007-02-01" | Date=="2007-02-02")

# Merges Date and Time
date_time <- paste(as.Date(subset_data$Date), subset_data$Time)

# Convert DateTime
subset_data$Datetime <- strptime(date_time, format="%Y-%m-%d %H:%M:%S")

# Create Plot 4
# Create the PNG graphic device
png("plot4.png", width=480, height=480)

# Create the plot
# Create the 2x2 matrix for the plots
par(mfrow=c(2,2))

# First plot - top left
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power"
     )

# Second plot - top right
plot(subset_data$Datetime, subset_data$Voltage, 
     type="l",
     xlab="datetime",
     ylab="Voltage"
     )

# Third plot - Bottom left
plot(subset_data$Datetime, subset_data$Sub_metering_1, 
     type="l",
     xlab="",
     ylab="Energy sub metering"
     )

lines(subset_data$Datetime, subset_data$Sub_metering_2, col="red")

lines(subset_data$Datetime, subset_data$Sub_metering_3, col="blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lwd=1,
       bty="n"
       )

# Fourth plot - Bottom right
plot(subset_data$Datetime, subset_data$Global_reactive_power, 
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power"
     )

# Close the graphics device
dev.off()