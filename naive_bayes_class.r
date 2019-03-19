library("e1071")
library(class)
library(scatterplot3d)
head(iris,5)
scatterplot3d(iris[,1],iris[,4],iris[,3], highlight.3d=TRUE, col.axis="blue", col.grid="lightblue", main="scatterplot3d - 1", pch=20)
set.seed(1234)

# prepare data
ind = sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData_with_label = iris[ind==1,]
testData_with_label = iris[ind==2,]

trainData = trainData_with_label[-5]
testData = testData_with_label[-5]

dim(trainData)
dim(testData)

iris_train_labels = trainData_with_label$Species 
iris_test_labels = testData_with_label$Species 

# check data
head(trainData)
head(iris_train_labels)

# naive-bayes
m = naiveBayes(trainData, iris_train_labels)
pred_nb = predict(m, testData)
table(iris_test_labels, pred_nb)

truthVectorValidate_nb = pred_nb == iris_test_labels
good = length(truthVectorValidate_nb[truthVectorValidate_nb==TRUE])
bad = length(truthVectorValidate_nb[truthVectorValidate_nb==FALSE])
bad/(good+bad)
