#1)
#a)
getwd()
setwd("./exercise/dataMining")
rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'), sep="\"")

head(rawLog)
colnames(rawLog) <- c("col1", "col2", "col3")

# cleanup step 1
# drop unnecessary columns
tmp1 <- data.frame(rawLog$col2)

# cleanup step 1
# After visualizing the data:  eliminate the lines containing the request 
# (POST HEAD GET OPTIONS)
tmp2 <- tmp1 %>%
  dplyr::filter( !grepl("GET", rawLog.col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("POST", rawLog.col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("HEAD", rawLog.col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("OPTIONS", rawLog.col2, ignore.case = F))

head(tmp2)

# cleanup step 2
# split into 3 columns
for (i in 1:nrow(tmp2)){
  tmpCharArray <- unlist(strsplit(as.character(tmp2$rawLog.col2[i]), split=","))
  tmp2$employeeid[i] <- tmpCharArray[1]
  tmp2$departmentid[i] <- tmpCharArray[2]
  tmp2$clientid[i] <- tmpCharArray[3]
}
# cleanup step 3
# remove raw data column
tmp2$rawLog.col2 <- NULL
head(tmp2)

###########################
# b) add time column

raw2 = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'), sep = "\"")

head(raw2)
colnames(raw2) <- c("col1", "col2", "col3")
head(raw2$col3)

# drop col3
df1 <- data.frame(raw2$col1, raw2$col2)
colnames(df1) <- c("col1", "col2")

# keep only lines with payload
df2 <- df1 %>%
  dplyr::filter( !grepl("GET", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("POST", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("HEAD", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("OPTIONS", col2, ignore.case = F))

# split columns
for (i in 1:nrow(df2)){
  tmpCharArray <- unlist(strsplit(as.character(df2$col2[i]), split=","))
  timeString <- str_replace(df2$col1[i], ".*\\[", "\\[")
  hour <- substring(timeString, 14,15)
  df2$hour[i] <- hour
  df2$employeeid[i] <- tmpCharArray[1]
  df2$departmentid[i] <- tmpCharArray[2]
  df2$clientid[i] <- tmpCharArray[3]
}

df2[1,]
