getwd()
setwd("G:/DATA ANALYST/code")
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)

# The resposne vector.
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)

# Apply the lm() function.
relation <- lm(y~x)

# Find weight of a person with height 170.
a <- data.frame(x = 170)
result <-  predict(relation,a)
print(result)
png(file="linear.png")
plot(y,x,abline(lm(x~y)),col="blue",cex=1.3,pch=16,main = "THIS IS WEIGHT AND HEIGHT GRAPH",xlab = "weight",ylab = "height")
# for saving the files.
dev.off()
