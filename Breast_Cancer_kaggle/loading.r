library(tidyverse)
library(class)
library(caret)


data_file <- read.csv("data/breast-cancer.csv")
# 删除NULL数据
data_file$X <- NULL
# 删除id列
data_file <- data_file[, -1]
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
# print("Complete loading ")

# # KNN
# # 创建一个空向量，用于存储测试集的准确率
# acc_test_knn <- numeric()

# # 循环30次，每次改变k的值
# for (i in 1:30) {
#     # 使用knn算法进行预测，并计算准确率
#     predict <- knn(train = train_data[, -1], test = test_data[, -1], cl = train_data[, 1], k = i, prob = T)
#     acc_test_knn <- c(acc_test_knn, mean(predict == test_data[, 1]))
# }

# # 将k和准确率存储在一个数据框中
# acc_data_knn <- data.frame(k = seq(1, 30), acc = acc_test_knn)
# # 找到准确率最高的k值
# opt_k <- subset(acc_data_knn, acc == max(acc))[1, ]
# # 输出最优的k值和对应的准确率
# sub_k <- paste("Optimal number of k is", opt_k$k, "(accuracy :", opt_k$acc, ") in KNN")

# pre_knn <- knn(train = train_data[, -1], test = test_data[, -1], cl = train_data[, 1], k = opt_k$k, prob = T)


# print("Complete KNN")
