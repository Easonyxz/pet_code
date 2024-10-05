draw_roc <- function(roc.list, title = "ROC CURVE", save_img = FALSE) {
    # 加上auc值
    names(roc.list) <- lapply(seq_along(roc.list), function(i) {
        paste(names(roc.list)[i], "( AUC = ", round(roc.list[[i]]$auc, 3), ")")
    })
    # 定义可用的线条类型
    linetypes <- c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash")
    # 根据 roc.list 的长度动态生成线条类型
    dynamic_linetypes <- rep(linetypes, length.out = length(roc.list))


    g.roc <- ggroc(roc.list, aes = c("linetype", "color"), legacy.axes = TRUE, size = 1.2) +
        theme_classic() + ggtitle(title) +
        annotate("segment", x = 0, y = 0, xend = 1, yend = 1, linetype = "dashed", color = "#186F65") +
        theme(
            plot.title = element_text(hjust = 0.5, size = 20),
            axis.text.x = element_text(size = 12),
            axis.text.y = element_text(size = 12),
            axis.title.x = element_text(size = 14),
            axis.title.y = element_text(size = 14),
            legend.position = c(.75, .2), legend.title = element_blank(), legend.text = element_text(size = 12),
            legend.key.size = unit(1.5, "lines"), # 调整图例键的间隔
            legend.key.width = unit(0.8, "inch"), # 调整图例键的宽度
        ) +
        scale_linetype_manual(values = dynamic_linetypes)
    print(g.roc)
    if (save_img == TRUE) {
        ggsave(paste0(title, ".png"), width = 8, height = 8, plot = g.roc, dpi = 300)
    }
}
