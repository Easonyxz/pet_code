library(tidyverse)
library(class)
library(caret)
library(e1071)
library(pROC)

data_file <- read.csv("data/breast-cancer.csv")
# 删除NULL数据
data_file$X <- NULL
patient <- data_file
pre_data <- patient
orgin_diagnosis_res <- pre_data$diagnosis
pre_data$diagnosis <- NULL
# 删除id列
data_file$id <- NULL
# data_file$diagnosis <- factor(ifelse(data_file$diagnosis == "M", 0, 1))
data_file$diagnosis <- factor(data_file$diagnosis)

# write.csv(data_file,"data/breast_cancer_new.csv")



# 随机打乱数据
df_shuffled <- data_file %>% sample_frac(1)
set.seed(123)

# 将数据集分为训练集和测试集
train_data <- df_shuffled %>% slice_sample(prop = 0.7)
test_data <- df_shuffled %>% slice_sample(prop = 0.3)
rm(df_shuffled)
 print( prop.table(table(train_data$diagnosis)))
 print( prop.table(table(test_data$diagnosis)))

source("Breast_Cancer_kaggle/func.r")
# svm
svmRadial <- svm_func(train_data, test_data)
svm_pred_df <- get_svm_res(svmRadial, train_data)
# # roc
# svm_roc_res <- roc(
#     svm_pred_df$diagnosis,
#     svm_pred_df$B,
#     auc = T,
#     smooth = TRUE
# )
# print(svm_roc_res)
# confusionMatrix
# cm_svm <- confusionMatrix(svm_pred_df$diagnosis,
#     svm_pred_df$status_pred,
#     mode = "everything"
# )

print("Complete loading ")
