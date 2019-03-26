library("e1071")
library(class)
mnist_matrix_full = read.csv( 'MNIST.csv' ) 
mnist_matrix = mnist_matrix_full[1:500,]

# Erstellen eines Samples für die Auftrennung Train- / Test -Daten
index = sample(2, nrow(mnist_matrix), replace=TRUE, prob=c(0.1, 0.9))
train_data_with_label = mnist_matrix[index==1,]
test_data_with_label = mnist_matrix[index==2,]

# Spalte mit Labels weglassen
train_data = train_data_with_label[-1]
test_data = test_data_with_label[-1]

# Vector der Labels erstellen
train_labels = factor(train_data_with_label[,1])
test_labels = factor(test_data_with_label[,1])


# Versuch einer Auswertung mit KNN

pred_knn = knn(train = train_data, 
               test = test_data, 
               cl= train_labels, 
               k = 10, 
               prob=TRUE) 

table(pred_knn, test_labels) 

# Auswertung 
validate_knn = pred_knn == test_labels
good_knn = length(validate_knn[validate_knn==TRUE])
bad_knn = length(validate_knn[validate_knn==FALSE])
prop_good_knn <- good_knn / (good_knn + bad_knn)



# Versuch einer Auswertung mit Naive-Bayes
model = naiveBayes(train_data, train_labels)
pred_nb = predict(model, test_data)
table(test_labels, pred_nb)

validate_nb = pred_nb == test_labels
good_nb = length(validate_nb[validate_nb == TRUE])
bad_nb  = length(validate_nb[validate_nb == FALSE])
prop_good_nb <- good_nb / (good_nb + bad_nb)

prop_good_nb

index2 = sample(2, nrow(mnist_matrix), replace=TRUE, prob=c(0.3, 0.7))
train_data_with_label2 = mnist_matrix[index2==1,]
test_data_with_label2 = mnist_matrix[index2==2,]

# Spalte mit Labels weglassen
train_data2 = train_data_with_label2[-1]
test_data2 = test_data_with_label2[-1]

# Vector der Labels erstellen
train_labels2 = factor(train_data_with_label2[,1])
test_labels2 = factor(test_data_with_label2[,1])

# Versuch einer Auswertung mit KNN

pred_knn2 = knn(train = train_data2, 
               test = test_data2, 
               cl= train_labels2, 
               k = 10, 
               prob=TRUE) 

table(pred_knn2, test_labels2) 

# Auswertung 
validate_knn2 = pred_knn2 == test_labels2
good_knn2 = length(validate_knn2[validate_knn2==TRUE])
bad_knn2 = length(validate_knn2[validate_knn2==FALSE])
prop_good_knn2<- good_knn2 / (good_knn2 + bad_knn2)


# Versuch einer Auswertung mit Naive-Bayes

model2 = naiveBayes(train_data2, train_labels2)
pred_nb2 = predict(model2, test_data2)
table(test_labels2, pred_nb2)

validate_nb2 = pred_nb2 == test_labels2
good_nb2 = length(validate_nb2[validate_nb2 == TRUE])
bad_nb2  = length(validate_nb2[validate_nb2 == FALSE])
prop_good_nb2 <- good_nb2 / (good_nb2 + bad_nb2)





