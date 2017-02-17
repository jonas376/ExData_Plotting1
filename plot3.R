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


## Read file

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

##Make PNG file and Plot 3 with legend


png(filename = "plot3.png",
    
    width = 480, height = 480, units = "px")

attach(selectedRows)

plot(selectedRows$DateAndTime ,selectedRows$Sub_metering_1,
     
     type="l",col="black", xlab = "", 
     
     ylab = "Energy sub metering")

lines(selectedRows$DateAndTime ,selectedRows$Sub_metering_2,col="red")

lines(selectedRows$DateAndTime ,selectedRows$Sub_metering_3,col="blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       
       lty = 1, col = c("black", "red", "blue") )

detach(selectedRows)

dev.off()
