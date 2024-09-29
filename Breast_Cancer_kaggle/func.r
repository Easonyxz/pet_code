source("draw_confusion_matrix.r")
knn_func <- function(train_data, test_data) {
    # KNN
    # 创建一个空向量，用于存储测试集的准确率
    acc_test_knn <- numeric()

    # 循环30次，每次改变k的值
    for (i in 1:30) {
        # 使用knn算法进行预测，并计算准确率
        predict_k <- knn(train = train_data[, -1], test = test_data[, -1], cl = train_data[, 1], k = i, prob = T)
        acc_test_knn <- c(acc_test_knn, mean(predict_k == test_data[, 1]))
    }

    # 将k和准确率存储在一个数据框中
    acc_data_knn <- data.frame(k = seq(1, 30), acc = acc_test_knn)
    # 找到准确率最高的k值
    opt_k <- subset(acc_data_knn, acc == max(acc))[1, ]
    # 输出最优的k值和对应的准确率
    sub_k <- paste("Optimal number of k is", opt_k$k, "(accuracy :", opt_k$acc, ") in KNN")

    pre_knn <- knn(train = train_data[, -1], test = test_data[, -1], cl = train_data[, 1], k = opt_k$k, prob = T)
    cm_knn <- confusionMatrix(pre_knn, test_data$diagnosis)


    draw_confusion_matrix(cm_knn, title = "KNN CONFUSION MATRIX")

    print("Complete KNN")
}
svm_func <- function(train_data, test_data) {
    learn_svm <- svm(diagnosis ~ ., data = train_data)
    pre_svm <- predict(learn_svm, test_data)
    cm_svm <- confusionMatrix(pre_svm, test_data$diagnosis)

    draw_confusion_matrix(cm_svm, title = "SVM CONFUSION MATRIX")

    print("Complete SVM")
}
cancer_diagnosis_predict <- function(pre_data, method = learn_svm) {
    new_pre <- predict(method, pre_data[, -1])
    new_res <- as.character(new_pre)
    return(new_res)
}
