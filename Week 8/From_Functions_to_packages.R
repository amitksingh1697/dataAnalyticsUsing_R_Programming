crea(3.14,c(1:100))

crea <- function(pi,r) {
  area <- (pi*r*r)
  print(area)
}

## What is a function : 

## Defining a function : Full form & Shortcut

## Types of Functions : 

# Anonimous : 
(function(x){x*x})(x=2)

# No Argument

entry <- function() {
  print ("Welcome to your Home")
  paste("Your time of entry is",Sys.time())
}


entry()

# Two arguments - No defaults 
# 1 & 2 arguments with defaults

# Ignoring multiple arguments

areaa <- function(pi, r,...) {
  area <- (pi*r*r)
  print(area)
}

areaa(3.14,1,6,7,6,7,6,7,6,)

## Local & Global variables in functions

areagl <- function(pi, r) {
  areag <- (pi*r*r)               ## NOTE THE ARROW
  print(areag)
}

areagl(3.14,5)
print(areag)

################# APPLY ############

##########  APPLY FAMILY IS UTILITY FUNCTIONS #############

df <- data.frame(
  v1=c(1:100),
  v2=c(101:200),
  v3=c(201:300)
)

View(df)

#Normal : 

apply(df,2,mean)   # 1,2 - Row / Column


#lapply
lapply(df,mean)   # Output in the form of a list

#sapply
sapply(df,mean)

#taply ( quant vs qual )

age<-c(10,20,30,40,50,60)
gender<-c("m","f","f","f","m","m")
gender<-factor(gender)


tapply(age,gender,mean)


sum(tapply(age,gender,mean))


#aggregate
ag <- data.frame(age,gender)

aggregate(mpg~gear,data=mtcars,mean)
sum(aggregate(mpg~gear,data=mtcars,mean))

tapply(mtcars$mpg,mtcars$gear,mean)
sum(tapply(mtcars$mpg,mtcars$gear,mean))

View(mtcars)

####################################### 

# Practive other examples in Apply Family

#######################################

rm(list = ls())

iris <- iris

head(iris)


iri <- function() {
  
  seto <- 0
  vesi <- 0
  verg <- 0
  
  for (i in length(unique(iris$Species)))
  {
    if (iris$Species[i]==unique(iris$Species)[1])
    {
      seto[i] <- iris$Sepal.Length[i]
    }
    else if(iris$Species[i]==unique(iris$Species)[2])
    {
      vesi[i] <- iris$Sepal.Length[i]
    }
    else(iris$Species[i]==unique(iris$Species)[3])
    {
      verg[i] <- iris$Sepal.Length[i]
    }
    
    print(mean(seto))
    (vesi)
    (verg)
    
  }
  
  
}


#####################################################
for(i in 1:length(unique(iris$Species))) 
{
  print(mean(iris[iris[,"Species"]==unique(iris$Species)[i],]$Sepal.Length))
}

for(i in 1:length(unique(iris$Species))) {
  
  print(mean(iris[iris[,"Species"]==unique(iris$Species)[i],"Sepal.Length"]))
  
}

for (i in 1:length(unique(iris$Species))){
  
  print(mean(iris[iris[,"Species"]==unique(iris$Species)[i],]$Sepal.Length))
  
}

################################  PACKAGES ########################

##### DPLYR  ##############

#install.packages("nycflights13")
library(nycflights13)
#install.packages("tidyverse")
library(tidyverse)
library(dplyr)

?flights
flights

head(flights)
tail(flights)
View(flights)
dim(flights)
flights
# What we'll learn

# filter()
# arrange()
# select()
# mutate()
# summarize()
# group_by()

################## Filter ########################
# flights that started on jan 1
flights %>% 
  filter(month==1,day==1) 

#flights[(flights$month==1 & flights$day==1),]

#filter(flights,month==1,day==1)

# this is fine too but the previous version is preferrable
filter(flights,month==1,day==1)


#flights that departed in Nov / Dec

(nov_dec <- flights %>% 
    filter(month==11 | month ==12))


