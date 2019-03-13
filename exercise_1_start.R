# ################################################################
# CAS - DA
# Data Mining
# Exercise 1 
#
# Author : N. Stern
# 13.03.2019
# ################################################################


#1)
#a)
library(dplyr)
library(stringr)

rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'), sep="\"")

head(rawLog)
colnames(rawLog) <- c("col1", "col2", "col3")

# cleanup step 1
# Eliminate the lines containing the request
# (POST HEAD GET OPTIONS)
tmpCleanLog <- rawLog %>%
  dplyr::filter( !grepl("GET", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("POST", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("HEAD", col2, ignore.case = F)) %>%
  dplyr::filter( !grepl("OPTIONS", col2, ignore.case = F))

head(tmpCleanLog)


# step 2
# Keep the column with the data we are investigating (which is in col2)
result1 <- data.frame(tmpCleanLog$col2)
colnames(result1) <- "rawdata"

# step 3
# Split into 3 columns
for (i in 1:nrow(result1)){
  tmpCharArray <- unlist(strsplit(as.character(result1$rawdata[i]), split=","))
  result1$employeeid[i] <- tmpCharArray[1]
  result1$departmentid[i] <- tmpCharArray[2]
  result1$clientid[i] <- tmpCharArray[3]
}

# cleanup step 4
# drop unnecessary columns
result1$rawdata <- NULL

# check the result
head(result1)

###########################
# b) add time column

# step 1
# Keep the column with the data we are investigating
# We start from the partially cleaned data (variable tmpCleanLog from part a), 
# This time, we keep the column with the timestamp and the column with the log entries (col1, col2)
result2 <- data.frame(tmpCleanLog$col1, tmpCleanLog$col2)
colnames(result2) <- c("col1", "col2")
head(result2)

# step 2
# split into 4 columns
for (i in 1:nrow(result2)){
  tmpCharArray <- unlist(strsplit(as.character(result2$col2[i]), split=","))
  timeString <- str_replace(result2$col1[i], ".*\\[", "\\[")
  hour <- substring(timeString, 14,15)
  result2$hour[i] <- hour
  result2$employeeid[i] <- tmpCharArray[1]
  result2$departmentid[i] <- tmpCharArray[2]
  result2$clientid[i] <- tmpCharArray[3]
}

# step 3
# remove unnecessary columns
result2$col1 <- NULL
result2$col2 <- NULL

# check the result
head(result2)

## Aufgabe2

url <- "https://raw.githubusercontent.com/romeokienzler/developerWorks/master/testdata.csv"
testdatadf = read.csv(url,colClasses =  c('character','numeric','numeric','numeric','numeric'))

# check data
head(testdatadf)
str(testdatadf)

# check how the hours, employee ids, department ids and client ids are distributed

# we would expect some kind of normal distribution for the hours
hist(testdatadf$hour)

# we don't expect a normal distribution for the employee ids, department ids and client ids
hist(testdatadf$employeeid)
hist(testdatadf$departmentid)
hist(testdatadf$clientid)

# how many different employee ids?
employeeids <- testdatadf %>% 
  distinct(employeeid)

length(employeeids$employeeid)
# => there are 9 different values of employee ids. 

# how many different department ids?
departmentids <- testdatadf %>% 
  distinct(departmentid)

length(departmentids$departmentid)
# => there are 99 different values of department ids. 

# 9 employees and 99 departments? this looks suspicious.
# obviously, some employees belong to several departments. 
# Let's Check this:
empdep <- testdatadf %>% 
  distinct(employeeid, departmentid)

head (empdep)
length(empdep$employeeid)
# => there are 891 combinations of employees and department. Let's look into the repartition:
hist(empdep$employeeid)
hist(empdep$departmentid)

# check if one of the employee ids is more involved?
res <- empdep %>% group_by(employeeid,departmentid) %>% tally
hist(res$employeeid)
# => yes, indeed : employee #1 is twice more present than any other employee id

# At this points, it is possible to draw a few conclusions, and perhaps formulate some hypothesis:
# The data do not look like real life data: The 10 users found in the log belong to 99 departments.
# 
# The fact that the employee ids are pretty much equally present in the log looks also as if the logdata 
# was not produced by human interaction.
#
# One hypothesis is that the accesses have been produce by some kind of machine.
# 
# One way we could check this hypothesis would be to identify some kind of pattern 
# in the access times (based on the user id). Unfortunately, the data is not complete enough if 
# we only know the hour of the access: we would need the full timestamp of the access.
# 
# Another data that would be worth looking at is the ip address from which the request is 
# initiated. Unfortunately, the data is not complete enough.
