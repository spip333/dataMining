#set the working directory specific to my machine
setwd("~/Documents/Iniziative/BFH/2018 2/1_course/R-Scripts Woche 1/dataset/HMP_Dataset")


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
#Look at the data
View(df1)
dim(df1)
library(ggplot2)
df1_sample = df1[sample(nrow(df1), 500), ]
ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df2 = create_activity_dataframe("Climb_stairs",2)
dim(df2)
#Unite the dataframes
df = rbind(df1,df2)
dim(df)
View(df)

#df contains now two datasets, let's assume that a person (wearing the accelerometer) washed his teeth and 
#then due to climbed the stairs in his apartment to rest in the living room.
#With clustering we would like to distinguish between the 2 events.

#write.csv(df,"dsx_movement_pattern.csv")

number_of_clusters=2
n = nrow(df)

set.seed(123) #fix the random numbers --> otherwise the results will always be a bit different
first_attempt = kmeans(df,centers=number_of_clusters)
# discover the elements that where correctly identified, TRUE, and those that were not, FALSE
truthVector = first_attempt$cluster == df$class 
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
# calculate the accuracy
bad/(good+bad)


# build the df without class and timestep!
df_x_y_z = cbind(df$x,df$y,df$z)
km = kmeans(df_x_y_z,centers=number_of_clusters)

#evaluate
truthVector = km$cluster == df$class
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
bad/(good+bad)

# check what happens with the module of the acceleration vector
module_vec <- function(x) sqrt(sum(x^2))
acc_module = apply(df_x_y_z,1,module_vec)
View(acc_module)
df_x_y_z_a = cbind(df_x_y_z,acc_module)
View(df_x_y_z_a)
km = kmeans(acc_module,centers=number_of_clusters)

#evaluate
truthVector = km$cluster == df$class
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
bad/(good+bad)
