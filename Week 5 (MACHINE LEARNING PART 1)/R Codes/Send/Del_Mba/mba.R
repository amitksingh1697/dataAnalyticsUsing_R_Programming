
getwd()
setwd("C:/Users/Naveen/Desktop/ML/Del_Mba")


library(caret)
library(arules)

groceries <- read.transactions("groceries.csv", sep = ",")

summary(groceries) 

# look at the first five transactions
inspect(groceries[1:5])

itemFrequency(groceries[, 1:3])

# Visualizing item support - item frequency plots

itemFrequencyPlot(groceries, support = 0.1)

itemFrequencyPlot(groceries, topN = 20)

#Visualizing the transaction data - plotting the sparse matrix

image(groceries[1:5])

image(sample(groceries, 100))

# Training 
apriori(groceries)

#Since 60 out of 9,835 equals 0.006, we'll try setting the support there first.

#The full command to find a set of association rules using the Apriori algorithm is as follows:
  
groceryrules <- apriori(groceries, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))

groceryrules

# Evaluating Performance 
summary(groceryrules)

inspect(groceryrules[1:3])

# Improving Performance 

inspect(sort(groceryrules, by = "lift")[1:5])

berryrules <- subset(groceryrules, items %in% "berries")

inspect(berryrules)

# Report to CSV
write(groceryrules, file = "groceryrules.csv", sep = ",", quote = TRUE, row.names = FALSE)

groceryrules_df <- as(groceryrules, "data.frame")

str(groceryrules_df)

