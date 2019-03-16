#set the working directory specific to my machine
setwd("/Users/andreagiovannini/Documents/Iniziative/BFH/2018/1_course/R-Scripts Woche 1/dataset/HMP_Dataset")


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

