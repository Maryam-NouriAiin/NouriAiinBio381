# Matrices, Lists, & Data Frames
# 8 Feb 2024


# a matrix is an atomic vector that is organized into rows and columns
my_vec <- 1:12
m <- matrix(data=my_vec,nrow=4)
print(m)
m <- matrix(data=my_vec,ncol=3)
print(m)
m <- matrix(data=my_vec,ncol=3,byrow=TRUE)
print(m)

my_m_data<- c(1,2,3,
              4,5,6,
              7,8,9)
my_new_matrix <- matrix(data=my_m_data, nrow=3, byrow=TRUE)
print(my_new_matrix)


# Lists are atomic vectors but each element
# can hold things of different types and different sizes
myList <- list(1:10, matrix(1:8,nrow=4,byrow=TRUE), letters[1:3],pi)
str(myList)
print(myList)
# using [] gives you a single item, which is of type list
myList[4]
#myList[4] - 3 # no, can't subtract a number from a list!
# single brackets gives you only the element in that slot, which is always of type list
# to grab the object itself, use [[]]
myList[[4]]
myList[[4]] - 3 # now we have the contents
# if a list has 10 elements it is like a train with 10 cars
# [[5]] gives you the contents of car #5, create a train with just car 5
##[c(4,5,6)] gives you a little train with cars 4, 5, and 6
# once the double bracket is called, you can access individual elements as before
myList[[2]]
myList[[2]][4,1]
# name list items when they are created
myList2 <- list(Tester=FALSE,littleM=matrix(1:9,nrow=3))
print(myList2)

# named elements can be accessed with dollar sign
myList2$littleM[2,3] # get row 2, column3
myList2$littleM # show whole matrix
myList2$littleM[2,] # show second row, all columns
myList2$littleM[2] # what does this give you?
# The "unlist" strings everything back into
# a single atomic vector; coercion is used if there are mixed data types
unRolled <- unlist(myList2)
print(unRolled)
# The most common use of list: output from a linear model is a list
library(ggplot2)
yVar <- runif(10)
xVar <- runif(10)


myModel <- lm(yVar~xVar)
qplot(x=xVar,y=yVar)
# look at output in myModel
print(myModel)
# full results are in summary
print(summary(myModel))
# drill down into summary to get what we want
str(summary(myModel))
summary(myModel)$coefficients
summary(myModel)$coefficients["xVar","Pr(>|t|)"]
summary(myModel)$coefficients[2,4]
# use unlist instead
u <- unlist(summary(myModel))
print(u)
mySlope <- u$coefficients2
myPval <- u$coefficients8


# a data frame is a list of equal-lengthed vectors, each of which is a column
varA <- 1:12
varB <- rep(c("Con","LowN","HighN"),each=4)
varC <- runif(12)
dFrame <- data.frame(varA,varB,varC,stringsAsFactors=FALSE)
print(dFrame)
str(dFrame)
# add another row with rbind
# make sure you add a list, with each item corresponding to a column
# newData <- data.frame(list(varA=13,varB="HighN",varC=0.668),stringsAsFactors=FALSE)
newData <- list(varA=13,varB="HighN",varC=0.668)
print(newData)
str(newData)
# now bind them
dFrame <- rbind(dFrame,newData)
str(dFrame)
tail(dFrame)

# adding another column is a little easier
#newVar <- data.frame(varD=runif(13))
newVar <- runif(13)
dFrame <- cbind(dFrame,newVar)
head(dFrame)


