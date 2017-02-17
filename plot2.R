## Downloading/opening zip file

if(!file.exists("./Course4Project1")){
        
        dir.create("./Course4Project1")
        
}

Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


if(!file.exists("./Course4Project1/projectData.zip")){
        
        download.file(Url,destfile="./Course4Project1/projectData.zip",
                      
                      mode = "wb")
        
}


if(!file.exists("./Course4Project1/household_power_consumption.txt")){
        
        unzip(zipfile="./Course4Project1/projectData.zip",
              
              exdir="./Course4Project1")
        
}



path <- file.path("./Course4Project1")


## Read file - Only selected rows Feb 1 and Feb 2 2007 - finding the exact rows was done separately in a database

selectedRows <- read.table(file.path(path, 
                                     
                                     "household_power_consumption.txt"),
                           
                           header = FALSE, sep = ";", nrows = 2880, 
                           
                           skip = 66637,
                           
                           na.strings = "?", stringsAsFactors = F)

## Set headers

headerRow <- read.table(file.path(path, "household_power_consumption.txt"),
                        
                        header = FALSE, sep = ";", nrows = 1)

colnames(selectedRows) <- as.character(unlist(headerRow[1,]))


## Makes new column and concatenates dates and times

selectedRows$DateAndTime <- paste(selectedRows$Date, selectedRows$Time, 
                                  
                                  sep = " " )



selectedRows$DateAndTime <- strptime(selectedRows$DateAndTime , 
                                     
                                     "%d/%m/%Y %H:%M:%S")

##Make PNG file and Plot  2

png(filename = "plot2.png",
    
    width = 480, height = 480, units = "px")

attach(selectedRows)

plot(selectedRows$DateAndTime, selectedRows$Global_active_power,
     
     type = "l",xlab = "", 
     
     ylab = "Global Active Power (kilowatts)")

detach(selectedRows)

dev.off()
