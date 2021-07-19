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
## QUESTION 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make
## a plot answering this question.

######################################################################
## subset data from 1999,2002,2005 and 2008
NEI1999<-subset(NEI, year == "1999")
NEI2002<-subset(NEI, year == "2002")
NEI2005<-subset(NEI, year == "2005")
NEI2008<-subset(NEI, year == "2008")

######################################################################
## Gathering only fips = 24510 (baltimore city) emissions data of each year
balti1999 <- subset(NEI1999, fips == "24510")
balti2002 <- subset(NEI2002, fips == "24510")
balti2005 <- subset(NEI2005, fips == "24510")
balti2008 <- subset(NEI2008, fips == "24510")

######################################################################
## Sum of emissions for each year and give name for each object
baltisum1999<- sum(balti1999$Emissions)
names(baltisum1999)<-(1999)
baltisum2002<- sum(balti2002$Emissions)
names(baltisum2002)<-(2002)
baltisum2005<- sum(balti2005$Emissions)
names(baltisum2005)<-(2005)
baltisum2008<- sum(balti2008$Emissions)
names(baltisum2008)<-(2008)
allbaltisum <- c(baltisum1999,baltisum2002,baltisum2005,baltisum2008)

######################################################################
## plot Plot2.png
png("plot2.png", width=480, height=480)
plot1<-barplot((allbaltisum), 
               xlab = "Year",
               ylab = "Total Emissions PM2.5 (Tons)",
               main = "Total PM2.5 Emission in Baltimore City By Year")              
dev.off()
