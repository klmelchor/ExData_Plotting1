#Open data file and extract the required data points

data <- read.table("household_power_consumption.txt", stringsAsFactors=F, sep = ";")
colnames(data) <- data[1,]
req_data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#Change column classes to numeric since default import is character
req_data$Sub_metering_1 <- as.numeric(paste(req_data$Sub_metering_1))
req_data$Sub_metering_2 <- as.numeric(paste(req_data$Sub_metering_2))
req_data$Sub_metering_3 <- as.numeric(paste(req_data$Sub_metering_3))

#Combine date and time columns and change to POSIX format
newdt <- dmy_hms(paste(req_data$Date, req_data$Time))

#Plot 1st set of points
plot(
  newdt, 
  req_data$Sub_metering_1, 
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)

#Add 2nd and 3rd set of points respectively
lines(newdt, req_data$Sub_metering_2, col = "red", type = "l")
lines(newdt, req_data$Sub_metering_3, col = "blue", type = "l")

#Add legend to plot
legend(
  "topright", 
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
  col=c("black","red","blue"), 
  lty=1,
  y.intersp = 0.5
)

#Export to PNG
dev.copy(png, width = 480, height = 480, "plot3.png")
dev.off()
