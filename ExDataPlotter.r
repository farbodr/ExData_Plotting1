#Author: Fred Rahmanian
#
#call createPlots() to create all four plots for this project
#Assumptions:
# 1) You must be running this app in the ~/Projects/data-sci-spec/ExData_Plotting1. Change setWorkingDir if 
#    you want to run it in another dirs
# 2) THere is a child dir called figure in the dir where you run this
# 3) data file is in data dir (under main project dir)
#
# for faster testing if you can load the dataframe once and then call createPlotx(df) method and pass the data frame to it
#

setWorkingDir <- function()  {
  if (Sys.info()['sysname'] == 'Darwin') {
    setwd("~/Projects/data-sci-spec/ExData_Plotting1")
  }else {
    setwd("D:/Projects/data-sci-spec/ExData_Plotting1")
  } 
}

loadData <- function() {
  #create a method to format the date during load since it is not in yyyy-mm-dd
  setClass("mdyDate")
  setAs("character","mdyDate", function(from) as.Date(from, format="%d/%m/%Y") )
  df <- read.csv(file='data/household_power_consumption.txt', header=T, sep=';', na.strings=c("?"),
           colClasses=c("mdyDate", "character", rep("numeric", 7)))
  #subset the data only for the days we need for this project         
  df <- subset(df, Date >= '2007-02-01' & Date <= '2007-02-02')
  #create date time column. Need this for plot2
  df$dateTime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
  return(df)
}

createPlot1 <- function (df) {
  print('creating plot1...')
  png(filename = "figure/plot1.png",
        width = 480, height = 480, units = "px")
  hist(df$Global_active_power, xlab='Global Active Power (kilowatts)', main='Global Active Power', col='red')
  dev.off()
}

createPlot2 <- function (df) {
  print('creating plot2...')
  png(filename = "figure/plot2.png",
      width = 480, height = 480, units = "px")
  plot(df$dateTime,df$Global_active_power, ylab='Global Active Power (kilowatts)', xlab='',type='l')
  #close the device and go back to previous device
  dev.off()  
}

createPlot3 <- function (df) {
  print('creating plot3...')
  png(filename = "figure/plot3.png",
      width = 480, height = 480, units = "px")
  plot(df$dateTime,df$Sub_metering_1, ylab='Energy sub metering', xlab='',type='l')
  lines(df$dateTime,df$Sub_metering_2, ylab='Energy sub metering', xlab='',type='l', col='red')
  lines(df$dateTime,df$Sub_metering_3, ylab='Energy sub metering', xlab='',type='l', col='blue')
  legend("topright", col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1)
  dev.off()
  
}

createPlot4 <- function (df) {
  print('creating plot4...')

  png(filename = "figure/plot4.png",
      width = 480, height = 480, units = "px")
  
  par(mfrow = c(2, 2))

  plot(df$dateTime,df$Global_active_power, ylab='Global Active Power', xlab='',type='l')

  plot(df$dateTime,df$Voltage, ylab='Voltage', xlab='datetime', type='l')
  
  plot(df$dateTime,df$Sub_metering_1, ylab='Energy sub metering', xlab='',type='l')
  lines(df$dateTime,df$Sub_metering_2, ylab='Energy sub metering', xlab='',type='l', col='red')
  lines(df$dateTime,df$Sub_metering_3, ylab='Energy sub metering', xlab='',type='l', col='blue')
  legend("topright", col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1, bty='n')
  
  plot(df$dateTime,df$Global_reactive_power, ylab='Global_reactive_power', xlab='datetime',type='l')
  
  dev.off()
  
}

createPlots <- function() {
  setWorkingDir()
  df <- loadData()
  createPlot1(df)
  createPlot2(df)
  createPlot3(df)
  createPlot4(df)
}