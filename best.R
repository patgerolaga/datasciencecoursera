best<- function(state,outcome){
  
  # outcome is the condition interested in finding and state is the state code
  # we want to identify the conditions in the file with easier names so its easy 
  # for user to input the conditions by using the outcomes vector
  outcomes <- c("heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  if(outcome %in% names(outcomes)){
    
    # Function runs for our predefined outcomes so code works only if you enter 
    # heart attack, heart failure or pneumonia eles you get invalid outcome 
    
    filedata <-read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # file read into filedata with assumption the file is at same location as your R working directory.
    
    if (state %in% filedata[["State"]]){
      
      #Here we check to see that the user input the correct state code example TX for texas as it is in the file
      # because this is important for our analysis to work for the state
      
      state_vect <- filedata["State"] == state
      # state_vect contains only given state appearing at their locations in filedata
      
      outcome <- outcomes[[outcome]]
      # outcome is now assigned the corresponding  condition description as is in the file
      
      workdata <- filedata[state_vect, c("Hospital.Name", "State",outcome)]
      # workdata is a subset of original data based on our state_vect
      
      workdata[,outcome] <- as.numeric(workdata[,outcome])
      # Data cleaning to make sure we have numeric values in the outcome column.
      # if that data is not numeric we get NA and do not consider that sample for  our analysis
      
      good <- !is.na(workdata[outcome])
      # good is a vector of of trues where given condition does not have value of NA
      
      workdata <- workdata[good,]
      # We re-subset workdata to get only the good data for analysis without NAs
      
      sortdata <- workdata[order(workdata[outcome],workdata["Hospital.Name"]),]
      # Sortdata is workdata ordered in ascending order based on the outcome, followed by the hospital name.
      # This means the hospital with the smallest outcome will come first and if there is a tie,
      #we break it by alphabetical ordering of the hospital name.
      
      sortdata[1,"Hospital.Name"]
      # Finally, we output the hospital name at the row 1 as the hospital that has lowest death count.
      
    }
    else{
      stop('Invalid State')
      # if user input the wrong state, we output Invalid Sate and stop the execution
    }
  }
  else{
    stop('Invalid Outcome')
    #if user input wrong condition, we output invalid output and stop execution.
  }
}