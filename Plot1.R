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
## QUESTION 1
## Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot 
## showing the total PM2.5 emission from all sources for each of 
## the years 1999, 2002, 2005, and 2008.


######################################################################
## subset data from 1999,2002,2005 and 2008
NEI1999<-subset(NEI, year == "1999")
NEI2002<-subset(NEI, year == "2002")
NEI2005<-subset(NEI, year == "2005")
NEI2008<-subset(NEI, year == "2008")

######################################################################
## Gathering all emissions data of each year

emissions1999 <- NEI1999$Emissions
emissions2002 <- NEI2002$Emissions
emissions2005 <- NEI2005$Emissions
emissions2008 <- NEI2008$Emissions

######################################################################
## Sum of emissions for each year and give name for each object
sum1999<- sum(emissions1999)
names(sum1999)<-(1999)
sum2002<- sum(emissions2002)
names(sum2002)<-(2002)
sum2005<- sum(emissions2005)
names(sum2005)<-(2005)
sum2008<- sum(emissions2008)
names(sum2008)<-(2008)
allsum <- c(sum1999,sum2002,sum2005,sum2008)

## plot Plot1.png
png("plot1.png", width=480, height=480)
plot1<-barplot((allsum)/10^6, 
               xlab = "Year",
               ylab = "Total Emissions PM2.5 (10^6 Tons)",
               main = "Total PM2.5 Emission From All Sources By Year")
              
dev.off()