################## Arrange #######################
# arrange based on year, month and day 
flights %>% 
  arrange(year,month,day)

tail(flights %>% 
       arrange(year,month,day))

#arrange based on descending order of arr_delay - MOST DELAYED

sum(is.na(flights$arr_delay))

flights %>% 
  filter(!is.na(arr_delay)) %>% 
  arrange(desc(arr_delay)) %>% 
  select(arr_delay,everything())


# arrange based on descending order of dep_delay - MOST DELAYED 2

flights %>% 
  filter(!(is.na(dep_delay))) %>% 
  arrange(desc(dep_delay))



################## Select ########################
# select only a few variables
flights %>% 
  select(year,month,day)

flights %>%
  select(year:day)

#select variables by excluding a few variables

flights %>%
  select(-(year:day))

#renaming while selecting variables 
select(flights, tail_num = tailnum)

flights %>% 
  select(tail_num = tailnum)


#select and display in your preferred order
flights %>% 
  select(time_hour,air_time,everything())

################## mutate ########################

flights_mini <- flights %>% 
  select(year:day,ends_with("delay"),
         distance,air_time)


txtz <- flights_mini %>% 
  mutate(gain = arr_delay - dep_delay,
         speed = distance / (air_time / 60))

View(txtz)


flights_mini %>%  
  mutate(gain = arr_delay - dep_delay, 
         hours = round((air_time / 60),2),
         gain_per_hour = round(gain / hours,2))

################## summarize ########################
flights %>% 
  summarize(delay=mean(dep_delay,na.rm=TRUE))

#total no of rows,maximum arrival delay, min dep delay and # unique carrier 
flights %>% 
  summarize(count=n(),
            max_arrdelay= max(arr_delay[!is.na(arr_delay)]),
            min_depdelay = min(dep_delay[!is.na(dep_delay)]),
            uni_carriers = length(unique(carrier)))


################## group_by############################

by_day <- flights %>% 
  group_by(year, month, day)

by_day

summarize(by_day, 
          delay = mean(dep_delay, na.rm = TRUE))

flights %>% 
  group_by(year,month,day) %>% 
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>% 
  summarise(delay = mean(delay, na.rm = TRUE))

#  Tibble vs Data frame
#https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html


##################  GGPLOT 2 ############################

#install.packages("ggplot2")

#require(ggplot2)
library(ggplot2)

search()                

# Look for all the loaded packages

#Basics of ggplot
#===
#Resources from: http://www.ling.upenn.edu/~joseff/rstudy/summer2010_ggplot2_intro.html

#There are two major functions that you will use in ggplot2:

#qplot(): for quick plots # Quick plots - We dont have too much of control over the visualisation
#ggplot(): for fine, granular control of everything     # More control over the graph

qplot()

#- Short for quick plot


library(caret)  # dependency for ggplot2
#install.packages("caret")

data(diamonds)  # Loads specified data sets, or list the available data sets.
View(diamonds)
dim(diamonds)  # Gives the dimension of a data set

data("diamonds")   #Loads specified data sets, or list the available data sets.

dim(diamonds)

qplot(carat, price, data=diamonds)

qplot(carat, price, data=head(diamonds)) 

# qplot(x axis, yaxis, data=, color=, shape=,)

qplot(log(carat), log(price), data=diamonds)  # More Linear after taking the log

# let's take a random sample of 100 obs from the data
# create dsmall.

View(diamonds)

sdata <- sample(diamonds, 4)  # By Default takes columns

set.seed(1)

dsmall <- diamonds[ sample(1:nrow(diamonds),100 ),]


#- Short for geometric object used to display the data specified as gemo= " "
#- point, smooth, boxplot, path, line, histogram, freqpoly, density, bar
#geom : Geometric objects 
#http://sape.inf.usi.ch/quick-reference/ggplot2/geom

#install.packages("moments")
library(moments)

skewness(dsmall$price)

qplot(price,data=dsmall)

qplot(price,data=dsmall,geom="density")

