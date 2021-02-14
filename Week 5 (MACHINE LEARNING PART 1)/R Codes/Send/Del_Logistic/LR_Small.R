## Load Titanic library to get the dataset
library(titanic)

## Load the datasets
data("titanic_train")
data("titanic_test")

## Setting Survived column for test data to NA
titanic_test$Survived <- NA

## Combining Training and Testing dataset
complete_data <- rbind(titanic_train, titanic_test)

## Check data structure
str(complete_data)

## Let's check for any missing values in the data
colSums(is.na(complete_data))

## Checking for empty values
colSums(complete_data=='')

## Check number of uniques values for each of the column to find out columns which we can convert to factors
sapply(complete_data, function(x) length(unique(x)))

## Missing values imputation
complete_data$Embarked[complete_data$Embarked==""] <- "S"
complete_data$Age[is.na(complete_data$Age)] <- median(complete_data$Age,na.rm=T)

## Removing Cabin as it has very high missing values, passengerId, Ticket and Name are not required
library(dplyr)
titanic_data <- complete_data %>% select(-c(Cabin, PassengerId, Ticket, Name))

## Converting "Survived","Pclass","Sex","Embarked" to factors
for (i in c("Survived","Pclass","Sex","Embarked")){
  titanic_data[,i]=as.factor(titanic_data[,i])
}

## Create dummy variables for categorical variables
#install.packages("dummies")
library(dummies)
titanic_data <- dummy.data.frame(titanic_data, names=c("Pclass","Sex","Embarked"), sep="_")

## Splitting training and test data
train <- titanic_data[1:667,]
test <- titanic_data[668:889,]

## Model Creation
model <- glm(Survived ~.,family=binomial(link='logit'),data=train)

## Model Summary
summary(model)

## Using anova() to analyze the table of devaiance
anova(model, test="Chisq")

## Predicting Test Data
result <- predict(model,newdata=test,type='response')
result <- ifelse(result > 0.5,1,0)

## Confusion matrix and statistics
library(caret)
#install.packages("e1071")
library(e1071)
confusionMatrix(data=result, reference=test$Survived)

## ROC Curve and calculating the area under the curve(AUC)
library(ROCR)
predictions <- predict(model, newdata=test, type="response")
ROCRpred <- prediction(predictions, test$Survived)
ROCRperf <- performance(ROCRpred, measure = "tpr", x.measure = "fpr")

plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7), print.cutoffs.at = seq(0,1,0.1))

# Accuracy
auc <- performance(ROCRpred, measure = "auc")
auc <- auc@y.values[[1]]
auc
