#Open data file and extract the required data points

data <- read.table("household_power_consumption.txt", stringsAsFactors=F, sep = ";")
colnames(data) <- data[1,]
req_data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#Create histogram of Global Active Power

hist(
  as.numeric(paste(req_data$Global_active_power)),
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)

#Export to PNG
dev.copy(png, width = 480, height = 480, "plot1.png")
dev.off()