skewness(log(dsmall$price+10))

qplot(log(price),data=dsmall,geom="density")

qplot(log(carat), log(price), data=dsmall)

# We are looking at a loess curve - Non linear regression curve - Blue line is best fit , Grey is 95% confident interval

qplot(log(carat), log(price), data=dsmall, geom="smooth")

# Geoms are created layer by layer

qplot(log(carat), log(price), data=dsmall,geom=c("smooth", "point"),se=F)

qplot(log(carat), log(price), data=dsmall,geom=c("point", "smooth"))

qplot(carat,price, data=dsmall,geom=c("point", "smooth"))

library(moments)

summary(diamonds$carat)
qplot(table, data=diamonds,geom='histogram')
qplot(Sepal.Length, data=iris,geom='histogram') # bins =30

qplot(clarity, data=diamonds, geom="histogram", fill=cut, bins=10)  # Creates Bins

qplot(carat, data=diamonds, geom="histogram", fill=cut, bins=200)


ggsave("hello.png")   # Save the plot

getwd()

qplot(cut, data=diamonds, geom="bar")

colnames(diamonds)

qplot(price,depth, data=dsmall, geom="line")

qplot(price,depth, data=dsmall, geom="point")


#Parts of ggplot()
#===
#  - Starts with ggplot()
#- It will two main arguments: *data* and *aes()*
 
# Aesthetics - It will take X,Y,Stroke,Color,Fill,etc

qplot(clarity, data=diamonds,  geom="bar")

ggplot(data=diamonds, aes(clarity)) + geom_bar()  #Default y is count

qplot(clarity, data=diamonds,  geom="bar", fill=cut)

ggplot(data=diamonds, aes(clarity, fill=cut)) + geom_bar()


# qplot(x,y,data=,color=,shape=)

#ggplot(data=, aes(x, y, size, shape, color)) + geom_NAME() + geom_NAME()

#scatter

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color=class)) + 
  
  geom_text(aes(y=hwy,label=class))

# geom inside a geom

#A better way to control the layers is:

p <- ggplot(mpg, aes(displ, hwy))
p <- p + geom_point(aes(color = factor(cyl)))
p <- p + geom_point(aes(color = cyl))          # Factor difference

p

str(mpg)


q <- ggplot(mpg, aes(displ, hwy,color=factor(cyl)))
q <- q + geom_point()
q <- q + geom_line()
q


q <- ggplot(mpg, aes(displ, hwy,color=factor(cyl)))
q <- q + geom_point()
q <- q + geom_line(aes(color=factor(trans)))
q



#is same as
ggplot(mpg, aes(displ, hwy))+geom_point(aes(col=factor(cyl)))

ggplot(mpg, aes(displ, hwy))+geom_point(aes(col=factor(cyl)))+geom_line(aes(color=factor(cyl)))

#Aesthetics: *aes*
  =====
#  Plots convey information through various aspects of their *aesthetics*. Some aesthetics that plots use are:
  
- x position
- y position
- size of elements
- shape of elements
- color of elements

Geometric Shapes: *geom*
  =====
  Some of these geometries have their own particular aesthetics. For instance:
  
  - *points*; point shape; point size
- *lines*; line type; line weight 
- *bars*; y minimum: y maximum; fill color; outline color
- *text*; label value

Statistics
====
  - The values represented in the plot are the product of various statistics. - If you just plot the raw data, you can think of each point representing the identity statistic. 
- Many bar charts represent the mean or median statistic. 
- Histograms are bar charts where the bars represent the binned count or density statistic.


Statistics in plot
===
  ```{r, eval=FALSE}

p <- ggplot(mpg, aes(displ, hwy))
p <- p + geom_point(aes(color = factor(cyl)))
p <- p + geom_smooth()
p

#################### Animation in ggplot 2 & Few good links for extended learning 

#https://github.com/dgrtwo/gganimate

#https://plot.ly/ggplot2/animations/

#http://blog.revolutionanalytics.com/2017/05/tweenr.html

#http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
