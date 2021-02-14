
#Q 4.1: 


num <- 97
ifelse((num%%3==0)&&(num%%4==0),paste("fizz buzz"),
       ifelse(num%%3==0,paste("fizz"),
              ifelse(num%%4==0,paste("buzz"),paste("nofizznobuzz"))))



# q 2.1................................
 


  name<-c("Amar", "Babu","Chandu","Dilip")
  marks<- c(66,77,65, 76)
  height<- c(5.5,4.4, 5.4, 4.6) 
  degree <- c("BE","MBA","BE","MBA")
  
  da <- 	data.frame(name,marks,height,degree,stringsAsFactors = FALSE)
  print(da)
  da[[4]][2]<-"BE&MBA"
   da[[4]][4]<-"BE&MBA"
print(da)


##q 3.1................

X<-list(
  
  a<- c("NAME1","NAME2","NAME3"),
  b<-c(TRUE,FALSE),
  d<-c("INDIA","IS","MY","COUNTRY")
)

class(X[[2]])
X[[3]][-3]
class(X[[1]][2])


####q 5.1.............

num<- 11
ifelse((num%%2==0),paste("even"),paste("odd"))



##q 5.2............
x<-iris[-5]
lapply(x, mean)



##q1.1..........
a<-10
b<-20L
c<-a+b
print(c)
class(c)


##q 1.2..................
a<-c(1:20)
class(a)
b<-matrix(a,nrow = 4,ncol=5)
print(b)

