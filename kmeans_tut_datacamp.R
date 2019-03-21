# k-mean clustering examples
# tutorial from https://www.datacamp.com/community/tutorials/k-means-clustering-r

library(dplyr)

setwd("C:/Users/u115136/Documents/CAS-DA-Notes/Data Mining/exercise/dataMining/")
getwd()

apr14 <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/uber-tlc-foil-response/master/uber-trip-data/uber-raw-data-apr14.csv")
may14 <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/uber-tlc-foil-response/master/uber-trip-data/uber-raw-data-may14.csv")
jun14 <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/uber-tlc-foil-response/master/uber-trip-data/uber-raw-data-jun14.csv")
jul14 <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/uber-tlc-foil-response/master/uber-trip-data/uber-raw-data-jul14.csv")
aug14 <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/uber-tlc-foil-response/master/uber-trip-data/uber-raw-data-aug14.csv")
sep14 <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/uber-tlc-foil-response/master/uber-trip-data/uber-raw-data-sep14.csv")

head(apr14)
head(may14)
head(jun14)
head(jul14)
head(aug14)
head(sep14)

data14 <- bind_rows(apr14, may14, jun14, jul14, aug14, sep14)

head(data14)
nrow(data14)

# VIM library for using 'aggr'
install.packages("VIM")
library(VIM)

# 'aggr' plots the amount of missing/imputed values in each column
aggr(data14)


install.packages("lubridate")
library(lubridate)

# Separate or mutate the Date/Time columns
data14$Date.Time <- mdy_hms(data14$Date.Time)
data14$Year <- factor(year(data14$Date.Time))
data14$Month <- factor(month(data14$Date.Time))
data14$Day <- factor(day(data14$Date.Time))
data14$Weekday <- factor(wday(data14$Date.Time))
data14$Hour <- factor(hour(data14$Date.Time))
data14$Minute <- factor(minute(data14$Date.Time))
data14$Second <- factor(second(data14$Date.Time))

head(data14)

# k-means clustering
set.seed(20)
clusters <- kmeans(data14[,2:3], 5)
str(clusters)

install.packages("ggmap")
library(ggmap)

NYCMap <- get_map("New York", zoom = 10)
ggmap(NYCMap) + geom_point(aes(x = Lon[], y = Lat[], colour = as.factor(Borough)),data = data14) +
  ggtitle("NYC Boroughs using KMean")


install.packages("DT")
library(DT)
data14$Month <- as.double(data14$Month)
head(data14)

data14$Month <- as.double(data14$Month)

month_borough_14 <- count_(data14, vars = c('Month', 'Borough'), sort = TRUE) %>% 
  arrange(Month, Borough)

datatable(month_borough_14)
