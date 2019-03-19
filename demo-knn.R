# kmean
x <- c(1,2,2, 3,4,5, 6,6,6,7,1)
y <- c(5,5,7, 6,4,6, 6,8,5,7,1)
labels <- c("cold","cold", "cold", "cold", "cold", "hot", "hot", "hot", "hot", "hot", "hot")
dfxy <- data.frame(x, y, labels)
plot(dfxy$x, dfxy$y)

# prepare data
ind = sample(2, nrow(dfxy), replace=TRUE)
trainDataWithLabels = dfxy[ind==1,]
testDataWithLabels = dfxy[ind==2,]

trainData <- trainDataWithLabels[-3]
testData <- testDataWithLabels[-3]

trainDataWithLabels
testDataWithLabels
trainData
testData

pred_knn1 = knn(train = trainData, test = testData, cl= trainDataWithLabels$labels,k = 2, prob=TRUE) 
pred_knn1
table(pred_knn1, testDataWithLabels$labels)
