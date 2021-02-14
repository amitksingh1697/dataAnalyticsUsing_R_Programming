# Load necessary libraries
library(datasets)
library(help = "datasets")

# Inspect data structure
str(attitude)
str(sleep)
sleep
# Summarise data
summary(attitude)

# Subset the attitude data
dat = attitude[,c(3,4)]
attitude

# Plot subset data
plot(dat, main = "% of favourable responses to
     Learning and Privilege", pch =20, cex =2)

# Perform K-Means with 2 clusters
set.seed(7)
km1 = kmeans(dat, 2, nstart=100)

# Plot results
plot(dat, col =(km1$cluster +1) , main="K-Means result with 2 clusters", pch=20, cex=2)


# Check for the optimal number of clusters given the data

mydata <- dat
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main="Assessing the Optimal Number of Clusters with the Elbow Method",
     pch=20, cex=2)

# Perform K-Means with the optimal number of clusters identified from the Elbow method
set.seed(7)
km2 = kmeans(dat, 6, nstart=100)

# Examine the result of the clustering algorithm
km2

# Plot results
plot(dat, col =(km2$cluster +1) , main="K-Means result with 6 clusters", pch=20, cex=2)


#################  IRIS ##################
##########################################

library(datasets)
head(iris)

library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

set.seed(20)
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)
irisCluster

table(irisCluster$cluster, iris$Species)

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

###########################################
################# IMAGE REDUCTION ############
############################################

rm(list=ls())

# 124K - Unique combinations of colors
# Our objective is to cluster in to 2 or more colors

getwd()
setwd("C:/Users/Naveen/Desktop/ML/Del_Kmeans")

#Installing library
#install.packages("jpeg") 

#Loading library into R Session
library("jpeg")

#Read image
R_img<-readJPEG("R.jpg")

# Obtain the dimension i.e (Pixels, Color Values)
img_Dm <- dim(R_img)

# Lets assign RGB channels to a data frame
img_RGB <- data.frame(
  x_axis = rep(1:img_Dm[2], each = img_Dm[1]),
  y_axis = rep(img_Dm[1]:1, img_Dm[2]),
  Red = as.vector(R_img[,,1]),
  Green = as.vector(R_img[,,2]),
  Blue = as.vector(R_img[,,3])
)

library(ggplot2)

# Plot the image
ggplot(data = img_RGB, aes(x = x_axis, y = y_axis)) +
  geom_point(colour = rgb(img_RGB[c("Red", "Green", "Blue")])) +
  labs(title = "Original Image") +
  xlab("x-axis") +
  ylab("y-axis")

#Show time - Let's start the clustering

#Running the WSSPLOT function again
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

wssplot(img_RGB[c(3,4,5)],25)

#running the k-means algorithm

# Change the values of k and check

k_cluster <- 4
k_img_clstr <- kmeans(img_RGB[, c("Red", "Green", "Blue")],
                      centers = k_cluster)
k_img_colors <- rgb(k_img_clstr$centers[k_img_clstr$cluster,])

#plotting the compressed image
ggplot(data = img_RGB, aes(x = x_axis, y = y_axis)) +
  geom_point(colour = k_img_colors) +
  labs(title = paste("k-Means Clustering of", k_cluster, "Colours")) +
  xlab("x") +
  ylab("y")

