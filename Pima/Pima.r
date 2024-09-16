library(MASS)
library(ggplot2)
library(dplyr)
library(scales)
data(Pima.tr) # 加载Pima.tr数据集
Pima <- rbind(Pima.tr, Pima.te) # 合并数据集
# 抽取数据举例
Pima_n <- Pima[Pima$type == "No" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,非糖尿病患者的数据
## 柱形图举例
# barplot(rbind(Pima_n$bmi, Pima_n$skin), col = c("orange", "brown"))
# legend("topleft", c("BMI", "skin"), cex = 0.6, fill = c("orange", "brown"))
# title("BMI and skin thickness")


barplot_data <- cbind(Pima_n$bmi, Pima_n$skin)
colnames(barplot_data) <- c("bmi", "skin")
# 线性回归方程
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




# 直方图举例
# hist(Pima_n$bp, main = "Histogram of diastolic \n blood pressure", xlab = "Blood pressure (mm Hg)") # 画出Pima_n中血压的直方图

g2 <- ggplot(Pima_n, aes(bp)) +
    geom_histogram(fill = "red", color = "black", alpha = 0.3, binwidth = 2) +
    labs(
        x = "血压 (mm Hg)", y = "Frequency",
        title = "舒张压直方图",
        subtitle = "年龄22岁,非糖尿病患者的数据"
    ) +
    theme(
        plot.title = element_text(
            face = "bold.italic", color = "#c33349", size = 24, hjust = 0.5, vjust = 0.5
        )
    ) +
    scale_x_continuous(breaks = seq(min(Pima_n$bp), max(Pima_n$bp), by = 5))


# # 折线图举例
# Pima_y = Pima[Pima$type == "Yes", ] # 抽取糖尿病患者的数据
# medglu = tapply(Pima_y$glu, Pima_y$age, median) # 计算每个年龄血糖的中位数
# plot(medglu, xlab = "Age", ylab = "Median glu", type = "o") # 画出年龄与血糖的折线图
# title("Median plasma glucose concentration \n at different ages ")

# 不同年龄的血糖浓度(中位数)数据处理
diabetes_data <- Pima[Pima$type == "Yes", ]
line_data <- stack(tapply(diabetes_data$glu, diabetes_data$age, median))
colnames(line_data) <- c("glu_median", "age_median")
# 绘制折线图
g3 <- ggplot(line_data, aes(
    x = age_median, y = glu_median, group = 1
)) +
    geom_line(linetype = "dashed", color = "#ea852d", linewidth = 1) +
    geom_point() +
    labs(
        x = "年龄", y = "血糖浓度",
        title = "不同年龄的糖尿病患者血糖浓度(中位数)",
    ) +
    theme(
        plot.title = element_text(
            face = "bold.italic", color = "#ea852d", size = 24, hjust = 0.5, vjust = 0.5
        )
    )


# # 饼图举例
# xx = Pima_y$npreg # 抽取怀孕次数的数据
# t = table(xx) # 计算频数
# data = as.data.frame(t) # 将频数表转换成数据框
# colnames(data) = c("npreg", "Freq") # 修改数据框的列名
# percentage = round(data$Freq / sum(data$Freq), 2) * 100 # 计算百分比
# percentage = paste0(percentage, "%") # 添加百分号
# lb = paste0(names(t), ": ", percentage) # 添加标签
# pie(data$Freq, labels = lb) # 画出饼图
# title("Piechart of numbers of pregnancies") # 添加标题

# 怀孕次数占比 数据处理
# preg_data <- as.data.frame(table(Pima$npreg))
# colnames(preg_data) <- c("preg_num", "freq")
# preg_data$percentage <- round(preg_data$freq / sum(preg_data$freq), 3)
# preg_data$per_str <- paste(preg_data$preg_num, "次", "(", preg_data$percentage * 100, "%)", sep = "")
# 另外一种写法
preg_data <- Pima %>%
    count(npreg) %>%
    mutate(
        percentage = round(n / sum(n), 3),
        per_str = paste(npreg, "次", "(", percent(percentage), ")", sep = "")
    ) %>%
    rename(freq = n, preg_num = npreg)
preg_data$preg_num <- factor(preg_data$preg_num)

# 绘制饼图
g4 <- ggplot(preg_data, aes(
    x = "", y = freq, fill = preg_num
)) +
    geom_bar(stat = "identity", position = "stack", color = "black", linewidth = 0.5) +
    coord_polar(theta = "y", start = 0) +
    labs(
        x = "", y = "", title = "怀孕次数占比", fill = "怀孕次数"
    ) +
    geom_text(aes(label = preg_num), position = position_stack(vjust = 0.5)) +
    scale_fill_discrete(labels = preg_data$per_str) +
    theme(axis.text = element_blank(), axis.ticks = element_blank()) +
    theme_void()

# # 箱式图举例
# Pima_y <- Pima[Pima$type == "Yes" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,糖尿病患者的数据
# boxplot(Pima_y$glu, Pima_n$glu, names = c("Diabetes", "Non-diabetes"), ylab = "glu", col = c("red", "blue")) # 画出箱式图，比较糖尿病患者和非糖尿病患者的血糖浓度
# title("Plasma glucose concentration")血浆葡萄糖浓度

box_data <- Pima[Pima$age == 22, ]
g5 <- ggplot(box_data, aes(x = type, y = glu)) +
    geom_boxplot(aes(fill = type)) +
    stat_boxplot(geom = "errorbar", width = 0.1, size = 0.8) +
    stat_summary(fun = mean, geom = "point", size = 3, color = "blue") +
    theme(legend.position = c(0.85, 0.2)) +
    labs(
        x = "", y = "血糖浓度",
        title = "糖尿病患者和非糖尿病患者的血糖浓度对比",
        subtitle = "年龄22岁"
    ) +
    theme(
        plot.title = element_text(
            face = "bold.italic", color = "#c33349", size = 24, hjust = 0.5, vjust = 0.5
        )
    ) +
    scale_fill_discrete(labels = c("非糖尿病患者", "糖尿病患者"), name = "类型") +
    scale_x_discrete(labels = c("非糖尿病患者", "糖尿病患者"))
