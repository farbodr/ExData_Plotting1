#Author: Fred Rahmanian
#
#call createPlots() to create all four plots for this project
#Assumptions:
# 1) You must be running this app in the ~/Projects/data-sci-spec/ExData_Plotting1. Change setWorkingDir if 
#    you want to run it in another dirs
# 2) THere is a child dir called figure in the dir where you run this
# 3) data file is in data dir (under main project dir)
#
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

createPlot2 <- function () {
  setWorkingDir()
  df <- loadData()
  png(filename = "figure/plot2.png",
      width = 480, height = 480, units = "px")
  plot(df$dateTime,df$Global_active_power, ylab='Global Active Power (kilowatts)', xlab='',type='l')
  #close the device and go back to previous device
  dev.off()  
}


