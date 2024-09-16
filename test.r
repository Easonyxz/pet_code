# conda create -n pet r-base=4.4.1 python=3.12
# conda activate pet
# conda install r-ggplot2
# conda install r-httpuv
# conda install conda-forge::r-dplyr
# conda install conda-forge::r-tidyr

# h <- c(1, 2, 3, 4, 5, 6)
# M <- c("A", "B", "C", "D", "E", "F")
# barplot(h,
#     names.arg = M, xlab = "X", ylab = "Y",
#     col = "#d7f5f5", main = "Chart", border = "#252424"
# )

add <- function(x, y) {
    return(x + y)
}

print("还好")
library("ggplot2") # 数据可视化
library("dplyr") # 数据处理
library(scales) # 数据处理
library(MASS) # 加载MASS软件包
data(Pima.tr) # 加载Pima.tr数据集
Pima <- rbind(Pima.tr, Pima.te) # 合并数据集
Pima_n <- Pima[Pima$type == "No" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,非糖尿病患者的数据


barplot_data <- cbind(Pima_n$bmi, Pima_n$skin)
colnames(barplot_data) <- c("bmi", "skin")
# print(barplot_data)
lm_eqn <- function(df) {
    m <- lm(y ~ x, df)
    eq <- substitute(
        italic(y) == a + b %.% italic(x),
        list(
            a = format(unname(coef(m)[1]), digits = 2),
            b = format(unname(coef(m)[2]), digits = 2)
        )
    )
    as.character(as.expression(eq))
}
lm_data <- as.data.frame(barplot_data)
colnames(lm_data) <- c("x", "y")

g1 <- ggplot(barplot_data, aes(bmi, skin)) +
    geom_point(aes(colour = factor(skin))) +
    geom_text(x = 25, y = 45, label = lm_eqn(lm_data), parse = TRUE, size = 6, colour = "#272222") +
    geom_smooth(method = "lm", formula = y ~ x) +
    labs(
        x = "bmi", y = "皮肤厚度",
        title = "BMI和皮肤厚度",
        subtitle = "年龄22岁,非糖尿病患者的数据",
    ) +
    theme(
        legend.position = "none",
        plot.title = element_text(
            face = "bold.italic", color = "orange", size = 24, hjust = 0.5, vjust = 0.5
        )
    )
print(g1)
ggsave("BMI和皮肤厚度.png", plot = g1, dpi = 500)


# lm_eqn <- function(df) {
#     m <- lm(y ~ x, df)
#     eq <- substitute(
#         italic(y) == a + b %.% italic(x) ,
#         list(
#             a = format(unname(coef(m)[1]), digits = 2),
#             b = format(unname(coef(m)[2]), digits = 2)

#         )
#     )
#     as.character(as.expression(eq))
# }
# set.seed(1234)
# df <- data.frame(x = c(1:100))
# df$y <- 2 + 3 * df$x + rnorm(100, sd = 40)
# p <- ggplot(data = df, aes(x = x, y = y)) +
#     geom_smooth(method = "lm", se = FALSE, color = "black", formula = y ~ x) +
#     geom_text(x = 25, y = 300, label = lm_eqn(df), parse = TRUE) +
#     geom_point()


# print(p)
