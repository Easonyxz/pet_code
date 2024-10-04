library(corrplot)
draw_corrplot <- function(data_cor, title = "corrplot", save_img = FALSE) {
    g.cor.data <- cor(data_cor)
    g.cor.mtestdata <- cor.mtest(data_cor, conf.level = 0.95)
    if (save_img == TRUE) {
        p.size.height <-ceiling(ncol(g.cor.data)/2.3) 
        p.size.width <- ceiling(p.size.height * 1.3)+1
        png(paste(title, ".png", sep = ""), units = "in", width = p.size.width, height = p.size.height, res = 200)
    }
    corrplot(
        corr = g.cor.data, p.mat = g.cor.mtestdata$p, pch.col = "red",
        method = "circle", type = "upper", order = "AOE",
        tl.pos = "tp", tl.cex = 1, tl.col = "black", tl.srt = 45, tl.offset = 0.5,
    )
    corrplot(
        corr = g.cor.data, p.mat = g.cor.mtestdata$p, pch.col = "red",
        method = "color", type = "lower", order = "AOE",
        addCoef.col = "#000000", add = TRUE,
        diag = FALSE, tl.pos = "n", cl.pos = "n"
    )
    if (save_img == TRUE) {
        dev.off()
    }
}
