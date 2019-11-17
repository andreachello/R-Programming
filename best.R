function(state, outcome) {
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #check to see valid input for outcomes
  outcome_list <- c("heart attack", "heart failure", "pneumonia")
  if (outcome %in% outcome_list == FALSE) stop("invalid outcome")
  
  #Rename the column names to avoid multiple if conditions
  data <- data[,c(2, 7, 11, 17, 23)]
  string <- c("name", "state", "heart attack", "heart failure", "pneumonia")
  for (i in 1:length(string)) {
    
    names(data)[i] <- string[i]
  }
  
  #Validate the state input
  if (state %in% unique(data$state) == FALSE) stop("invalid state")
  
  #Subset the data to allow for state and outcome row options
  data <- data[data$state == state & data[outcome] != "Not Available",]
  get_minimum <- which.min(data[,outcome])
  
  #Return the hospital name
  data[get_minimum, "name"]
}


#Best Case
if (num == "best") {
  
  x <- ordered_data[which.min(ordered_data[,"Rate"]), 1]
}

if (num == "worst") {
  
  x <- ordered_data[which.max(ordered_data[,"Rate"]), 1]
}

if (num != "best" & num != "worst") {
  
  x <- ordered_data[ordered_data["Rank"] == num, 1]
}

x
