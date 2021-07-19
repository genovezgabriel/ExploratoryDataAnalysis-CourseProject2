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
## QUESTION 3
## Of the four types of sources indicated by the point, nonpoint, 
## onroad, nonroad variable, which of these four sources have seen 
## decreases in emissions from 1999–2008 for Baltimore City? Which 
## have seen increases in emissions from 1999–2008? Use the ggplot2 
## plotting system to make a plot answer this question.

library("ggplot2")
library("gridExtra")

######################################################################
## subset data from 1999,2002,2005 and 2008
NEI1999<-subset(NEI, year == "1999")
NEI2002<-subset(NEI, year == "2002")
NEI2005<-subset(NEI, year == "2005")
NEI2008<-subset(NEI, year == "2008")

######################################################################
## Gathering only fips = 24510 (baltimore city) emissions data of each year
balti <- subset(NEI, fips == "24510")
balti1999 <- subset(NEI1999, fips == "24510")
balti2002 <- subset(NEI2002, fips == "24510")
balti2005 <- subset(NEI2005, fips == "24510")
balti2008 <- subset(NEI2008, fips == "24510")

######################################################################
## preparing data
## point
balti1999_point <- subset(balti1999, type == "POINT")
balti2002_point <- subset(balti2002, type == "POINT")
balti2005_point <- subset(balti2005, type == "POINT")
balti2008_point <- subset(balti2008, type == "POINT")
allbaltipoint   <-c(sum(balti1999_point$Emissions),
                    sum(balti2002_point$Emissions),
                    sum(balti2005_point$Emissions),
                    sum(balti2008_point$Emissions))
point.df <- data.frame(
            name=c("1999","2002","2005","2008") ,  
            value=c(allbaltipoint)
)


## nonpoint
balti1999_nonpoint <- subset(balti1999, type == "NONPOINT")
balti2002_nonpoint <- subset(balti2002, type == "NONPOINT")
balti2005_nonpoint <- subset(balti2005, type == "NONPOINT")
balti2008_nonpoint <- subset(balti2008, type == "NONPOINT")
allbaltinonpoint   <-c(sum(balti1999_nonpoint$Emissions),
                       sum(balti2002_nonpoint$Emissions),
                       sum(balti2005_nonpoint$Emissions),
                       sum(balti2008_nonpoint$Emissions))
nonpoint.df <- data.frame(
  name=c("1999","2002","2005","2008") ,  
  value=c(allbaltinonpoint)
)

## onroad
balti1999_onroad <- subset(balti1999, type == "ON-ROAD")
balti2002_onroad <- subset(balti2002, type == "ON-ROAD")
balti2005_onroad <- subset(balti2005, type == "ON-ROAD")
balti2008_onroad <- subset(balti2008, type == "ON-ROAD")
allbaltionroad   <-c(sum(balti1999_onroad$Emissions),
                    sum(balti2002_onroad$Emissions),
                    sum(balti2005_onroad$Emissions),
                    sum(balti2008_onroad$Emissions))
onroad.df <- data.frame(
  name=c("1999","2002","2005","2008") ,  
  value=c(allbaltionroad)
)
## nonroad
balti1999_nonroad <- subset(balti1999, type == "NON-ROAD")
balti2002_nonroad <- subset(balti2002, type == "NON-ROAD")
balti2005_nonroad <- subset(balti2005, type == "NON-ROAD")
balti2008_nonroad <- subset(balti2008, type == "NON-ROAD")
allbaltinonroad   <-c(sum(balti1999_nonroad$Emissions),
                     sum(balti2002_nonroad$Emissions),
                     sum(balti2005_nonroad$Emissions),
                     sum(balti2008_nonroad$Emissions))
nonroad.df <- data.frame(
  name=c("1999","2002","2005","2008") ,  
  value=c(allbaltinonroad)
)

######################################################################
## create graphics

point_graph<-ggplot(point.df, aes(x=name, y=value)) + theme_bw() +
        geom_bar(stat = "identity", color="darkorange",fill="darkorange")+
  labs(
    title = "POINT",
    x = "Year",
    y = "Total Emissions PM2.5 (Tons)")+
ylim(0, 2200)

nonpoint_graph<-ggplot(nonpoint.df, aes(x=name, y=value)) + theme_bw() +
  geom_bar(stat = "identity", color="darkslategray1",fill="darkslategray1")+
  labs(
    title = "NONPOINT",
    x = "Year",
    y = "")+
  ylim(0, 2200)

onroad_graph<-ggplot(onroad.df, aes(x=name, y=value)) + theme_bw() +
  geom_bar(stat = "identity", color="darkolivegreen1",fill="darkolivegreen1")+
  labs(
    title = "ON-ROAD",
    x = "Year",
    y = "")+
  ylim(0, 2200)

nonroad_graph<-ggplot(nonroad.df, aes(x=name, y=value)) + theme_bw() +
  geom_bar(stat = "identity", color="darkorchid",fill="darkorchid")+
  labs(
    title = "NON-ROAD",
    x = "Year",
    y = "")+
  ylim(0, 2200)

######################################################################
## Gathering graphics
png("plot3.png", width=680, height=480)
grid.arrange(point_graph, nonpoint_graph, onroad_graph,nonroad_graph,
             ncol=4,
             top = "PM 2.5 Emissions in Baltimore City 1999 - 2008 by Source Type")
dev.off()
