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
## QUESTION 4
## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

######################################################################
## Subseting coal combustion-related from data
combustion <- grepl("combustion", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combustionANDcoal <- (combustion & coal)
newSCC <- SCC[combustionANDcoal,]$SCC
data <- NEI[NEI$SCC %in% newSCC,]

######################################################################
## subset data from 1999,2002,2005 and 2008
data1999<-subset(data, year == "1999")
data2002<-subset(data, year == "2002")
data2005<-subset(data, year == "2005")
data2008<-subset(data, year == "2008")

######################################################################
## Sum of emissions for each year and give name for each object
sum1999<- sum(data1999$Emissions)
names(sum1999)<-(1999)
sum2002<- sum(data2002$Emissions)
names(sum2002)<-(2002)
sum2005<- sum(data2005$Emissions)
names(sum2005)<-(2005)
sum2008<- sum(data2008$Emissions)
names(sum2008)<-(2008)
alldatasum <- c(sum1999,sum2002,sum2005,sum2008)

######################################################################
## plot Plot4.png
png("plot4.png", width=480, height=480)
barplot(alldatasum/10^5,
        xlab = "Year",
        ylab = "Total Emissions PM2.5 (Tons )",
        main = "PM 2.5 Coal Combustion Emissions Across US by Year",
        ylim = c(0,6))              
dev.off()


