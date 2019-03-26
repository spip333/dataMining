# prepare data
library("e1071")
library(class)

mnist_matrix_full = read.csv( 'MNIST.csv' ) 
mnist_matrix = mnist_matrix_full[1:600,]
dim(mnist_matrix) 
sort(unique(mnist_matrix[,1])) 

par( mfrow = c(10, 10), mai = c(0,0,0,0)) 

for(i in 1:10){ 
  y = as.matrix(mnist_matrix[i, 2:785])
  dim(y) = c(28, 28) 
  image( y[,nrow(y):1], axes = FALSE, col = gray(255:0 / 255))
  text( 0.2, 0, mnist_matrix[i,1], cex = 3, col = 2, pos = c(3,4)) 
} 
28*28
# prepare data
ind = sample(2, nrow(mnist_matrix), replace=TRUE, prob=c(0.1, 0.9))
train_data_with_label = mnist_matrix[ind==1,]
test_data_with_label = mnist_matrix[ind==2,]

train_data = train_data_with_label[-1]
test_data = test_data_with_label[-1]

train_labels = factor(train_data_with_label[,1])
test_labels = factor(test_data_with_label[,1])

# KNN
pred_knn = knn(train = train_data, 
               test = test_data, 
               cl= train_labels, 
               k = 10, 
               prob=TRUE) 

table(pred_knn, test_labels) 

head(pred_knn, 20)
head(test_labels, 20)

truth_vector_validate_knn = pred_knn == test_labels
good_knn = length(truth_vector_validate_knn[truth_vector_validate_knn==TRUE])
bad_knn = length(truth_vector_validate_knn[truth_vector_validate_knn==FALSE])
bad_knn / (good_knn+bad_knn)

# naive-bayes

m = naiveBayes(train_data, train_labels)
pred_nb = predict(m, test_data)
table(test_labels, pred_nb)

truth_vector_validate_nb = pred_nb == test_labels
good_nb = length(truth_vector_validate_nb[truth_vector_validate_nb==TRUE])
bad_nb = length(truth_vector_validate_nb[truth_vector_validate_nb==FALSE])
result_nb <- good_nb/(good_nb+bad_nb)

round(result_nb, 2)


