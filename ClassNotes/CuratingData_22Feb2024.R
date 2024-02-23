# Curating data
# 22Feb2024
getwd()

# If data is not in the same dictionary
# we can use .. to go up one level, if you need to go higher you need /.. which looks like this: ../..
my_data <- read.table(file="../../ToyData.csv",
                      header=TRUE,
                      sep=",",
                      comment.char="#")

# If data is in the same dictionary
my_data <- read.table(file="OriginalData/ToyData.csv",
                      header=TRUE,
                      sep=",",
                      comment.char="#")
# inspect object
str(my_data)
# now add a column
my_data$newVar <- runif(4)
head(my_data)


write.table(x=my_data,
            file="../../ModifiedToyData0.csv",
            row.names=FALSE,
            sep=",")

saveRDS(my_data, file="../../Converted_csv.RDS") 
# .RDS suffix is not required, but good for clarity

data_in <-readRDS("../../Converted_csv.RDS")
