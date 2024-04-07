# ggplot basics
# 4 April 2024 ----
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(patchwork)

### ggplot
# P1 <- ggplot(data=<DATA>) +
#   aes(<MAPPING>) +
#   <GEOM_FUNCTION(aes(<MAPPING>),
#                  stat=<STAT>,
#                  <COORDINATE_FUNCTION> +
#                    <FACET_FUNCTION>
# print(p1)

ggsave(plot=p1, 
       filename="MyPlot",
       idth=5,
       height=3,
       units="in",
       device="pdf")

# Basic Graph Type
d <- mpg # use built in mpg data frame
str(d)
table(d$fl) 

# basic histogram
ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram()

# add color
ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram(fill="khaki",color="black")

ggplot(data=d) +
  aes(x=hwy, fill="red") +
  geom_histogram()



ggplot(data=d) +
  aes(x=hwy, fill="green") +
  geom_histogram()


ggplot(data=d) +
  aes(x=hwy, fill=I("green"), color=I("black")) +
  geom_histogram()




ggplot(data=d) +
  aes(x=hwy) +
  geom_density(fill= "mintcream", color="black")


ggplot(data=d) +
  aes(x=displ, y=hwy) +
  geom_point() +
  geom_smooth()
  

ggplot(data=d) +
  aes(x=displ, y=hwy) +
  geom_point() +
  geom_smooth(method="lm", col="red")


ggplot(data=d) +
  aes(x=displ, y=hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method="lm", col="red")

ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot() 


ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot(fill="thistle") 


ggplot(data=d) +
  aes(x=fl, y=cty, fill=fl) +
  geom_boxplot() 


# try new font 

p1 <- ggplot(data = d) +
  aes(x=displ, y=cty)+
  geom_point()
print(p1)

p1 + theme_classic()
p1 + theme_linedraw()
p1+ theme_dark()
p1+ theme_base()
p1+ theme_void()
p1+ theme_solarized()
p1+ theme_solarized_2()
p1+ theme_economist()
p1+ theme_economist_white()
p1+ theme_grey()


p1+ theme_classic(base_size = 40, base_family = "serif")

p2 <- ggplot(data=d) +
  aes(x=fl, fill= fl) +
  geom_bar()
print(p2)


p2 + coord_flip()+
  theme_grey(base_size = 20, base_family = "sans")
geom_bar()
print(p2)

p1 <- ggplot(data=d, mapping= aes(x=displ, y= cty)) +
  geom_point(size=7, shape=21, color="black", fill= "steelblue") +
  labs(title = "My graph title",
       subtitle = "an extended",
       x="my x axix",
       y="my y axis")+
  xlim(0,4) + ylim(0,20)
print(p1)
 