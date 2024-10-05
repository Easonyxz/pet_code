start_time <- Sys.time()
print("123")

library(pROC)
library(ggplot2)


roc.list <- roc(outcome ~ s100b + ndka + wfns, data = aSAH)

names(roc.list) <- lapply(seq_along(roc.list), function(i) {
    paste(names(roc.list)[i], "(AUC = ", round(roc.list[[i]]$auc, 3), ")")
})




g <- ggroc(roc.list, aes = c("linetype", "color"), legacy.axes = TRUE, size = 1.2) +
    theme_classic() + ggtitle("The new title") +
    annotate("segment", x = 0, y = 0, xend = 1, yend = 1, linetype = "dashed", color = "#186F65") +
    theme(
        legend.position = c(.8, .15), legend.title = element_blank(), legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 20),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
    )

print(g)
 ggsave(paste0("title", ".png"), plot = g, dpi = 300)

print("123")
end_time <- Sys.time()
print(end_time - start_time)
