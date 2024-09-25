g.cancer_mean <- ggpairs(data_file[, c(3:11, 1)], aes(color = diagnosis, alpha = 0.75), lower = list(continuous = "smooth")) + theme_bw() +
    labs(title = "Cancer Mean") +
    theme(plot.title = element_text(face = "bold", color = "black", hjust = 0.5, size = 12))
ggsave("img/g.cancer_mean.png", plot = g.cancer_mean, dpi = 300)
