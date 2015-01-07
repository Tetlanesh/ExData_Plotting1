#Programming Assignment 1: Air Pollution

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  pliki<-list.files(directory, full.names=TRUE)[id]

  pframe<-data.frame()
  for (i in seq_along(pliki)) {
    file<-read.csv(pliki[i])
    
    pframe <- rbind(pframe, c(id[i],length(file[!is.na(file$nitrate)&!is.na(file$sulfate),]$ID)))
  }
  colnames(pframe)<-c("ID","nobs")
  pframe

}