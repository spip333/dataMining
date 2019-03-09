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

tmp4 <- str_remove(tmp3$rawText, ",")
head(tmp4)
View(tmp4)
unlist(strsplit(as.character(tmp3$rawText[1]), split=" "))

