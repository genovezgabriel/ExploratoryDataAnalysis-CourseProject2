######################################################################
# Creating data file in ".Rproj" and downloading the data
dir.create("./ExpDataAna_W4")
onlinefile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(onlinefile,destfile="./ExpDataAna_W4/data.zip",method="curl")
unzip(zipfile="./ExpDataAna_W4/data.zip",exdir="./ExpDataAna_W4")

######################################################################
## read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

######################################################################
## QUESTION 5
## How have emissions from motor vehicle sources changed from 1999–2008
## in Baltimore City?

######################################################################
## Subseting  vehicles related from data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_in_SCC <- SCC[vehicles,]$SCC
vehicles_in_NEI <- NEI[NEI$SCC %in% vehicles_in_SCC,]

######################################################################
## vehicles related in Baltimore City
vehicles_in_baltimore <- subset(vehicles_in_NEI, fips == "24510")

######################################################################
## subset data from 1999,2002,2005 and 2008
vehicles1999<-subset(vehicles_in_baltimore, year == "1999")
vehicles2002<-subset(vehicles_in_baltimore, year == "2002")
vehicles2005<-subset(vehicles_in_baltimore, year == "2005")
vehicles2008<-subset(vehicles_in_baltimore, year == "2008")

######################################################################
## Sum of emissions for each year and give name for each object
vehiclessum1999<- sum(vehicles1999$Emissions)
names(vehiclessum1999)<-(1999)
vehiclessum2002<- sum(vehicles2002$Emissions)
names(vehiclessum2002)<-(2002)
vehiclessum2005<- sum(vehicles2005$Emissions)
names(vehiclessum2005)<-(2005)
vehiclessum2008<- sum(vehicles2008$Emissions)
names(vehiclessum2008)<-(2008)
allvehiclessum <- c(vehiclessum1999,vehiclessum2002,vehiclessum2005,vehiclessum2008)

######################################################################
## plot Plot5.png
png("plot5.png", width=480, height=480)
barplot(allvehiclessum,
        xlab = "Year",
        ylab = "Total Emissions PM2.5 (Tons)",
        main = "PM 2.5 Vehicle Emissions in Baltimore by Year"
        )              
dev.off()


