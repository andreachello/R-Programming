rankall <- function(outcome, num = "best") {
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #Validate outcomes
  outcome_list <- c("heart attack", "heart failure", "pneumonia")
  if (outcome %in% outcome_list == FALSE) stop("invalid outcome")
  
  #Narrow data frame and change names
  data <- data[,c(2, 7, 11, 17, 23)]
  string <- c("name", "state","heart attack", "heart failure", "pneumonia")
  for (i in 1:length(string)) {
    names(data)[i] <- string[i]
  }
  
  states <- unique(data$state)
  
  data <- data[data[outcome] != "Not Available", ]
  
  #Get as numeric
  data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))
  #Order by hospital name
  data <- data[order(data$name), ]
  #order by outcome
  data <- data[order(data[outcome]), ]
  
  newdata <- data.frame("hospital"=character(), "state"=character())
  
  for (i in states) {
    #Subset for each state
    individual_state <- data[data$state == i,]
    
    if (num == "best") {
      index <- which.min(individual_state[,outcome])
    }
    else if (num == "worst") {
      index <- which.max(individual_state[,outcome])
    }
    else {
      index <- num
    }
    
    hosp <- individual_state[index, "name"]
    
    #Merge the existing data frame with the new data from the ranked hospital data
    newdata <- rbind(newdata, data.frame(hospital=hosp, state=i))
  }
  
  newdata
}
