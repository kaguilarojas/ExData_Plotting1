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

# Create Plot 1
# Create the PNG graphic device
png("plot1.png", width=480, height=480)

#Create the histogram
hist(subset_data$Global_active_power,
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency" 
     )

# Close the graphics device
dev.off()