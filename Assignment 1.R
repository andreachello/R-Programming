
pollutantMean <- function(directory,  pollutant, id = 1:332) {
  
  #Get array of file names as strings
  files_list <- list.files(directory, full.names = TRUE)
  
  #Merge data on a single data frame by row
  database <- data.frame()
  
  for (i in 1:length(files_list)) {
    
    database <- rbind(database, read.csv(files_list[i]))
    
  }
  
  #Operations
  sub <- subset(database, ID %in% id)
  mean(sub[[pollutant]], na.rm = TRUE)
  
}


complete <- function(directory, id = 1:332) {
  
  #Returns a dataframe of the form:
  # Id nobs (number of complete cases)
  
  files_list <- list.files(directory, full.names = TRUE)
  database <- data.frame()
  
  for (i in 1:length(files_list)) {
    
    database <- rbind(database, read.csv(files_list[i]))
    
  }
  
  sub <- subset(database, ID %in% id)
  sum(complete.cases(sub))
  
}
