


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
    print("Complete KNN")


    # cm_knn <- confusionMatrix(pre_knn, test_data$diagnosis)
    # draw_confusion_matrix(cm_knn, title = "KNN CONFUSION MATRIX")
    return(pre_knn)
}
get_svm_res <- function(svmfunc, dataset) {
# 使用svmfunc对dataset进行预测，并将结果存储在data_pred中，probability设为T表示返回概率值
    data_pred <- predict(svmfunc, newdata = dataset, probability = T)
# 使用dplyr包中的select、bind_cols函数将预测结果data_pred与原始数据集dataset合并，并将结果存储在data_pred_df中
    data_pred_df <- dataset %>%
        dplyr::select(diagnosis) %>%
        dplyr::bind_cols(status_pred = data_pred) %>%
        dplyr::bind_cols(attr(data_pred, "probabilities"))
}
svm_func <- function(train_data, test_data) {
    learn_svm <- svm(diagnosis ~ ., data = train_data, kernel = "radial", probability = TRUE)

    print("Complete SVM")
    return(learn_svm)
}

draw_roc <- function(roc_res, title = "ROC CURVE") {
    g.roc <- ggroc(roc_res, legacy.axes = TRUE, color = "red") +
        annotate("segment", x = 0, y = 0, xend = 1, yend = 1, linetype = "dashed", color = "#186F65") +
        theme_bw() +
        annotate("text", x = 0.75, y = 0.125, label = paste("AUC = ", round(roc_res$auc, 3)), size = 6) +
        ggtitle(title)
    print(g.roc)
}

cancer_diagnosis_predict <- function(pre_data, method) {
# 使用predict函数对pre_data数据进行预测，并将结果存储在new_pre中
    new_pre <- predict(method, pre_data[, -1])
# 将new_pre转换为字符型，并将结果存储在new_res中
    new_res <- as.character(new_pre)
    return(new_res)
}




# knn_res <- knn_func(train_data, test_data)
# prob <- attr(knn_res, "prob")
# prob <- ifelse(knn_res == "pos", prob, 1 - prob)
# print(head(prob))
# roc_knn <- roc(knn_res, prob)
# g.roc_knn <- ggroc(roc_knn, legacy.axes = TRUE) +
#     geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1),
#         color = "darkgrey", linetype = 4
#     ) +
#     theme_bw()
# print(g.roc_knn)
