# First comment to explain what this program is doing.
# Be expansive and describe it in great detail. This may seem trivial, but will become increasingly important as you create complex programs.
# Simple script to examine the distribution of the product of two uniform variables
# Make sure it is readable. Use complete sentences, not cryptic phrases.
# 6 September 2018
# NJG

# Preliminaries
library(ggplot2)
set.seed(100) #to ensure reproducibility of data so everyone using the same seed get the same random number e.g. the following whoever sets seed at 100 gets the same randome 4 numbers:
#runif(4)
#[1] 0.2495337 0.5074827 0.5284712 0.5035891
library(TeachingDemos) # use this to set the random number seed from a character string
char2seed("green tea")
char2seed("green tea",set=FALSE)
# char2seeds generates random numbers


# Global variables
nRep <- 10000

# Create or read in data
ranVar1 <- rnorm(nRep)
# print(ranVar1)
head(ranVar1)
