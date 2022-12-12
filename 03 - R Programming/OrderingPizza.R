print("+!+!+!+!+Welcome to Pizza World +!+!+!+!+")
print("what's your name ?")
cust_name <- readLines("stdin",n=1)
print(paste("Hello (^v^):",cust_name))
#declare menu
pizza <- list(
  menu = list("Seafood Cocktail","Spicy Super Seafood","Seafood Deluxe"),
  price = list(299,419,359)
)
appetizer <- list(
  menu = list("Calamari","Fish Fingers","Baked Spinach"),
  price = list(99,89,179)
)
salad <- list(
  menu = list("Caesar Salad","Garden Salad with fried Chicken","Garden Salad with Salad Cream"),
  price = list(149,189,129)
)
drinks <- list(
  menu = list("Coke 1.25 Ltr.","Coke (NO SUGAR) 1.25 Ltr.","Sprite 1.25 Ltr."),
  price = list(32,32,32)
)
#declare order
order <- list(
  0, #pizza
  0, #appetizer
  0, #salad
  0  #drinks
)
print("Do you want to order pizza?:Y/N")  #pizza
ans <- readLines("stdin",n=1)
if(ans=="Y"){
  i <- 1
  print("Please select one:1/2/3")
  while(i<= length(pizza$menu)){
    print(paste(i,pizza$menu[[i]],"--->",pizza$price[[i]],"$"))
    i <- i+1
  }
  order[1] <- readLines("stdin",n=1) 
}
print("Do you want to order appetizers?:Y/N")  #appetizer
ans <- readLines("stdin",n=1)
if(ans=="Y"){
  print("Please select one:1/2/3")
  i <- 1
  while(i<= length(appetizer$menu)){
    print(paste(i,appetizer$menu[[i]],"--->",appetizer$price[[i]],"$"))
    i <- i+1
  }
  order[2] <- readLines("stdin",n=1) 
}
print("Do you want to order salad?:Y/N") #salad
ans <- readLines("stdin",n=1)
if(ans=="Y"){
  print("Please select one:1/2/3")
  i <- 1
  while(i<= length(salad$menu)){
    print(paste(i,salad$menu[[i]],"--->",salad$price[[i]],"$"))
    i <- i+1
  }
  order[3] <- readLines("stdin",n=1) 
}
print("Do you want to order drinks?:Y/N") #drinks
ans <- readLines("stdin",n=1)
if(ans=="Y"){
  print("Please select one:1/2/3")
  i <- 1
  while(i<= length(drinks$menu)){
    print(paste(i,drinks$menu[[i]],"--->",drinks$price[[i]],"$"))
    i <- i+1
  }
  order[4] <- readLines("stdin",n=1) 
}
i <- 1
total <- 0
order_pizza <- "Pizza: "
order_appetize <- "Appetizer: "
order_salad <- "Salad: "
order_drinks <- "Drinks: "
  while(i<= length(order)){
    if(i == 1 & order[[i]] != 0){ #pizza
      total = pizza$price[[as.numeric(order[i])]]
      order_pizza <- paste(pizza$menu[[as.numeric(order[i])]]," = ", pizza$price[[as.numeric(order[i])]])
    }else if(i == 2 & order[[i]] != 0){ #appetizer
      total = total + appetizer$price[[as.numeric(order[i])]]
      order_appetizer <- paste(appetizer$menu[[as.numeric(order[i])]]," = ", appetizer$price[[as.numeric(order[i])]])
    }
    else if(i == 3 & order[[i]] != 0){ #salad
       total = total + salad$price[[as.numeric(order[i])]]
       order_salad <- paste(salad$menu[[as.numeric(order[i])]]," = ", salad$price[[as.numeric(order[i])]])
    }else if(order[[i]] != 0) {#drinks
       total = total + drinks$price[[as.numeric(order[i])]]
      order_drinks <- paste(drinks$menu[[as.numeric(order[i])]]," = ", drinks$price[[as.numeric(order[i])]])
    }
    i <- i+1
  }
if (total == 0) {
  print("No order,Thank you see you again...")
}else{
 print("|------------Sumarize Your Order---------------|")
 print(order_pizza)
 print(order_appetize)
 print(order_salad)
 print(order_drinks)
 print("|---------------------------------------------|")
 print(paste("|-----------","Total Amount: ",total ," $","-----------|"))
 print("|---------------------------------------------|")
 print("| Thank you for Your order,                   |")
 print("|---------------------------------------------|")
}
