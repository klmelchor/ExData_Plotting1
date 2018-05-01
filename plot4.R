#Open data file and extract the required data points

data <- read.table("household_power_consumption.txt", stringsAsFactors=F, sep = ";")
colnames(data) <- data[1,]
req_data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#Combine date and time columns and change to POSIX format
newdt <- dmy_hms(paste(req_data$Date, req_data$Time))

#Open PNG as graphics device, dev.copy has some issues with regards to legend sizing
png(width = 480, height = 480, file = "plot4.png")

#Set plot matrix to accommodate 4 different plots
par(mfcol = c(2,2))

#Plot (1,1)
plot(
  newdt, 
  req_data$Global_active_power, 
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

#Plot (2,1)
plot(
  newdt, 
  req_data$Sub_metering_1, 
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)

lines(newdt, req_data$Sub_metering_2, col = "red", type = "l")
lines(newdt, req_data$Sub_metering_3, col = "blue", type = "l")

legend(
  "topright",
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
  col=c("black","red","blue"), 
  lty=1,
  bty = "n"
)

#Plot (1,2)
req_data$Voltage <- as.numeric(paste(req_data$Voltage))
plot(
  newdt, 
  req_data$Voltage, 
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

#Plot (2,2)
req_data$Global_reactive_power <- as.numeric(paste(req_data$Global_reactive_power))
plot(
  newdt, 
  req_data$Global_reactive_power, 
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

#Close current graphics device
dev.off()


