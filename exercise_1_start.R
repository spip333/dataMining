#1)
#a)

library(dplyr)
rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'), sep="\"")

head(rawLog)
colnames(rawLog) <- c("col1", "col2", "col3")

# cleanup step 1
# After visualizing the data:  eliminate the lines containing the request 
# (POST HEAD GET OPTIONS)
tmp2 <- rawLog %>%
  dplyr::filter( !grepl("GET", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("POST", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("HEAD", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("OPTIONS", col2, ignore.case = F))

head(tmp2)

# cleanup step 2
# split into 3 columns
result1 <- data.frame(tmp2$col2)
colnames(result1) <- "rawdata"
for (i in 1:nrow(result1)){
  tmpCharArray <- unlist(strsplit(as.character(result1$rawdata[i]), split=","))
  result1$employeeid[i] <- tmpCharArray[1]
  result1$departmentid[i] <- tmpCharArray[2]
  result1$clientid[i] <- tmpCharArray[3]
}

# finalize: drop unnecessary columns
result1$rawdata <- NULL
head(result1)

###########################
# b) add time column

# we start from the partially cleaned data (variable tmp2 from step a)

result2 <- data.frame(tmp2$col1, tmp2$col2)
colnames(result2) <- c("col1", "col2")

# split columns
for (i in 1:nrow(result2)){
  tmpCharArray <- unlist(strsplit(as.character(result2$col2[i]), split=","))
  timeString <- str_replace(result2$col1[i], ".*\\[", "\\[")
  hour <- substring(timeString, 14,15)
  result2$hour[i] <- hour
  result2$employeeid[i] <- tmpCharArray[1]
  result2$departmentid[i] <- tmpCharArray[2]
  result2$clientid[i] <- tmpCharArray[3]
}

# finalize
result2$col1 <- NULL
result2$col2 <- NULL
head(result2)

