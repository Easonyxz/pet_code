# 创建数据
data <- data.frame(
  category = c("A", "B", "C", "D"),
  count = c(10, 20, 30, 40)
)

# 计算百分比
data$fraction <- data$count / sum(data$count)
data$ymax <- cumsum(data$fraction)
data$ymin <- c(0, head(data$ymax, n = -1))

# 添加一个偏移量来分离某个部分
data$offset <- c(0, 1, 0, 0)  # 将第二部分分离

# 绘制饼图
g=ggplot(data, aes(ymax = ymax, ymin = ymin, xmax = 4 + offset, xmin = 3 + offset, fill = category)) +
  geom_rect() +
  coord_polar(theta = "y") +
  xlim(c(2, 5)) +
  theme_void()
print(g)



# library(MASS) # 加载MASS软件包
# library(ggplot2) # 加载ggplot2软件包
# data(Pima.tr) # 加载Pima.tr数据集
# Pima <- rbind(Pima.tr, Pima.te) # 合并数据集
# # 抽取数据举例
# Pima_n <- Pima[Pima$type == "No" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,非糖尿病患者的数据
# # 柱形图举例

# barplot(rbind(Pima_n$bmi, Pima_n$skin), col = c("orange", "brown"))
# legend("topleft", c("BMI", "skin"), cex = 0.6, fill = c("orange", "brown"))
# title("BMI and skin thickness")

# pima_data <- Pima[Pima$type == "Yes" & Pima$age == 22, ]

# g1 <- barplot(rbind(Pima_n$bmi, Pima_n$skin), col = c("orange", "brown"))
# legend("topleft", c("BMI", "skin"), cex = 0.6, fill = c("orange", "brown"))
# title("BMI and skin thickness")

# g2 <- ggplot(pima_data, aes(bp)) +
#     geom_histogram(fill = "red", color = "black", alpha = 0.3)

# line_data=Pima[Pima$type == "Yes",]
# g3 <- ggplot(line_data, aes(x=age, y=glu)) +
#     geom_line()




# preg_data <- as.data.frame(table(Pima$npreg))
# colnames(preg_data) <- c("preg_num", "freq")
# preg_data$percentage <- round(preg_data$freq / sum(preg_data$freq), 3)
# preg_data$per_str <- paste(preg_data$preg_num, "次", "(", preg_data$percentage * 100, "%)", sep = "")

# preg_data$ymax <- cumsum(preg_data$percentage)
# preg_data$ymin <- c(0, head(preg_data$ymax, n = -1))

# for (i in 1:nrow(preg_data)) {
#     preg_data$offset[i] <- ifelse(preg_data$percentage[i] < 0.02, 0.5, 0)
# }


# print(preg_data)
# g4 <- ggplot(preg_data, aes(
#     x = "", y = freq,fill = preg_num
# )) +
#     geom_bar(stat = "identity", position = "stack", color = "black", linewidth = 0.5) +
#     coord_polar(theta = "y", start = 0) +
#     labs(x = "", y = "", title = "怀孕次数占比", fill = "怀孕次数") +
#     geom_text(aes(label = preg_num), position = position_stack(vjust = 0.5)) +
#     scale_fill_discrete(labels = preg_data$per_str) +
#     theme(axis.text = element_blank(), axis.ticks = element_blank()) +
#     theme_void()

# print(g4)
# ggsave("high_dpi_image.png", plot = g4, dpi = 500)



# 直方图举例
# hist(Pima_n$bp, main = "Histogram of diastolic \n blood pressure", xlab = "Blood pressure (mm Hg)") # 画出Pima_n中血压的直方图

# # 折线图举例
# Pima_y = Pima[Pima$type == "Yes", ] # 抽取糖尿病患者的数据
# medglu = tapply(Pima_y$glu, Pima_y$age, median) # 计算每个年龄血糖的中位数
# plot(medglu, xlab = "Age", ylab = "Median glu", type = "o") # 画出年龄与血糖的折线图
# title("Median plasma glucose concentration \n at different ages")

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

# # 箱式图举例
# Pima_y = Pima[Pima$type == "Yes" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,糖尿病患者的数据
# boxplot(Pima_y$glu, Pima_n$glu, names = c("Diabetes", "Non-diabetes"), ylab = "glu", col = c("red", "blue")) # 画出箱式图，比较糖尿病患者和非糖尿病患者的血糖浓度
# title("Plasma glucose concentration")
