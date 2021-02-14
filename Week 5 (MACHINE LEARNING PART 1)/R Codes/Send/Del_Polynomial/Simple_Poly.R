
# Simple Ponynomial Plot
# We will use a data set of counts of a variable that is decreasing over time

A <- structure(list(Time = c(0, 1, 2, 4, 6, 8, 9, 10, 11, 12, 13, 
                             14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29, 30), 
                    Counts = c(126.6, 101.8, 71.6, 101.6, 68.1, 62.9, 45.5, 41.9, 
                               46.3, 34.1, 38.2, 41.7, 24.7, 41.5, 36.6, 19.6, 
                               22.8, 29.6, 23.5, 15.3, 13.4, 26.8, 9.8, 18.8, 25.9, 19.3)), .Names = c("Time", "Counts"),
               row.names = c(1L, 2L, 3L, 5L, 7L, 9L, 10L, 11L, 12L, 13L, 14L, 15L, 16L, 17L, 19L, 20L, 21L, 22L, 23L, 25L, 26L, 27L, 28L, 29L, 30L, 31L),
               class = "data.frame")

View(A)
attach(A)

names(A)

linear.model <-lm(Counts ~ Time)

summary(linear.model)

#The model explains over 74% of the variance and has highly significant 
#coefficients for the intercept and the independent variable and also a highly
#significant overall model p-value. 

#However, let's plot the counts over time and superpose our linear model.

plot(Time, Counts, pch=16, ylab = "Counts ", cex.lab = 1.3, col = "red" )

abline(lm(Counts ~ Time), col = "blue")


#The model looks good, but we can see that the plot has curvature that 
#is not explained well by a linear model. 
#Now we fit a model that is quadratic in time. 
#We create a variable called Time2 which is the square of the variable Time.

Time2 <- Time^2

quadratic.model <-lm(Counts ~ Time + Time2)


#Note the syntax involved in fitting a linear model with 
#two or more predictors. We include each predictor and 
#put a plus sign between them.

summary(quadratic.model)

#Our quadratic model is essentially a linear model in two variables, 
#one of which is the square of the other. 
#We see that however good the linear model was, 
#a quadratic model performs even better, 
#explaining an additional 15% of the variance. 
#Now let's plot the quadratic model by setting up a 
#grid of time values running from 0 to 30 seconds in increments of 0.1s.

timevalues <- seq(0, 30, 0.1)

predictedcounts <- predict(quadratic.model,list(Time=timevalues, Time2=timevalues^2))

plot(Time, Counts, pch=16, xlab = "Time (s)", ylab = "Counts", cex.lab = 1.3, col = "blue")

#Now we include the quadratic model to the plot using the lines() command.

lines(timevalues, predictedcounts, col = "darkgreen", lwd = 3)

#The quadratic model appears to fit the data better than the linear model.