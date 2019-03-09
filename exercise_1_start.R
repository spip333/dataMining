#1)
#a)
getwd()
rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'), sep="\"")

filename <- "rawLog.txt"
write.csv2(rawLog, filename)

class(rawLog)
head(rawLog)
str(rawLog)
colnames(rawLog) <- c("col1", "col2", "col3")
# cleanup step 1
# drop unnecessary columns
tmp1 <- data.frame(rawLog$col2)
head(tmp1)
# cleanup step 1
# After visualizing the data, I eliminate the entries containing the request 
# (POST HEAD GET OPTIONS)
tmp2 <- filter(tmp1, !grepl("GET", rawLog.col2, ignore.case = F))
tmp3 <- filter(tmp2, !grepl("POST", rawLog.col2, ignore.case = F))
tmp4 <- filter(tmp3, !grepl("OPTIONS", rawLog.col2, ignore.case = F))
tmp5 <- filter(tmp4, !grepl("HEAD", rawLog.col2, ignore.case = F))

head(tmp5)
df <- data.frame(tmp5$text)
colnames(df) <- "text"

# cleanup step 6
# Elimination or the unnecessary data in the entry: http status, and value to the right...
for (i in 1:nrow(df)){
  tmpCharArray <- unlist(strsplit(as.character(df$text[i]), split=","))
  df$employeeid[i] <- tmpCharArray[1]
  df$departmentid[i] <- tmpCharArray[2]
  df$clientid[i] <- tmpCharArray[3]
}
df$text <- NULL
head(df)


