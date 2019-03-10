library(dplyr)
library(foreign)
library(stringr)

ebay <- read.dta("http://www.farys.org/daten/ebay.dta")
ebay


mtcars
dplyr::filter(mtcars, !grepl('Toyota'))

?base::grepl


titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

head(titanic)

# filter
filter(titanic, class == "1st class", sex=="women" )


#a)

rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'))
View(rawLog)
class(rawLog)
head(rawLog)

colnames(rawLog) <- c("text")
filter(rawLog, vars_select(text, contains("GET")))

name <- c("Rudi","Simon","Daniela","Viktor") 
df <- as.data.frame(name)
df
class(fdf)
fdf

filter(df, grepl("R", name, ignore.case = T))


str_replace("nicolas", "i", "x")
str_remove("nicolas", "i")

str_replace(name, "i", "x")
str_remove(name, "i")


name2 <- c("Rudi[employee]","Simon[employee]","Daniela[director]","Viktor[extern]") 
str_remove(name2, "\\[.*\\]")

str_remove(name2, "-\\[")
str_remove(name2, ".*\\[")

      # Wetterdaten 
      weather <- read.table("https://raw.githubusercontent.com/justmarkham/tidy-data/master/data/weather.txt") 
      
      head(weather) 
      
      # hier sind Variablen in Zeilen und Spalten
      # Daten reshapen (melt) und Missings löschen 
      library(reshape2) 
      # für melt()/dcast() 
      weather1 <- melt(weather, id=c("id", "year", "month", "element"), na.rm=TRUE) 
      head(weather1)
      # saubere Spalte für "day" 
      library(stringr)
      # für str_replace(), str_sub() 
      weather1$day <- as.integer(str_replace(weather1$variable, "d", ""))
      # die krude Spalte "variable" brauchen wir nicht 
      weather1$variable <- NULL
      # die Spalte element beherbergt zwei unterschiedliche Variablen tmin und tmax. 
      # Diese sollen in zwei Spalten: 
      weather1$element <- tolower(weather1$element) 
      # Kleinbuchstaben 
      weather.tidy <- dcast(weather1, ... ~ element) 
      
      ?melt
      # reshapen auf zwei Spalten 
      head(weather.tidy)
      
      airquality
      head(airquality)
      names(airquality) = tolower(names(airquality))
      melt(airquality, id = c("month", "day"))

# split strings  
      
val1 <- c("1,2,3", "22,33,44", "11,22,33", "9,8,7") 
tmpval1 <- unlist(strsplit(val1, split=","))
tmpval1
list <- unlist(strsplit("a b c", split=" "))
list
class(list)
list[1]

valdf <- data.frame(val1)
valdf
    
nrow(valdf)      

valdf
valdf$val1
class(valdf$val1)

valdf$one[1] <- 33

unlist(strsplit(as.character(valdf$val1[1]), split=","))

x <- as.character(valdf$val1[1])

x

for (i in 1:nrow(valdf)){
  tmpchar <- unlist(strsplit(as.character(valdf$val1[i]), split=","))
  valdf$one[i] <- tmpchar[1]
  valdf$two[i] <- tmpchar[2]
  valdf$three[i] <- tmpchar[3]
}

valdf

head(tmp3)
colnames(tmp3) <- "rawText"
tmp3[1,]
x <- str_remove_all(tmp3$rawText[1], ",")
x

tmp4 <- str_remove_all(tmp3$rawText, ",")
head(tmp4)
View(tmp4)
tmp5 <- unlist(strsplit(as.character(tmp3$rawText[1]), split=" "))

tmp3

wip <- tmp1


str <- "9,8,7 111 222"

getwd()
setwd("./exercise/dataMining")
tmplog <- read.csv("log.txt", sep="\"")
head(tmplog)

?read.csv


# cleanup step 2
# Elimination or the unnecessary data in the entry: time/date
tmp2 <- as.data.frame(str_remove(tmp1$text, "\\[.*\\]"))
head(tmp2)
colnames(tmp2) <-  c("text")

# cleanup step 3
# Elimination or the unnecessary data in the entry: ip / host address, time/date
tmp3 <- data.frame(str_remove(tmp1_4$text, ".*\\]"))
colnames(tmp3) <- "text"
head(tmp3)

# cleanup step 4
# eliminate the commas
tmp4 <- data.frame(str_remove_all(tmp3$text, ","))
colnames(tmp4) <- "text"
head(tmp4)

# cleanup step 5
# replace the double spaces by one
tmp5 <- data.frame(str_replace_all(tmp4$text, "  ", " "))
colnames(tmp5) <- "text"
head(tmp5)

tmp6<- data.frame(str_replace_all(tmp6$text, "  ", " "))
colnames(tmp6) <- "text"
head(tmp6)

t1 <- "hello [youpie] 2222"

str_remove(t1, ".*\\[")
str_replace(t1, ".*\\[", "\\[")

##############################
x <- "hello  2222"
df6[1]
x2 <- df6[1]
x2
str_replace(x2, "\\]", "\\]\"")


head(rawLog)
tmp1 <- data.frame(rawLog$col2)
tmp1[1,]
head(tmp1)



tmp2 <- dplyr::filter(tmp1, !grepl("GET", rawLog.col2, ignore.case = F)) %>%
filter(tmp2, !grepl("POST", rawLog.col2, ignore.case = F)) %>%
filter(tmp3, !grepl("OPTIONS", rawLog.col2, ignore.case = F)) %>%
filter(tmp4, !grepl("HEAD", rawLog.col2, ignore.case = F))

str <- "[09/Mar/2004:22:31:21 -0800]"

substring(str, 14,16)

str2 <- "64.242.88.10 - - [07/Mar/2004:16:05:49 -0800]"

str_replace(str2, ".*\\[", "\\[")
