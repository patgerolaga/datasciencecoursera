complete <- function(directory, id = 1:332)
{
  #Create a list of file
  files_full <- list.files(directory, full.names= TRUE)
  # Create empty data frame 
  dat <- data.frame()
  for (i in id)
  {
    # Read files
    temp <- read.csv(files_full[i])
    # nobs are sum of all complete cases
    nobs <-sum(complete.cases(temp))
    # Enamurtates complete cass by index
    dat <-rbind(dat, data.frame(i, nobs))
    
  }
  colnames(dat) <- c("id", "nobs")
  return(dat)
}