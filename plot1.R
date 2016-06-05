plot1 <- function()
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
  ## Plot 1
  png("plot1.png", 480, 480)
  hist(impordata$Global_active_power, col="red", xlab="Global Active power (kilowatts)", main = "Global Active power")
  dev.off()
}