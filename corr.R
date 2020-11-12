corr <- function(directory, threshold = 0)
{
  #create list of all files
  files_full <- list.files(directory, full.names= TRUE)
  # create empty data set
  dat <- vector(mode = "numeric", length = 0)
  for(i in 1:length(files_full))
  {
    # Read File
    tmp <- read.csv(files_full[i])
    
    #Calculate csum    
    csum <- sum((!is.na(tmp$sulfate)) & (!is.na(tmp$nitrate)))
    if (csum > threshold)
    {
      #Extract data of nitrate and sulfate and calculate correlation between them
      sul <- tmp[which(!is.na(tmp$sulfate)), ]
      nit <- sul[which(!is.na(sul$nitrate)), ]
      dat <- c(dat, cor(nit$sulfate, nit$nitrate))
    }
  }
  
  dat
}