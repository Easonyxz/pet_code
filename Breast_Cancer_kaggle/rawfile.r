library(e1071)
nrows <- NROW(data_file)
set.seed(218) ## fix random value
index <- sample(1:nrows, 0.7 * nrows) ## shuffle and divide

data_file.svm <- data_file %>%
    mutate(
        diagnosis = ifelse(data_file$diagnosis == "M", 0, 1)
    )
# train <- data_file                          ## 569 test data (100%)
train <- data_file.svm[index, ] ## 398 test data (70%)
test <- data_file.svm[-index, ] ## 171 test data (30%)


gamma <- seq(0, 0.1, 0.005)
cost <- 2^(0:5)
parms <- expand.grid(cost = cost, gamma = gamma) ## 231

acc_test <- numeric()
accuracy1 <- NULL
accuracy2 <- NULL

# for (i in 1:NROW(parms)) {
#     learn_svm <- svm(diagnosis ~ ., data = train, gamma = parms$gamma[i], cost = parms$cost[i])
#     pre_svm <- predict(learn_svm, test[, -1])
#     accuracy1 <- confusionMatrix(pre_svm, test$diagnosis)
#     accuracy2[i] <- accuracy1$overall[1]
# }

# acc <- data.frame(p = seq(1, NROW(parms)), cnt = accuracy2)

# opt_p <- subset(acc, cnt == max(cnt))[1, ]
# sub <- paste("Optimal number of parameter is", opt_p$p, "(accuracy :", opt_p$cnt, ") in SVM")
# learn_imp_svm <- svm(diagnosis ~ ., data = train, cost = parms$cost[opt_p$p], gamma = parms$gamma[opt_p$p])
# pre_imp_svm <- predict(learn_imp_svm, test[, -1])
# cm_imp_svm <- confusionMatrix(pre_imp_svm, test$diagnosis)

# print(cm_imp_svm)
# g.knn.raw <- ggplot(acc, aes(x = k, y = cnt)) +
#     geom_line(colour = "#0066ff", linewidth = 1.2) +
#     geom_point(size = 2.5) +
#     labs(
#         title = "KNN", subtitle = sub,
#         x = "Number of Neighbors(k)", y = "Accuracy",
#     ) +
#     theme(
#         plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12),
#         plot.subtitle = element_text(color = "black", hjust = 0.5, size = 10)
#     )
# print(g.knn.raw)