# create a matrix and data frame with same structures 
zMat <- matrix(data=1:30,ncol=3,byrow=TRUE) 
zDframe <- as.data.frame(zMat) # coerce it
str(zMat) # an atomic vector with 2 dimensions 
str(zDframe) # note horizontal layout of variabes!
head(zDframe) # note automatic variable names 
head(zMat) # note identical layout
# element referencing is the same in both 
zMat[3,3]
zDframe[3,3]
# so is column referencing
zMat[,3]
zDframe[,3]
zDframe$V3 # note use of $ and named variable column
# and row referencing
zMat[3,]
zDframe[3,] # note variable names and row number shown
# what happens if we reference only one dimension?
zMat[2] # takes the second element of atomic vector (column fill)
zDframe[2] # takes second atomic vector (= column) from list
zDframe["V2"]
zDframe$V2

#########################
# use complete.cases with atomic vector
print(zDframe)
zDframe[2,2] <- NA
complete.cases(zDframe$V2)
zDframe$V2[complete.cases(zDframe$V2)]

zDframe[complete.cases(zDframe)] # clean them out, does not have the column gives an error

which(!complete.cases(zDframe)) # find NA slots
which(complete.cases(zDframe)) # find not in NA slots

# use with a matrix
m <- matrix(1:20,nrow=5)
m[1,1] <- NA
m[5,4] <- NA
print(m)
m[complete.cases(m),]
# now get complete cases for only certain columns!
m[complete.cases(m[,c(1,2)]),] # drops row 1
m[complete.cases(m[,c(2,3)]),] # no drops
m[complete.cases(m[,c(3,4)]),] # drops row 4
m[complete.cases(m[,c(1,4)]),] # drops 1&4






# same principle applied to both dimensions of a matrix
m <- matrix(data=1:12,nrow=3)
dimnames(m) <- list(paste("Species",
                          LETTERS[1:nrow(m)],
                          sep=""),
                    paste("Site",1:ncol(m),sep=""))
print(m)
# subsetting based on elements
m[1:2,3:4]
# same subsetting based on character strings (but no negative elements)
m[c("SpeciesA","SpeciesB"), c("Site3","Site4")]
# use blanks before or after comma to indicate full rows or columns
m[1:2, ]
m[ ,3:4]
# use logicals for more complex subsetting
# e.g. select all columns for which the totals are > 15
# first try this logical
colSums(m)
colSums(m) > 15
m[ , colSums(m) > 15]
# e.g. select all rows for which the row total is 22
m[rowSums(m)==22, ]
# note == for logical equal and != for logical NOT equal
m[rowSums(m)!=22, ]
# e.g., choose all rows for which numbers for site 1 are less than 3
# AND choose all columns for which the numbers for species A are less than 5
# first, try out this logical for rows
m[ ,"Site1"]<3
# add this in and select with all columns
m[m[ ,"Site1"]<3, ]
# and try this logical for columns
m["SpeciesA", ]<5
# add this in and select with all rows
m[ ,m["SpeciesA", ]<5]
# now combine both
m[m[ ,"Site1"]<3,m["SpeciesA", ]<5]
# and compare with full m

print(m)


# caution! simple subscripting to a vector changes the data type!
z <- m[1, ]
print(z)
str(z)
# to keep this as a matrix, must add the drop=FALSE option
z2 <- m[1, ,drop=FALSE]
print(z2)
str(z2)
# caution #2, always use both dimensions, or you will select a single matrix element
m2 <- matrix(data=runif(9),nrow=3)
print(m2)
m2[2, ]
# but now this will just pull the second element
m2[2]
# probably should specify row and column indicators
m2[2,1]
# also use logicals for assignments, not just subsetting
m2[m2>0.6] <- NA
print(m2)
# A few changes for working with data frames:
data <-read.csv(file="antcountydata.csv",header=TRUE,sep=",",stringsAsFactors=FALSE)
str(data)
# the data frame is a list of vectors, so it is set up like a matrix
data[3,2]
# you can specify just the column names
dataNames <- data[c("state","county")]
str(dataNames)
# or in matrix style
dataNames <- data[ ,c("county", "ecoregion")]
str(dataNames)
# as before, with matrices, selecting only a single column changes it
# from a data frame to a vector
dataNames <- data[ ,"county"]
str(dataName)


