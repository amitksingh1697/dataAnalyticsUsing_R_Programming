# Print NAME 

print('NAME')

# Add 460.3 & 1.00
a <-  460.3 
b <- 1.00
c <- (a+b)
print(c)
#----------
print(460.3+1.00)
#---------
(460.3+1.00)
#---------

v <-  c(1,2,TRUE,"India",6.34)

v[4]
v[2:4]
v[-3]   # Print everything except 3rd element

###################

vec <- c(1:20)

mat1 <- matrix(vec, nrow = 4, ncol = 5, byrow = T)

mat1[1,1]
mat1[4,4]
mat1[3]
mat1[,3]
mat1[3,]
mat1[,]

mat1[2:3,2]

mat1[2,2]:mat1[3,2] # Good

as.vector(mat1)  # Good

mat1

rowSums(mat1)
colSums(mat1)

dim(mat1)
class(mat1[1,])

mat1[4,4] <- 100  # Replace single element

##########################################

x <- c(2,4,6,8,10,12,14,16,18,20) 
m2 <- matrix(x,nrow = 2,ncol = 5,byrow = T)
########################################

m3 <- matrix(c(1:10)*2,nrow = 2,ncol = 5,byrow = T)

#######################################

m2[2,4]
rowSums(m2)
colSums(m2)
dim(m2)
m2[2,3] <- TRUE

mode(m2)

print(1:10,by=2)

##############  Matrix ##########

am <-  matrix(1:4,2,2,T)
bm <-  matrix(5:8,2,2,T)

(am+bm)
(am*bm)

rbind(am,bm)
cbind(am,bm)

######################  List Excercise #####

a <- c(1, 2)

b<-TRUE

c<-c("a", "b", "c")

lst <- list (a <- c(1, 2), b<-TRUE, c<-c("a", "b", "c"))

class(lst)
class(lst[1])  # List / Integer
class(lst[2])  # List / Logical
class(lst[3])  # List / Character

lst[[3]][2:3]
