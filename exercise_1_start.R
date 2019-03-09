#1)
#a)

rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'))

class(rawLog)
head(rawLog)
str(rawLog)

# cleanup step 1
# After visualizing the data, I eliminate the entries containing the request
colnames(rawLog) <-  c("rawText")
tmp1_1 <- filter(rawLog, !grepl("GET", rawText, ignore.case = F))
colnames(tmp1_1) <-  c("text")
tmp1_2 <- filter(tmp1_1, !grepl("POST", text, ignore.case = F))
colnames(tmp1_2) <-  c("text")
tmp1_3 <- filter(tmp1_2, !grepl("OPTIONS", text, ignore.case = F))
colnames(tmp1_3) <-  "text"
tmp1_4 <- filter(tmp1_3, !grepl("HEAD", text, ignore.case = F))
colnames(tmp1_4) <-  "text"

head(tmp1_4)
str(tmp1_4)

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

tmp5[1,]

# cleanup step 4
# Elimination or the unnecessary data in the entry: http status, and value to the right...
for (i in 1:nrow(tmp5)){
  tmpchar <- unlist(strsplit(as.character(tmp5$rawText[i]), split=" "))
  valdf$one[i] <- tmpchar[1]
  valdf$two[i] <- tmpchar[2]
  valdf$three[i] <- tmpchar[3]
}




