#Open data file and extract the required data points

data <- read.table("household_power_consumption.txt", stringsAsFactors=F, sep = ";")
colnames(data) <- data[1,]
req_data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#Change column class to numeric since default import is character
req_data$Global_active_power <- as.numeric(paste(req_data$Global_active_power))   

#Combine date and time columns and change to POSIX format
newdt <- dmy_hms(paste(req_data$Date, req_data$Time))

plot(
  newdt, 
  req_data$Global_active_power, 
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

#Export to PNG
dev.copy(png, width = 480, height = 480, "plot2.png")
dev.off()