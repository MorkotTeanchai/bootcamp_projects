#validate player select
validate_selected <- function(selected=0) {
  selected <- as.numeric(selected)
  if(selected >= 1 & selected <= 3){
    TRUE
  }else{
    FALSE
  }
}
print("+!+!+!+!+Welcome to  Pao Ying Chub Game +!+!+!+!+")
print("what's your name ?")
player_name <- readLines("stdin",n=1)
print(paste("Hello ",player_name,", Are you ready ? Y/N"))
ans <- readLines("stdin",n=1)
if(ans == "Y"){
 #declare valiable
  round <- 0
  win  <- 0
  loss <- 0
  same <- 0
  choice <- list(
    name = list("Paper","Scissors","Rock"),
    value = list(1,2,3)
  )
  while(ans == "Y"){
    round <- round + 1
    print("Your choices:")
    i <- 1
    while(i<= length(choice$name )){
      print(paste("  ",i,choice$name [[i]]))
      i <- i+1
    }
    valid_selected <- FALSE
    while(valid_selected != TRUE){
      print("Please select one:1/2/3")
      player_selected <- readLines("stdin",n=1)
      valid_selected <- validate_selected(player_selected)
    }
    # bot think
    bot_selected <- sample(1:3, 1)
    if( bot_selected == player_selected){
       same <- same + 1
      print("You Same !")
    }else{
      if(player_selected == 3){
        if(bot_selected == 1){ 
           loss <- loss +1
           print("You Loss !")
        }else{ #bot_selected == 2
           win <- win +1
           print("You Win !")
        }
      }
      else if(player_selected == 2){
        if(bot_selected == 1){ 
           win <- win +1
          print("You Win !")
        }
        else{ bot_selected == 3
          loss <- loss +1
          print("You Loss !")
        }
      }
      else{ # player_selected = 1
        if(bot_selected == 2){ 
          loss <- loss +1
          print("You Loss !")
        }
        else{ #bot_selected == 3
          win <- win +1
          print("You Win !")
        }
      }
    }
    print("Do you want to play again ? Y/N")
    ans <- readLines("stdin",n=1) 
  }
  #sum score
  print("|------------Summarize Your Score---------------|")
  print(paste("|     You play: ",round,"                            |"))
  print(paste("|     You win: ",win,"                            |"))
  print(paste("|     You loss: ",loss,"                           |"))
  print(paste("|     You same: ",same,"                          |"))
  print("|---------------------------------------------|")
}else{
  print("No problem,see you again. Bye")
}
