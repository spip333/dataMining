#@author: Andrea Giovannini
#This file is copyright protected - do not redistribute
# kmeans, wss versus k

library(scatterplot3d)
library(ggplot2)
set.seed(123)
head(iris)
s3d = scatterplot3d(iris[,1],iris[,4],iris[,3], highlight.3d=TRUE, col.axis="blue", col.grid="lightblue", main="scatterplot3d - 1", pch=20)

iris_data = as.matrix(iris[,1:4])
number_of_clusters = 3
km = kmeans(iris_data,centers=number_of_clusters)#,iter.max = )

s3d$points3d(km$centers[,1],km$centers[,4],km$centers[,3], pch = 16, col = "green")

wss_vs_k = function(df) {
  # value with only one cluster
  wss = (nrow(df)-1)*sum(apply(df,2,var))
  # value for the other clusters
  for (i in 2:15) wss[i] = sum(kmeans(df,
                                      centers=i)$withinss)
  return(cbind(1:15,wss))
}
out=wss_vs_k(iris_data)
dfout= data.frame(out)
colnames(dfout) = c("xplot","wss")

ggplot(dfout,aes(xplot)) +
  geom_line(aes(y = wss, colour = "wss")) + 
  labs(y="normalized within-cluster sum of squares") +
  labs(x="number of clusters")

