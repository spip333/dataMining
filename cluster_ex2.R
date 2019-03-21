#set the working directory specific to my machine
#setwd("/Users/andreagiovannini/Documents/Iniziative/BFH/2018/1_course/R-Scripts Woche 1/dataset/HMP_Dataset")
getwd()
setwd("./exercise/dataMining/dataset/HMP_Dataset")

#create a data frame from all files in specified folder
create_activity_dataframe = function(activityFolder,classId) {
  file_names = dir(activityFolder)
  file_names = lapply(file_names, function(x){ paste(".",activityFolder,x,sep = "/")})
  your_data_frame = do.call(rbind,lapply(file_names,function(x){read.csv(x,header = FALSE,sep = " ")}))
  your_data_frame = cbind(data.frame(rep(classId,nrow(your_data_frame))),your_data_frame)
  your_data_frame = cbind(data.frame(1:nrow(your_data_frame)),your_data_frame)
  colnames(your_data_frame) = c("timestep","class","x","y","z")
  return(your_data_frame)
}

df1 = create_activity_dataframe("Brush_teeth",1)

#Look at the data in df1
head(df1)
dim(df1)

library(ggplot2)

df1_sample = df1[sample(nrow(df1), 500), ]

ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))


df2 = create_activity_dataframe("Climb_stairs",2)

#Look at the data in df1
head(df2)
dim(df2)

df2_sample = df2[sample(nrow(df2), 500), ]

ggplot(df2_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))


#Unite the dataframes
df = rbind(df1,df2)
dim(df)
head(df)

#df contains now two datasets, let's assume that a person (wearing the accelerometer) washed his teeth and 
#then due to climbed the stairs in his apartment to rest in the living room.
#With clustering we would like to distinguish between the 2 events.

head(df1)
head(df2)
head(df1_sample)
head(df2_sample)

# create a set of train data with the two samples
train_data_with_class <- rbind(df1_sample, df2_sample)
train_data_class <- train_data_with_class$class
train_data <- train_data_with_class
train_data$class <- NULL
train_data$timestep <- NULL

head(train_data)

# prepare the set of test data from df
test_data <- df
test_data$timestep <- NULL
test_data$class <- NULL

# check and proceed to knn
dim(train_data)
dim(test_data)

pred_knn <- knn(train=train_data, test=test_data, cl=train_data_class, k=2 )

table(pred_knn, df$class)

# validate result
truthVectorValidate_knn = pred_knn == df$class
correct = length(truthVectorValidate_knn[truthVectorValidate_knn==TRUE])
false = length(truthVectorValidate_knn[truthVectorValidate_knn==FALSE])
false /(correct + false)


#########################################################################
head(df)


km1= kmeans(df,centers=2)#,iter.max = )
km1$cluster
km1$centers
km1$totss
km1$withinss
km1$tot.withinss
km1$betweenss
km1$size

?kmeans
head(iris)
iris_data = as.matrix(iris[,1:4])
head(iris_data)
number_of_clusters = 3
km = kmeans(iris_data,centers=number_of_clusters)#,iter.max = )
km
