
library(arules)

row1 = cbind(0, 1, 0, 1, 0, 1) 
row2 = cbind(0, 1, 0, 1, 0, 1) 
row3 = cbind(1, 0, 1, 0, 1, 1) 
row4 = cbind(0, 1, 0, 1, 0, 1) 
row5 = cbind(0, 1, 0, 0, 0, 1) 
row6 = cbind(0, 1, 0, 0, 0, 1) 
df = rbind(row1, row2, row3, row4, row5, row6) 
df
colnames(df) <- c("water", "beer", "milk", "bread", "meat", "chips")
rules <-    apriori(df, parameter = list(supp = 0.5, target = "rules")) 
inspect(rules)
