## Correlation
cor(mtcars$hp,mtcars$mpg) #-0.7761684
cor(mtcars$wt,mtcars$mpg) #-0.8676594

plot(mtcars$hp,mtcars$mpg,pch=16)
plot(mtcars$wt,mtcars$mpg,pch=16)
plot(mtcars$wt,mtcars$hp,pch=16)

cor(mtcars[,c("mpg","wt","hp")])

##dplyr (tidyverse)
librury(dpylr)
corMat <- mtcars %>%
  select(mpg,wt,hp,am) %>%
  cor()

## compute correlation (r) and sig test
cor(mtcars$hp,mtcars$mpg)
cor.test(mtcars$hp,mtcars$mpg)

## Linear Regression
## mpg = f(hp)

lmFit <- lm(mpg ~ hp, data = mtcars)

summary(lmFit)

#Predicted hp = 200
lmFit$coefficients[[1]] + lmFit$coefficients[[2]]*200

new_cars <- data.frame(
  hp = c(250,320,400,410,450)
)

## predict
new_cars$mpg_pred <- predict(lmFit,newdata=new_cars )
new_cars #450 -> -0.6038646 

summary(mtcars$hp) #450 over scope

## Root Mean Squared Error (rmse)
## Multiple Linear Regression
## mpg = f(hp,wt,am)
## mpg = intercept + b0*hp + b1*wt + b3*am

lmFit_V2 <- lm(mpg ~ hp + wt + am,data = mtcars)

coefs <- coef(lmFit_V2)

coefs[[1]] + coefs[[2]]*200 + coefs[[3]]*3.5 + coefs[[4]]*1

##Build Full Model
lmFit_Full <- lm(mpg ~ .,data = mtcars)
#lmFit_Full <- lm(mpg ~ . - gear,data = mtcars)

mtcars$perdicted <- predict(lmFit_Full)

head(mtcars)

##Train RMSE
squared_error <- (mtcars$mpg - mtcars$perdicted) ** 2
(rmse <- sqrt(mean(squared_error)))

## Split Data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n,size=n*0.7)
train_data <- mtcars[id,]
test_data <- mtcars[-id,]

##Train Model
model1 <- lm(mpg ~ hp + wt + am + disp,data=train_data)
p_train <- predict(model1)
error_train <- train_data$mpg - p_train
(rmse_train <- sqrt(mean(error_train**2)))

##Test Model
p_test <- predict(model1,newdata = test_data)
error_test <- test_data$mpg - p_test
(rmse_test <- sqrt(mean(error_test**2)))

##Print Result
cat("RMSE Train:",rmse_train,
    "\nRMSE Test:",rmse_test)
