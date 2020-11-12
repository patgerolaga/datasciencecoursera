pollutantmean <- function(directory, pollutant, id = 1:332){
 #create a list of files
  files_full <- list.files(directory, full.names = TRUE)
  #create an empty data frame
  dat <- data.frame()
  for (i in id)
  {
    #add files to main data
    dat <- rbind(dat, read.csv(files_full[i]))
  }
  #Calculate mean
  mean_data <- mean(dat[,pollutant], na.rm = TRUE)
  return(mean_data)
}
