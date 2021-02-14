install.packages("scatterplot3d")
library(scatterplot3d)
attach(airquality)
s3dplot<- scatterplot3d(Temp,Solar.R,Ozone)
model <- lm(Ozone~Solar.R+Temp)
s3dplot$plane3d(model)

install.packages(c("rgl", "car"))
library("car")

scatter3d(x = Temp, y = Solar.R, z = Ozone)

scatter3d(x = Temp, y = Solar.R, z = Ozone,
          grid = FALSE, fit = "smooth")
