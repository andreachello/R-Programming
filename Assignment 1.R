

## Funtion 1 - Mean of Pollutant

pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  #Get a string arary of the file names with full directory path
  files <- list.files(directory, full.names = TRUE)
  data <- data.frame()
  
  #loop over the number of files to append them to the empty data frame
  for (i in 1:length(files)) {
    
    data <- rbind(data, read.csv(files[i]))
    
  }
  
  #subset the id range and compute mean of the non NA values of the chosen pollutant
  #Option 1 for subsetting over a range - if title of the range  is accessible from the final data fram
  sub_data <- subset(data, ID %in% id)
  mean(sub_data[[pollutant]], na.rm = TRUE)
  
}

## Function 2 - Sum of Complpete Cases

complete <- function(directory, id = 1:332) {
  
  #Create empty vector to be populated within the loop with the sum of the boolean observations
  files <- list.files(directory, full.names = TRUE)
  nobs <- c()
  
  #from the range(id range specified in the function)
  #Option 2 for subsetting over a range - if title of the range not accesible from the final data frame
  for (i in id) {
    
    #Create a temp data frame to calculate the number of observations with no NA 
    temp_file <- read.csv(files[i])
    nobs <- c(nobs, sum(complete.cases(temp_file[,2], temp_file[,3])))
    
  }
  
  #Create the data frame with the ids and nobs
  data.frame(id,nobs)
  
}

#Function 3 - Threshold for Complete Cases

corr <- function(directory, threshold = 0) {
  
  #Initialise the empty vector of correlations
  files <- list.files(directory, full.names = TRUE)
  vector_correlations <- c()
  
  for (i in 1:length(files)) {
    
    #Temporary data frame calculate the number of complete observations
    temp_file <- read.csv(files[i])
    nobs <- sum(complete.cases(temp_file[,2], temp_file[,3]))
    if (nobs > threshold) {
      
      #Subset the data frame with the complete values
      n <- complete.cases(temp_file[,2], temp_file[,3])
      temp_file <- subset(temp_file, n)
      
      #Append the correlations of those monitors observations that pass the threshold
      vector_correlations <- c(vector_correlations, cor(temp_file[,2], temp_file[,3]))
    }
    
    #If the threshold is not met, then go to next value of i
    else {
      
      next()
      
    }
    
  }
  
  vector_correlations
}
