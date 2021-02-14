
#vector

ar <- c(1,"ankit")
class(ar)


###list

amit <- list(ar,1.2)

print(amit[1])

#matrix

mat1 <- matrix(c(2,4,5,6,6,8),nrow = 2,ncol = 3, byrow = T)

#array

a <- array(c('green','yellow'),dim = c(3,3,2))
print(a)

#factors
apple_colors <- c('green','green','yellow','red','red','red','green')
factor_colors <- factor(apple_colors)
print(nlevels(apple_colors))


#dataframes

BMI <- 	data.frame(
  gender= c("Male", "Male","Female"), 
  height= c(152, 171.5, 165), 
  weight = c(81,93, 78),
  Age = c(42,38,26)
)
















