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
vehicles_in_LA <- subset(vehicles_in_NEI, fips == "06037")

######################################################################
## subset data from 1999,2002,2005 and 2008
BAvehicles1999<-subset(vehicles_in_baltimore, year == "1999")
BAvehicles2002<-subset(vehicles_in_baltimore, year == "2002")
BAvehicles2005<-subset(vehicles_in_baltimore, year == "2005")
BAvehicles2008<-subset(vehicles_in_baltimore, year == "2008")

LAvehicles1999<-subset(vehicles_in_LA, year == "1999")
LAvehicles2002<-subset(vehicles_in_LA, year == "2002")
LAvehicles2005<-subset(vehicles_in_LA, year == "2005")
LAvehicles2008<-subset(vehicles_in_LA, year == "2008")

######################################################################
## Sum of emissions for each city and give name for each object
BA1999<- sum(BAvehicles1999$Emissions)
names(BA1999)<-(1999)
BA2002<- sum(BAvehicles2002$Emissions)
names(BA2002)<-(2002)
BA2005<- sum(BAvehicles2005$Emissions)
names(BA2005)<-(2005)
BA2008<- sum(BAvehicles2008$Emissions)
names(BA2008)<-(2008)
BAsum <- c(BA1999,BA2002,BA2005,BA2008)

LA1999<- sum(LAvehicles1999$Emissions)
names(LA1999)<-(1999)
LA2002<- sum(LAvehicles2002$Emissions)
names(LA2002)<-(2002)
LA2005<- sum(LAvehicles2005$Emissions)
names(LA2005)<-(2005)
LA2008<- sum(LAvehicles2008$Emissions)
names(LA2008)<-(2008)
LAsum <- c(LA1999,LA2002,LA2005,LA2008)

######################################################################
## plot Plot6.png
png("plot6.png", width=680, height=480)
par(mfrow=c(1,2),oma = c(0, 0, 2, 0))
barplot(BAsum,
        xlab = "Year",
        ylab = "Total Emissions PM2.5 (Tons)",
        main = "Baltimore City",
        ylim = c(0,8000)
)           
barplot(LAsum,
        xlab = "Year",
        main = "Los Angeles County",
        ylim = c(0,8000)
) 
mtext("PM 2.5 Vehicle Emission in Baltimore and Los Angeles, 1999 - 2008",
      line=0, side=3, outer=TRUE, cex=1)
dev.off()


