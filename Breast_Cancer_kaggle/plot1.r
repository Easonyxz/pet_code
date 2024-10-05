# library(GGally)
# g.cancer_mean <- ggpairs(data_file[, c(3:11, 1)], aes(color = diagnosis, alpha = 0.75), lower = list(continuous = "smooth")) + theme_bw() +
#     labs(title = "Cancer Mean") +
#     theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))
# g.cancer_se <- ggpairs(data_file[, c(12:21, 1)], aes(color = diagnosis, alpha = 0.75), lower = list(continuous = "smooth")) + theme_bw() +
#     labs(title = "Cancer SE") +
#     theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))
# g.cancer_worst <- ggpairs(data_file[, c(22:31, 1)], aes(color = diagnosis, alpha = 0.75), lower = list(continuous = "smooth")) + theme_bw() +
#     labs(title = "Cancer Worst") +
#     theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))



# print(g.cancer_mean)

# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_mean",".png"), plot = g.cancer_mean, dpi = 200)
# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_se",".png"), plot = g.cancer_se, dpi = 200)
# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_worst",".png"), plot = g.cancer_worst, dpi = 200)


# data_cor <- data_file %>%
#     mutate(
#         diagnosis = ifelse(data_file$diagnosis == "M", 0, 1)
#     )
# source("draw_func/draw_corrplot.r")

# draw_corrplot(data_cor,title = "Cancer Correlation")




# g.knn <- ggplot(acc_data_knn, aes(x = k, y = acc)) +
#     geom_line(colour = "#0066ff", linewidth = 1.2) +
#     geom_point(size = 2.5) +
#     labs(
#         title = "KNN", subtitle = sub_k,
#         x = "Number of Neighbors(k)", y = "Accuracy",
#     ) +
#     theme(
#         plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12),
#         plot.subtitle = element_text(color = "black", hjust = 0.5, size = 10)
#     )
# print(g.knn)




# svm

# draw_roc(svm_roc_res, title = "SVM ROC CURVE")
# print(cm_svm)
source("draw_func/draw_confusion_matrix.r")
# draw_confusion_matrix(cm_svm, title = "SVM CONFUSION MATRIX",col_pos="#f5a29c",col_neg="#73dcdf",save_img =  F)


data= read.csv("data/123.csv")
data$real <- as.factor(data$real)
data$pred <- as.factor(data$pred)
print(head(data))
# cm= confusionMatrix(data$real ,data$pred,mode = "everything")
# print(cm)
# draw_confusion_matrix(cm)

svm_roc_res <- roc(
    data$real,
    data$Prob_0,
    auc = T
)
print(svm_roc_res)
source("draw_func/draw_roc.r")
roc.list <- roc(outcome ~ s100b + ndka + wfns, data = aSAH)
roc.list=append(roc.list,list(svm=svm_roc_res) )

draw_roc(roc.list, title = "SVM ROC 1CURVE",save_img = T )