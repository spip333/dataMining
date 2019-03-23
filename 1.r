#@author: Andrea Giovannini & Romeo Kienzler
#This file is copyright protected - do not redistribute

#1)
#a)
rawLog = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log',colClasses = c('character'))
View(rawLog)
colnames(rawLog)=c('raw')
class(rawLog)
str(rawLog$raw)
# Identify where is the request(s)
filter=grepl("POST",rawLog$raw)|grepl("GET",rawLog$raw)|grepl("DELETE",rawLog$raw)|grepl("HEAD",rawLog$raw)|grepl("PUT",rawLog$raw)|grepl("TRACE",rawLog$raw)|grepl("CONNECT",rawLog$raw)
filter
rawLog[!filter,]
rawLog[filter,]

wantedLines = rawLog[!filter,]

splitb = sapply(wantedLines, function(x) {strsplit(x,split = ",")})
split_list = strsplit(wantedLines,split = ",")
# look at one example 
split_list[3]
#x = lapply(split,function(x){as.integer(substr(x[1],length(x[1])-1,length(x[1])))})[[1]]
x = as.integer(lapply(strsplit(unlist(lapply((split_list), '[[', 1)),split = "   "),"[[",2))
#y = lapply(split,function(x){as.integer(x[2])})
y = as.integer(lapply(split_list, '[[', 2))

#z = lapply(split,function(x){as.integer(strsplit(x[3],"   ")[[1]][[1]])})
z = as.integer(lapply(strsplit(unlist(lapply((split_list), '[[', 3)),split = "   "),"[[",1))

result = data.frame(unlist(x),unlist(y),unlist(z))
colnames(result) = c('departmentid','employeeid','clientid')
str(result)
summary(result)
View(result)

#b)
#Get and visualize the data
df = read.csv('https://raw.githubusercontent.com/romeokienzler/developerWorks/master/testdata.csv')
View(df)
summary(df)

#get a 1st idea
hist(df$employeeid)
hist(df$departmentid)
hist(df$hour)
hist(df$clientid)

#double-check why #of departmentid's >> #of empoyeeid's
min(df$employeeid)
max(df$employeeid)

min(df$departmentid)
max(df$departmentid)

#swap columns names to correct for this error
#(after talking back to "the business")
df_corrected <- subset(df, select=-X)
colnames(df_corrected)
colnames(df_corrected) = c("hour","departmentid","employeeid","clientid")
colnames(df_corrected)
min(df_corrected$employeeid)
max(df_corrected$employeeid)

min(df_corrected$departmentid)
max(df_corrected$departmentid)

#2)

# 2 possible approaches

# 1. count per employee
# 2. count per employee and time (1st via department)


#1.
hist(df_corrected$employeeid,breaks = 1:99)
library(sqldf)

df_corrected_agg=sqldf("select count(clientid) as number_of_accesses from df_corrected group by employeeid order by number_of_accesses desc")
View(df_corrected_agg)

#df_corrected_agg=aggregate(df_corrected, by=list(df_corrected$employeeid),FUN=length)
#View(df_corrected_agg)

#2.
par(mfrow=c(3,3))
hist(df_corrected[df_corrected$departmentid==1,]$hour)
hist(df_corrected[df_corrected$departmentid==2,]$hour)
hist(df_corrected[df_corrected$departmentid==3,]$hour)
hist(df_corrected[df_corrected$departmentid==4,]$hour)
hist(df_corrected[df_corrected$departmentid==5,]$hour)
hist(df_corrected[df_corrected$departmentid==7,]$hour)
hist(df_corrected[df_corrected$departmentid==8,]$hour)
hist(df_corrected[df_corrected$departmentid==9,]$hour)
par(mfrow=c(1,1))
unique(df_corrected[df_corrected$departmentid==7 & df_corrected$hour==0,]$employeeid)
hist(df_corrected[df_corrected$departmentid==7 & df_corrected$hour==0,]$employeeid,breaks = 1:99)
df_corrected_agg=sqldf("select count(clientid) as number_of_accesses, employeeid from df_corrected where hour < 5 group by employeeid order by number_of_accesses desc")
View(df_corrected_agg)

# employee id 23, department id 7 => high number of accesses at night time!
