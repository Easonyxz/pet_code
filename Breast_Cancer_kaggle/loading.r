library(tidyverse)
library(class)
library(caret)
library(e1071)

data_file <- read.csv("data/breast-cancer.csv")
# 删除NULL数据
data_file$X <- NULL
patient <- data_file
# 删除id列
data_file <- data_file[, -1]
# data_file$diagnosis <- factor(ifelse(data_file$diagnosis == "M", 0, 1))
data_file$diagnosis <- factor(data_file$diagnosis)
# breast_cancer_colnames.csv=sapply(data_file,class)
# write.csv(breast_cancer_colnames.csv,"data/breast_cancer_colnames.csv")



# # 随机打乱数据
# df_shuffled <- data_file %>% sample_frac(1)
# set.seed(123)

# # 将数据集分为训练集和测试集
# train_data <- df_shuffled %>% slice_sample(prop = 0.7)
# test_data <- df_shuffled %>% slice_sample(prop = 0.3)
# rm(df_shuffled)
# #  print( prop.table(table(train_data$diagnosis)))
# #  print( prop.table(table(test_data$diagnosis)))

nrows <- NROW(data_file)
set.seed(218) ## fix random value
index <- sample(1:nrows, 0.7 * nrows) ## shuffle and divide

# train <- wbcd                          ## 569 test data (100%)
train_data <- data_file[index, ] ## 398 test data (70%)
test_data <- data_file[-index, ] ## 171 test data (30%)

print("Complete loading ")

source("Breast_Cancer_kaggle/func.r")

# knn_func(train_data, test_data)

# svm
# svm_func(train_data, test_data)

t <- patient
orgin <- t$diagnosis
t$diagnosis <- NULL
r <- cancer_diagnosis_predict(t)


pre_res <- data.frame(id = patient$id)
pre_res <- pre_res %>%
    mutate(
        predict_diagnosis = r,
        orgin_diagnosis = patient$diagnosis,
        correct = ifelse(predict_diagnosis == orgin_diagnosis, "True", "False")
    )
write.csv(pre_res, "Breast_Cancer_kaggle/pre_res.csv")