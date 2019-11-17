rankhospital <- function(state, outcome, num = "best") {
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #Validate outcomes
  outcome_list <- c("heart attack", "heart failure", "pneumonia")
  if (outcome %in% outcome_list == FALSE) stop("invalid outcome")
  
  #Change names
  data <- data[,c(2, 7, 11, 17, 23)]
  string <- c("name", "state", "heart attack", "heart failure", "pneumonia")
  
  for (i in 1:length(string)) {
    
    names(data)[i] <- string[i]
  }
  
  #Validate the states
  if (state %in% unique(data$state) == FALSE) stop("invalid state")
  
  #Validate number
  if(num != "best" & num != "worst" & num %% 1 != 0) stop("invalid num")
  
  #Get array of death rates
  data <- data[data$state == state & data[outcome] != "Not Available", ]
  
  data[outcome] <- sapply(data[outcome], as.numeric)
  #Order by name
  data <- data[order(data$name), ]
  #order by outcome
  data <- data[order(data[outcome]), ]
  
  best <- which.min(data[,outcome])
  worst <- which.max(data[,outcome])
  
  #Best Case
  if (num == "best") {
    
    index <- best
  }
  
  else if (num == "worst") {
    
    index <- worst
  }
  
  else {
    
    index <- num
  }
  
  data[index, "name"]
  
}
