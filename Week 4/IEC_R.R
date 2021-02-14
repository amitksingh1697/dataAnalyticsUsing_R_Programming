rm(list = ls())
# Comments

# ----- Data Types
# Logical

x <- 3.14159262
y <- T
z <- TRUE

as.logical(x)

# Integer

a <- 10L
b <- 20.202020L
class(a)
class(b)

print(ab)

# Neumeric

a <- 10
b <- 20.202020L
class(a)
class(b)

print(ab)

#character

Name <- "Character 1 ,@ 1.23, TRUE, T "
Name2 <- 'Character 2'

class(Name)

#############################


a <- 6L
b <- 3L
c <- a+b

print(a%%b)

################################

#Data Structures

# Vectors 

 N <-  c(1,2,3,4,5,6)

 N <-  c(1:6)
 
 N  <- c(70:90)
 
 length(N)  # length of the vector
 class(N)   # Data trype of objects in the vector
 
 N[5]    # Gives the 5th Element
 
 N[2:10]
 
 N[-6]

 N[6] <- 100
 
 N[6]+N[1]

 
 
 # Matrix
 
 # Division, Quotient and Remainder
 9/2   # Quotient
 9%%5  # Remainder
 
 -8%%5  # What needs to be added to make it completely divisible
 
 24%/%3   # Quotient in whole number
 
 20%%3
 
 #creating a matrix
 
 matrix(1,3) # column matrix of 1
 matrix(2,4) # column matrix of 2
 t(matrix(4,2))# row matrix of 4
 matrix(0,3,4) # rectangular matrix of dim r,c
 
 intvec2 <- c(1:13)
 mat1 <- matrix(intvec2,nrow= 3)
 mat1
 mat2 <- matrix(intvec2,nrow=4,ncol=3)
 mat2
 mat3 <- matrix(intvec2,nrow=4,byrow=T) # default is byrow = F
 mat3
 
 # Matrix from a vector
 
 a <- c(1:10)
 a
 dim(a)
 dim(a) <- c(2,5)
 a
 dim(a) <- c(5,2)
 a
 # product of items in dim should equal to the length of the vector 
 dim(a) <- c(3,4)
 dim(a) <- c(4,3)
 # Note that the cyclicity property doesnt work in this context
 class(a)
 typeof(a)
 mode(a)
 
 
 a
 b
 cbind(a,b)
 rownames(cbind(a,b))
 colnames(cbind(a,b))
 rbind(a,b)
 rownames(rbind(a,b))
 colnames(rbind(a,b))
 
 #accessing the elements of a matrix
 mat1
 mat1[2] 
 mat1[10]
 #Recall that mat3 was created using byrow=T
 mat3
 mat3[3]
 as.vector(mat3) # flatteting the matrix 
 mat3[3]
 mat3[2,3]
 mat3[3,5] # accessing a non-existing element
 
 #rownames and colnames in matrix
 mat4 <- matrix(c(1:6),nrow=2)
 mat4
 dim(mat4)
 nrow(mat4)
 ncol(mat4)
 rownames(mat4)
 rownames(mat4) <-c("R1","R2")
 colnames(mat4) <- c("C1","C2","C3")
 mat4
 mat4["R1",]
 mat4[,"C2"]
 mat4["R1","C3"]
 rm(mat4)
 
 mat4 <- matrix(c(1:6),nrow=2)
 dimnames(mat4) <- list(c("R1","R2"),c("C1","C2","C3"))
 mat4
 rm(mat4)
 
 mat4 <- matrix(c(1:6),nrow=2,
                dimnames = list(c("R1","R2"),c("C1","C2","C3")))
 mat4
 
 #Basic matrix operations
 is.matrix(intvec2)
 is.matrix(mat4)
 is.vector(mat4)
 mat1
 mat1 +2
 mat1 *2
 mat1 + mat1 #dim should match to add
 mat1 + mat3 
 mat1
 colSums(mat1)
 rowSums(mat1)
 colMeans(mat2)
 rowMeans(mat2)
 dim(mat2) # 4 * 3 matrix
 dim(mat1) # 3 * 4 matrix
 mat2 %*% mat1  # matrix multiplication
 mat1*mat1      # element by element multiplication
 mat1
 
 ##########  ARRAY ################
 
 array1 <- array(intvec2,c(2,2,3))
 array1
 array2 <- array(c(1:10),c(2,3,2))
 array2
 array2[]
 array2[1,2,2]
 array2[2,1,1]
 array2[1,2,]
 array2
 array2[1,,]
 class(array2)
 class(array2[1,,])
 class(array2[1,2,])
 
 
 
 
 ################################ lists  #####################
 
 list2 <- list()
 list2
 class(list2)
 
 a
 a <- 5
 rm(a)
 
 lst<-list(a <- c(1, 2), b<-TRUE, c<-c("a", "b", "c"))
 str(lst)
 lst
 length(lst)
 class(lst)
 lst[1] # list
 class(lst[1])
 lst[[1]] # numeric vector
 class(lst[[1]])
 lst$a    # we have assigned a but unable to call a . Why ?
 a<-10
 lst<-list(a = c(1, 2), b =  TRUE, c=c("a", "b", "c"))
 lst[1]
 lst[[1]]
 lst$a
 a <- a*2
 a
 lst$a
 str(lst)
 lst$b
 lst[[2]]
 lst
 lst[1,2]
 
 lst[c(1,2)] #This will extract the first two elements of list.
 lst[1]      #This will extract the first element of list.
 lst[1:2]    #This will extract the first three elements of the list.
 
 unlist(lst[2])
 
 class(lst)
 class(lst[1])
 class(lst[2:3])
 
 lst
 lst[[1]][2]
 
 lst[[1]]    #This will extract the values of first element.
 lst[[3]]    #similarly all vlaues of the third element in list.
 
 lst[[1]][1] #this will extract the first value from the first element
 lst[[1]][2] #this will extract the 2nd value from the first element
 
 lst[[2]]    # this will extract the  second element of the list fully
 
 lst[[3]][1] # this will extract the 1st value from the third element
 lst[[3]][2] # this will extract the 2nd value from the third element
 lst[[3]][3] # this will extract the 3rd value from the third element
 
 class(lst[3])
 lst
 lst[1]
 lst[3]
 lst[3][1]
 lst[3][2]
 lst[3][10]
 class(lst[3][10])
 lst[3]
 lst[[3]][3]
 class(lst[[3]])
 lst[1][1][1][1][1][1]     [[1]]
 
 #GOLDEN rule  "list will  alway contain list "
 
 #here inside lst 1st level of the list is the list 
 class(lst[1])
 class(lst[2])
 class(lst[3])
 
 #now we move to the 2 layer of the list
 class(lst[[1]])
 class(lst[1][1])
 class(lst[1][2])
 lst[1][2]
 lst
 lst[[1]][1]
 lst[1][1][1]
 lst[2][1][1]
 lst[3][1][1]
 lst[3][1]
 lst[3][1][1][[2]]
 
 #list will alway contain list
 class(lst[1][1][1])
 class(lst[2][1][1])
 class(lst[3][1][1])
 
 
 
 
 lst
 lst[1][2]
 lst[2][2]
 lst[3][2]
 
 class(lst[[1]])
 class(lst[[1]][1])
 class(lst[[2]])
 class(lst[[3]])
 
 lst[[1]][3]
 
 moh_profile<-list(name=c("Albert","Roger",1),
                   marital=TRUE,
                   interest =c("R","Python","Scala"),
                   Target  <- c("google","yahoo","amazon","Citi"),
                   acadprof = data.frame(title=c("BE","MBA"),grade =c("A+","A+"), 
                                         stringsAsFactors = F))
 
 moh_profile
 
 moh_profile$name
 moh_profile$interest
 moh_profile$Target  # see the difference between = and <- 
 moh_profile[[4]]
 unlist(moh_profile)
 class(unlist(moh_profile))
 
 moh_profile<-list(name=c("Albert","Roger"),
                   marital=TRUE,
                   interest =c("R","Python","Scala"),
                   Target  <- c("google","yahoo","amazon","Citi"),
                   acadprof = list(df2=data.frame(title=c("BE","MBA"),grade =c("A+","A+"), 
                                                  stringsAsFactors = F),
                                   university=c("NTU","NUS")))
 moh_profile
 moh_profile$acadprof
 moh_profile$acadprof$df2
 class(moh_profile$acadprof$df2)
 class(moh_profile[[3]])
 class(moh_profile[[5]])
 moh_profile[[5]][1]
 class(moh_profile[[5]][1])
 moh_profile[[5]][[1]]
 class(moh_profile[[5]][[1]])
 moh_profile[[5]][[1]][1]
 class(moh_profile[[5]][[1]][1])
 moh_profile[[4]][1]
 moh_profile[[5]][[2]]
 moh_profile[[5]][[2]][2]
 moh_profile$acadprof$university
 
 
 ################  DATA FRAMES  #############
 
 
 # List unequal Elements, DF - Equal Elements
 
 #creating a data frame
 name1 <- c("Antony","Ben","Cathy","Diana")
 age   <- c(12,18,17,19)
 gender <- c("Male","Male","Female","Female")
 iqF <- factor(c("High","Low","Medium","Very High"),
               ordered = TRUE,
               levels =c("Low","Medium","High","Very High")) 
 name1
 age
 gender
 iqF
 df <- data.frame(name1,age,gender,iqF)
 str(df)
 gender <- factor(c("Male","Male","Female","Female"))
 df <- data.frame(name1,age,gender,iqF,stringsAsFactors = F) # Default = T
 df
 str(df)
 unclass(df)
 class(unclass(df))
 names(df)
 colnames(df)
 rownames(df)
 row.names(df) # Use rownames and colnames function for both matrices and dataframes (recent change)
 attributes(df)
 attributes(mat4)
 class(attributes(mat4))
 #working with dataframes
 df
 df[]
 df[1]         # data frame
 df["name1"]   # data frame
 df[1,]        # data frame
 df[,1]        # character
 df[[1]]       # character 
 df$name1      # vector
 df[1,2]      # vector
 df[,2]       # vector
 df
 lst<-list(a = c(1, 2), b <-  TRUE, c=c("a", "b", "c"))
 lst$c[3]
 df[c(1,3),c("age","name1")]
 
 df[1,1]
 df$name1[1]
 df[names(df)]
 df[rev(names(df))]
 