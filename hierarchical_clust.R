# First example of clustering through hierarchical clustering using iris example
library(ggplot2)
View(iris)
clusters <- hclust(dist(iris[, 3:4])) #complete linkage
plot(clusters)
clusterCut <- cutree(clusters, 3)
table(clusterCut, iris$Species)
ggplot(iris, aes(Petal.Length, Petal.Width, color = iris$Species)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))

# Now try again using another method for the linkage
clusters <- hclust(dist(iris[, 3:4]),method='average') #mean linkage
plot(clusters)
clusterCut <- cutree(clusters, 3)
table(clusterCut, iris$Species)
?cutree
ggplot(iris, aes(Petal.Length, Petal.Width, color = iris$Species)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))

#--> mean linkage works better for clusters that are not clearly defined

