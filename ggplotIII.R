#' ================================================
#' ggplot2 III
#' ================================================

remotes::install_github("wilkelab/cowplot")
install.packages("colorspace", repos = "http://R-Forge.R-project.org")

remotes::install_github("clauswilke/colorblindr")


library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
library(colorblindr)
library(cowplot)
library(colorspace)
library(wesanderson)
library(ggsci)
char2seed("Dark Star")
d <- mpg

# use to plot the counts of rows for a categorical variable
table(d$drv)
p1 <- ggplot(data=d,mapping=aes(x=drv)) + geom_bar(color="black",fill="goldenrod")
print(p1)

# aesthetic mapping gives multiple groups for each bar
p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar()
print(p1)


# stacked, but need to adjust color transparency, which is "alpha"
p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(alpha = 0.5, position="identity")
print(p1)

# better to use position = fill for stacking, but with equivalent height
p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(position="fill")
print(p1)

# best to use position = dodge for multiple bars
p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(position="dodge",color="black",size=1)
print(p1)

# more typical "bar plot" has heights as the values themselves
dTiny <- tapply(X=d$hwy,INDEX=as.factor(d$fl),FUN=mean) #calculate the means
dTiny <- data.frame(hwy=dTiny) # create a single-column data frame
dTiny <- cbind(fl=row.names(dTiny),dTiny) # 

p2 <- ggplot(data=dTiny, mapping=aes(x=fl,y=hwy,fill=fl)) +
  geom_col()
print(p2)


# basic boxplot is simple and informative
p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy,fill=fl)) +
  geom_boxplot()
print(p1)

# now overlay the raw data
p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy)) +
  geom_boxplot(fill="thistle",outlier.shape=NA) + 
  #geom_point()+
geom_point(position=position_jitter(width=0.2,height=0.7),color="grey60")

print(p1)


# from colorspace package

my_cols <- c("thistle","tomato","cornsilk","cyan","chocolate")
demoplot(my_cols,"map")
demoplot(my_cols,"bar")
demoplot(my_cols,"scatter")
demoplot(my_cols,"heatmap")
demoplot(my_cols,"spine")
demoplot(my_cols,"perspective")

# gray function versus gray colors

# built in greys (0 = black, 100 = white
my_greys <- c("grey20","grey50","grey80")
demoplot(my_greys,"bar")

my_greys2 <- grey(seq(from=0.1,to=0.9,length.out=10))         
demoplot(my_greys2,"heatmap")

# converting color plots to black and white
p1 <- ggplot(d,aes(x=as.factor(cyl),y=cty,fill=as.factor(cyl))) + geom_boxplot() 
plot(p1)

# default colors look identical in black white
p1_des<- colorblindr::edit_colors(p1, desaturate)
plot(p1_des)

# custom colors not pretty, but convert ok to bw
p2 <- p1 + scale_fill_manual(values=c("red","blue","green","yellow"))
plot(p2)
p2_des<- colorblindr::edit_colors(p2, desaturate)
plot(p2_des)


x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=2.7)
d_frame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control","Treatment"),each=100)
d_frame <- cbind(d_frame,lab)
str(d_frame)
h1 <- ggplot(d_frame) +
  aes(x=v1,fill=lab)
h1 + geom_histogram(position="identity",alpha=0.5,color="black") 


d <- mpg
# --------- discrete classification
# scale_fill_manual for boxplots,bars
# scale_color_manual for points, lines

# boxplot no color
p_fil <- ggplot(d) +
  aes(x=as.factor(cyl),y=cty)
p_fil + geom_boxplot()

# boxplot default ggplot fill
p_fil <- ggplot(d) +
  aes(x=as.factor(cyl),y=cty,fill=as.factor(cyl)) + 
  geom_boxplot()
plot(p_fil)

# create custom color palette
my_cols <- c("red","brown","blue","orange")

# boxplot with custom colors for fill
p_fil + scale_fill_manual(values=my_cols)

# scatterplot with no color
p_col <- ggplot(d) +
  aes(x=displ,y=cty)
p_col + geom_point(size=3)

# scatterplot default ggplot colors
p_col <- ggplot(d) +
  aes(x=displ,y=cty,col=as.factor(cyl)) + 
  geom_point(size=3)
plot(p_col)

# scatterplot with custom colors for point color
p_col + scale_color_manual(values=my_cols)

# ------- continuous classification (color gradient)

# default color gradient
p_grad <- ggplot(d) + 
  aes(x=displ,y=cty,col=hwy) + # hyw is a continious variable
  geom_point(size=3)
plot(p_grad)

# custom sequential gradient (2-colors)
p_grad + scale_color_gradient(low="blue", high="red")

# custom diverging gradient (3-colors)
mid <- median(d$cty)
p_grad + scale_color_gradient2(midpoint=mid,
                               low="blue",
                               mid="white",
                               high="red")

# custom diverging gradient (n-colors
p_grad + scale_color_gradientn(colors=c("blue","green","yellow","purple","orange"))


library(wesanderson)
print(wes_palettes)
demoplot(wes_palettes$BottleRocket1,"pie")
demoplot(wes_palettes[[9]][1:3],"bar")

my_cols <- wes_palettes$GrandBudapest2[1:4]
p_fil + scale_fill_manual(values=my_cols)


library(RColorBrewer)
display.brewer.all()
display.brewer.all(colorblindFriendly=TRUE)
demoplot(brewer.pal(4,"Accent"),"bar")
demoplot(brewer.pal(11,"Spectral"),"heatmap")

my_cols <- c("grey75",brewer.pal(3,"Blues"))
p_fil + scale_fill_manual(values=my_cols)

# nice for seeing hex values!
library(scales)

my_cols <- c("grey75",brewer.pal(3,"Blues"))
show_col(my_cols)



#### Making a heat map
xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar,yVar=yVar)
head(myData)
zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150)
myData <- cbind(myData,zVar)
head(myData)

# default gradient colors in ggplot
p4 <- ggplot(myData) +
  aes(x=xVar,y=yVar,fill=zVar) +
  geom_tile()
print(p4)

# user defined divergent palette
p4 + scale_fill_gradient2(midpoint=19,
                          low="brown",
                          mid=grey(0.8),
                          high="darkblue")


# viridis scale
p4  + scale_fill_viridis_c()
# options viridis, cividis, magma, inferno, plasma
p4 + scale_fill_viridis_c(option="turbo")

#desaturated viridis
p4 <- p4 + geom_tile() + scale_fill_viridis_c() 
p4des<-edit_colors(p4, desaturate)
ggdraw(p4des)







