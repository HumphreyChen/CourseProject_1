plot4 <- function()
{
  # for fread
  library(data.table)
  
  # fread, instead of read.table
  epcData_date <- fread("household_power_consumption.txt", select = c("Date"))
  
  # date time conversion
  epcData_date <- as.Date(epcData_date$Date, format="%d/%m/%Y")
  
  # get target rows (dates)
  targetDate <- which(epcData_date >= as.Date("2007-02-01") & epcData_date <= as.Date("2007-02-02"))
  
  # get names of columns
  header <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
  
  # get data of target dates
  impordata <- fread("household_power_consumption.txt", header=FALSE, skip = targetDate[1], nrows = targetDate[length(targetDate)]-targetDate[1]+1)
  
  # put names back
  colnames(impordata) <- unlist(header)
  
  # get date time
  datetime <- strptime(paste(impordata$Date, impordata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  
  #########################################################################
  ## Plot 4
  png("plot4.png", 480, 480)
  par(mfrow = c(2,2))
  plot(datetime, impordata$Global_active_power, type = "l", xlab="", ylab="Global Active power (kilowatts)")
  plot(datetime, impordata$Voltage, type = "l", ylab="Voltage")
  plot(datetime, impordata$Sub_metering_1, type="n", col = "black", xlab="", ylab="Global Active power (kilowatts)")
  lines(datetime, impordata$Sub_metering_1, col = "black")
  lines(datetime, impordata$Sub_metering_2, col = "red")
  lines(datetime, impordata$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=1)
  plot(datetime, impordata$Global_reactive_power, type = "l", ylab="Global_reactive_power")
  dev.off()
}