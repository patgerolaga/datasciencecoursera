#The following is a set of functions that cache the inverse of a matrix

#This function creates a special "matrix" object that can cache its inverse
#Set the value of the matrix
makeCacheMatrix <- function(x = matrix()){
  inverse <- NULL
  set <- function (y) {
    x <<- y
    inv <<- NULL
  }
  #Get the value of the matrix
  get <- function() x
  #Set the value of the mean
  #Get the value of the mean
  setinv <- function(inv) inverse <<- inv
  getinv <- function() inverse
  list (set = set, get = get,
        setinv = setinv,
        getinv = getinv)
}

#This function computes the inverse of the special "matrix returned by makeCacheMatrix
cacheSolve <- function(x, ...){
  inverse <- x$getinv()
  if(!is.null(inverse)){
    message("Getting cached data")
    return(inverse)
  }
  data <- x$get()
  #The solve() function computes the inverse of a square matrix
  inverse <- solve(data, ...)
  x$setinv(inverse)
  inverse
}