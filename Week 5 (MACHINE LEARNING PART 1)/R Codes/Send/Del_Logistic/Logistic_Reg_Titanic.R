getwd()
setwd("C:/Users/Naveen/Desktop/ML/Titanic")


titanic.train = read.csv('train.csv',  header = T, na.strings = c(''))
str(titanic.train)

titanic.test = read.csv('test.csv', header = T, na.strings = c(""))
str(titanic.test)

test.label = read.csv('gender_submission.csv', header = T, na.string=c(""))
str(test.label)


titanic.test = merge(titanic.test, test.label, by = "PassengerId")

titanic.train$Pclass = as.factor(titanic.train$Pclass)
titanic.test$Pclass = as.factor(titanic.test$Pclass)
str(titanic.train)

str(titanic.test)

titanic.train[which(titanic.train$Age < 1),'Age']

titanic.test[which(titanic.test$Age < 1),'Age']

sapply(titanic.train, function(x) sum(is.na(x)))

sapply(titanic.test, function(x) sum(is.na(x)))

sapply(titanic.train, function(x) length(unique(x)))

sapply(titanic.test, function(x) length(unique(x)))

#install.packages("Amelia")
library(Amelia) 

missmap(titanic.train, main = "Missing Values vs. Observed") # Find Missing values

missmap(titanic.test, main = "Missing Values vs. Observed")

titanic.train = subset(titanic.train, select = c(2,3,5,6,7,8,10,12))
titanic.test = subset(titanic.test, select = c(2,4,5,6,7,9,11,12))

age = c(titanic.train$Age, titanic.test$Age)
avg.age = mean(age, na.rm = T)
titanic.train$Age[is.na(titanic.train$Age)] = avg.age
titanic.test$Age[is.na(titanic.test$Age)] = avg.age

titanic.train = titanic.train[!is.na(titanic.train$Embarked),]
titanic.test = titanic.test[!is.na(titanic.test$Fare),]

missmap(titanic.train, main = "Missing Values vs. Observed")

missmap(titanic.test, main = "Missing Values vs. Observed")

# Build Model 

reg.model = glm(Survived ~., family = binomial(link = 'logit'), data = titanic.train)
summary(reg.model)

confint(reg.model)

#install.packages("aod")

library(aod)

wald.test(b = coef(reg.model), Sigma = vcov(reg.model), Terms = 9:10)

wald.test(b = coef(reg.model), Sigma = vcov(reg.model), Terms = 2:3)

exp(cbind(OR = coef(reg.model), confint(reg.model)))

anova(reg.model, test = 'Chisq')

#install.packages("pscl")
library(pscl)

pR2(reg.model)

titanic.predict = predict(reg.model, newdata = subset(titanic.test, select = c(1:7)),
                          type = 'response')
head(titanic.predict)

titanic.predict = ifelse(titanic.predict >0.5, 1, 0)
head(titanic.predict)

misClassifiError = mean(titanic.predict != titanic.test$Survived)
print(paste('Accuracy', 1 - misClassifiError))

#install.packages("ROCR")
library(ROCR)


p = predict(reg.model, newdata = subset(titanic.test, select = c(1:7)),
            type = 'response')
pr = prediction(p, titanic.test$Survived)
prf = performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf)
abline(0,1, lwd = 2, lty = 2)


auc = performance(pr, measure = 'auc')
str(auc)


auc = auc@y.values[[1]]
auc

#install.packages("kernlab")
library(kernlab)
svm.model <- ksvm(Survived ~ ., data = titanic.train, kernel = 'vanilladot')

svm.model

svm.predict <- predict(svm.model, titanic.test[,1:7])
head(svm.predict)

svm.predict = ifelse(svm.predict >0.5, 1, 0)
head(svm.predict)

table(svm.predict, titanic.test$Survived)

misClassifiError = mean(svm.predict != titanic.test$Survived)
print(paste('Accuracy is', 1 - misClassifiError))

p = predict(svm.model, newdata = subset(titanic.test, select = c(1:7)),
            type = 'response')
pr = prediction(p, titanic.test$Survived)
prf = performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf)
abline(0,1, lwd = 2, lty = 2)

auc = performance(pr, measure = 'auc')
str(auc)

auc = auc@y.values[[1]]
auc

