library(ggplot2)
library(MASS)
#-------------------------------------------------
# Poisson distribution
# Discrete X >= 0
# Random events with a constant rate lambda
# (observations per time or per unit area)
# Parameter lambda > 0

# "d" function generates probability density
hits <- 0:10
myVec <- dpois(x=hits,lambda=1)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

myVec <- dpois(x=hits,lambda=2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

hits <- 0:15
myVec <- dpois(x=hits,lambda=6)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


hits <- 0:15
myVec <- dpois(x=hits,lambda=0.2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

sum(myVec)  # sum of density function = 1.0 (total area under curve)

# for a Poisson distribution with lambda=2, 
# what is the probability that a single draw will yield X=0?

dpois(x=0,lambda=2)

# "p" function generates cumulative probability density; gives the 
# "lower tail" cumulative area of the distribution

hits <- 0:10
myVec <- ppois(q=hits,lambda=2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


# for a Poisson distribution with lambda=2, 
# what is the probability of getting 1 or fewer hits?

ppois(q=1, lambda=2)


# We could also get this through dpois
p_0 <- dpois(x=0,lambda=2)
p_0
p_1 <- dpois(x=1,lambda=2)
p_1
p_0 + p_1


# The q function is the inverse of p
# What is the number of hits corresponding to 50% of the probability mass
qpois(p=0.5,lambda=2.5)
qplot(x=0:10,y=dpois(x=0:10,lambda=2.5),geom="col",color=I("black"),fill=I("goldenrod"))

# but distribution is discrete, so this is not exact
ppois(q=2,lambda=2.5)

# finally, we can simulate individual values from a poisson
ranPois <- rpois(n=1000,lambda=2.5)
qplot(x=ranPois,color=I("black"),fill=I("goldenrod"))


# for real or simulated data, we can use the quantile
# function to find the empirical  95% confidence interval on the data

quantile(x=ranPois,probs=c(0.025,0.975))



#-------------------------------------------------
# Binomial distribution
# p = probability of a dichotomous outcome
# size = number of trials
# x = possible outcomes
# outcome x is bounded between 0 and number of trials

# use "d" binom for density function
hits <- 0:10
myVec <- dbinom(x=hits,size=10,prob=0.5)
qplot(x=0:10,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))



# and how does this compare to an actual simulation of 50 tosses of 100 coins?

myCoins <- rbinom(n=50,size=100,prob=0.5)
qplot(x=myCoins,color=I("black"),fill=I("goldenrod"))
quantile(x=myCoins,probs=c(0.025,0.975))


#-------------------------------------------------
# negative binomial: number of failures (values of MyVec)
# in a series of (Bernouli) with p=probability of success 
# before a target number of successes (= size)
# generates a discrete distribution that is more 
# heterogeneous ("overdispersed") than Poisson
hits <- 0:40
myVec <- dnbinom(x=hits, size=5, prob=0.5)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))



hits <- 0:40
myVec <- dnbinom(x=hits, size=5, prob=0.2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))
# geometric series is a special case where N= 1 success
# each bar is a constant fraction 1 - "prob" of the bar before it
myVec <- dnbinom(x=hits, size=1, prob=0.1)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


# alternatively specify mean = mu of distribution and size, 
# the dispersion parameter (small is more dispersed)
# this gives us a poisson with a lambda value that varies
# the dispersion parameter is the shape parameter in the gamma
# as it increases, the distribution has a smaller variance
# just simulate it directly

nbiRan <- rnbinom(n=1000,size=10,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))

nbiRan <- rnbinom(n=1000,size=0.1,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))


#-------------------------------------------------
# uniform
# params specify minimum and maximum

#runif for random data
qplot(x=runif(n=100,min=0,max=5),color=I("black"),fill=I("goldenrod"))
qplot(runif(n=1000,min=0,max=5),color=I("black"),fill=I("goldenrod"))
#-------------------------------------------------


# normal 
myNorm <- rnorm(n=100,mean=100,sd=2)
qplot(myNorm,color=I("black"),fill=I("goldenrod"))

# problems with normal when mean is small but zero is not allowed.
myNorm <- rnorm(n=100,mean=2,sd=2)
qplot(myNorm,color=I("black"),fill=I("goldenrod"))
summary(myNorm)
tossZeroes <- myNorm[myNorm>0]
qplot(tossZeroes,color=I("black"),fill=I("goldenrod"))
summary(tossZeroes)


#-------------------------------------------------
# gamma distribution, continuous positive values, but bounded at 0

myGamma <- rgamma(n=100,shape=1,scale=10)
qplot(myGamma,color=I("black"),fill=I("goldenrod"))

# gamma with shape= 1 is an exponential with scale = mean

# shape <=1 gives a mode near zero; very small shape rounds to zero
myGamma <- rgamma(n=100,shape=0.1,scale=1)
qplot(myGamma,color=I("black"),fill=I("goldenrod"))

# large shape parameters moves towards a normal
myGamma <- rgamma(n=100,shape=20,scale=1)
qplot(myGamma,color=I("black"),fill=I("goldenrod"))

# scale parameter changes mean- and the variance!
qplot(rgamma(n=100,shape=2,scale=100),color=I("black"),fill=I("goldenrod"))
qplot(rgamma(n=100,shape=2,scale=10),color=I("black"),fill=I("goldenrod"))
qplot(rgamma(n=100,shape=2,scale=1),color=I("black"),fill=I("goldenrod"))
qplot(rgamma(n=100,shape=2,scale=0.1),color=I("black"),fill=I("goldenrod"))


# unlike the normal, the two parameters affect both mean and variance

# mean = shape*scale
# variance= shape*scale^2


#-------------------------------------------------

# beta distribution 
# bounded at 0 and 1
# analagous to a binomial, but result is a continuous distribution of probabilities
# parameter shape1 = number of successes + 1
# parameter shape2 = number of failures + 1
# interpret these in terms of a coin you are tossing

# shape1 = 1, shape2 = 1 = "no data"
myBeta <- rbeta(n=1000,shape1=1,shape2=1)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))


# shape1 = 2, shape1 = 1 = "1 coin toss, comes up heads!"
myBeta <- rbeta(n=1000,shape1=2,shape2=1)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))

# two tosses, 1 head and 1 tail
myBeta <- rbeta(n=1000,shape1=2,shape2=2)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))

# two tosses, both heads
myBeta <- rbeta(n=1000,shape1=2,shape2=1)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))

# let's get more data
myBeta <- rbeta(n=1000,shape1=20,shape2=20)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))

myBeta <- rbeta(n=1000,shape1=500,shape2=500)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))

# if the coin is biased
myBeta <- rbeta(n=1000,shape1=1000,shape2=500)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))
myBeta <- rbeta(n=1000,shape1=10,shape2=5)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))


# shape parameters less than 1.0 give us a u-shaped distribution
myBeta <- rbeta(n=1000,shape1=0.1,shape2=0.1)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))
myBeta <- rbeta(n=1000,shape1=0.5,shape2=0.2)
qplot(myBeta,xlim=c(0,1),color=I("black"),fill=I("goldenrod"))


library(tidyverse)

