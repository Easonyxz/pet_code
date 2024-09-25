library(tidyverse)
library(GGally)

start_time <- Sys.time()
print("123")
data_file <- read.csv("data/breast-cancer.csv")
# 删除NULL数据
data_file$X <- NULL
# 删除id列
data_file <- data_file[, -1]
# breast_cancer_colnames.csv=sapply(data_file,class)
# write.csv(breast_cancer_colnames.csv,"data/breast_cancer_colnames.csv")




print("123")
end_time <- Sys.time()
print(end_time - start_time)
