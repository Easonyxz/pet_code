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

# g.cancer_mean_cor <- ggcorr(data_file[, c(2:11)], name = "corr", label = TRUE) +
#     theme(legend.position = "none") +
#     labs(title = "Cancer Mean Correlation ") +
#     theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))
# g.cancer_se_cor <- ggcorr(data_file[, c(12:21)], name = "corr", label = TRUE) +
#     theme(legend.position = "none") +
#     labs(title = "Cancer SE Correlation") +
#     theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))
# g.cancer_worst_cor <- ggcorr(data_file[, c(22:31)], name = "corr", label = TRUE) +
#     theme(legend.position = "none") +
#     labs(title = "Cancer Worst Correlation") +
#     theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))

# print(g.cancer_mean)
# ggsave("Breast_Cancer_kaggle/img/g.cancer_se_cor.png", plot = g.cancer_se_cor, dpi = 200)
# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_worst_cor",".png"), plot = g.cancer_worst_cor, dpi = 200)
# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_mean",".png"), plot = g.cancer_mean, dpi = 200)
# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_se",".png"), plot = g.cancer_se, dpi = 200)
# ggsave(paste("Breast_Cancer_kaggle/img/g.cancer_worst",".png"), plot = g.cancer_worst, dpi = 200)

# library(corrplot)
# data_cor <- data_file %>%
#     mutate(
#         diagnosis = ifelse(data_file$diagnosis == "M", 0, 1)
#     )
# g.cor.data <- cor(data_cor)
# g.cor.mtestdata <- cor.mtest(data_cor, conf.level = 0.95)
# # png("Breast_Cancer_kaggle/img/g.cor.png", width = 800, height = 800)
# corrplot(
#     g.cor.data,method = "circle",
#     p.mat = g.cor.mtestdata$p, sig.level = 0.05,
#     order = "hclust", tl.col = "black", tl.srt = 45, tl.pos = "lt"
# )
# dev.off()




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

library(scales)
g_pre_res <- count(pre_res, correct)

g_pre_res <- g_pre_res %>%
    mutate(
        percentage = round(n / sum(n), 3),
        per_str = paste( correct,":", percentage * 100, "%", sep = "")
    ) %>%
    arrange(desc(percentage))
print(g_pre_res)
write.csv(g_pre_res, "Breast_Cancer_kaggle/g_pre_res.csv")
# pie(g_pre_res$percentage, labels=g_pre_res$per_str,
#     radius = 1.0,clockwise=T,
#     col=c("#E44A33", "#4DBAD6"),
#   )
# g.pre_res <- ggplot(g_pre_res, aes(
#     x = "", y = n, fill = c("black", "white")
# )) +
#     geom_bar(stat = "identity", position = "stack", color = "black", linewidth = 0.5) +
#     coord_polar(theta = "y", start = 0) +

#     geom_text(aes(label = per_str), position = position_stack(vjust = 0.5)) +
#     theme(axis.text = element_blank(), axis.ticks = element_blank(),legend.position = "none") +
#     theme_void()
# print(g.pre_res)

