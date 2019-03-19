getwd()


# kmean
x <- c(1,2,2, 3,4,5, 6,6,6,7, 1)
y <- c(5,5,7, 6,4,6, 6,8,5,7, 1)
labels <- c("cold","cold", "cold", "cold", "cold", "hot", "hot", "hot", "hot", "hot", "hot")
df <- data.frame(x, y, labels)
plot(df$x, df$y)
dim(df)
nrow(df)
df
df[y==5,]
head(iris)
iris[Petal.Length == 1.4,]
str(iris)
iris[,Petal.Length]

# prepare data
ind = sample(2, nrow(df), replace=TRUE, prob=c(0.6, 0.4))
trainDataWithLabels = df[ind==1,]
testDataWithLabels = df[ind==2,]

trainData <- trainDataWithLabels[-3]
testData <- testDataWithLabels[-3]

trainDataWithLabels
testDataWithLabels
trainData
testData

pred_knn = knn(train = trainData, test = testData, cl= trainDataWithLabels$labels,k = 2, prob=TRUE) 
pred_knn
table(pred_knn, testDataWithLabels$labels)

#################################################33
#create an empty data frame
df = data.frame(emailtext=character(),stringsAsFactors=FALSE) 
c_id=NULL
#add each email as row to the data frame
for (fileName in file_list){
  fileName
  text_b_utf8=iconv(readLines(fileName),to="utf-8")
  df=rbind(df,data.frame(paste(text_b_utf8, collapse = '\n'),stringsAsFactors = FALSE))
  fileName_nopoint = gsub(".eml","",as.character(fileName))#lapply(strsplit(fileName,"\\."),"[[",1)
  c_id=rbind(c_id,as.character(lapply(strsplit(as.character(fileName_nopoint),"_"),"[[",2)))
}


trainData_with_label = iris[ind==1,]


x <- c(1,2,2, 3,4,5, 6,6,6,7, 1)
y <- c(5,5,7, 6,4,6, 6,8,5,7, 1)
labels <- c("cold","cold", "cold", "cold", "cold", "hot", "hot", "hot", "hot", "hot", "hot")
df <- data.frame(x, y, labels)
ind = sample(2, nrow(df), replace=TRUE)
ind
df[ind==1,]
df[ind==2,]


a <- c(1,2,3,4,5,6)
b <- c(11,22,33,44,55,66)

dfa <- data.frame(c(1,2,3,4,5,6))
dfb <- data.frame(c(11,22,33,44,55,66))
colnames(dfa) <- "x"
colnames(dfb) <- "x"
dfa
dfb
dfab = rbind(dfa, dfb)
dfab
