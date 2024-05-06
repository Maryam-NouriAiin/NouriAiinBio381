# ggplot basics
# 4 April 2024 ----
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(patchwork)

## ggplot
# P1 <- ggplot(data=<DATA>) +
#   aes(<MAPPING>) +
#   <GEOM_FUNCTION(aes(<MAPPING>),
#                  stat=<STAT>,
#                  <COORDINATE_FUNCTION> +
#                    <FACET_FUNCTION>
# print(p1)

# ggsave(plot=p1, 
#        filename="MyPlot",
#        idth=5,
#        height=3,
#        units="in",
#        device="pdf")

# Basic Graph Type
d <- mpg # use built in mpg data frame
str(d)
table(d$fl) 

# basic histogram plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram()

ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram(fill="khaki",color="black")


# # basic density plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_density(fill="mintcream",color="blue")


# basic scatter plot
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method="lm",col="red")

# add a smoother
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth()

# add a linear regression line
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth(method = "lm",col="red")


# basic boxplot
ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot()

# basic boxplot
ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot(fill="thistle")

# basic barplot (long format)

ggplot(data=d) +
  aes(x=fl) +
  geom_bar(fill="thistle",color="black")

# bar plot with specified counts or meansw
x_treatment <- c("Control","Low","High")
y_response <- c(12,2.5,22.9)
summary_data <- data.frame(x_treatment,y_response)

ggplot(data=summary_data) +
  aes(x=x_treatment,y=y_response) +
  geom_col(fill=c("grey50","goldenrod","goldenrod"),col="black")

# basic curves and functions
my_vec <- seq(1,100,by=0.1)

# plot simple mathematical functions
d_frame <- data.frame(x=my_vec,y=sin(my_vec))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()

# plot probability functions
# random numbers with gamma distribution
d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape=5, scale=3))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()

# plot user-defined functions
my_fun <- function(x) sin(x) + 0.1*x
d_frame <- data.frame(x=my_vec,y=my_fun(my_vec))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()




 