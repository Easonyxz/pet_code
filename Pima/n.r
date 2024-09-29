# ggsave("high_dpi_image.png", plot = g4, dpi = 500)
# conda create -n pet r-base=4.4.1 python=3.12
# conda activate pet
# conda install r-base=4.4.1
# conda install conda-forge::r-table1
# conda install r-ggplot2
# conda install r-httpuv
# conda install conda-forge::r-dplyr
# conda install conda-forge::r-tidyr
# conda install conda-forge::r-tidyverse
# conda install conda-forge::r-Seurat
# conda install conda-forge::r-pheatmap
# conda install conda-forge::r-GGally
# conda install conda-forge::r-class
# conda install conda-forge::r-pROC
# conda install conda-forge::r-caret
# conda install conda-forge::r-corrplot

## 上机实践代码
library(MASS) # 加载MASS软件包
data(Pima.tr) # 加载Pima.tr数据集
Pima <- rbind(Pima.tr, Pima.te) # 合并数据集
# 抽取数据举例
Pima_n <- Pima[Pima$type == "No" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,非糖尿病患者的数据
# 直方图举例
hist(Pima_n$bp, main = "Histogram of diastolic \n blood pressure", xlab = "Blood pressure (mm Hg)") # 画出Pima_n中血压的直方图
# 折线图举例
Pima_y <- Pima[Pima$type == "Yes", ] # 抽取糖尿病患者的数据
medglu <- tapply(Pima_y$glu, Pima_y$age, median) # 计算每个年龄血糖的中位数
plot(medglu, xlab = "Age", ylab = "Median glu", type = "o") # 画出年龄与血糖的折线图
title("Median plasma glucose concentration \n at different ages")
# 饼图举例
xx <- Pima_y$npreg # 抽取怀孕次数的数据
t <- table(xx) # 计算频数
data <- as.data.frame(t) # 将频数表转换成数据框
colnames(data) <- c("npreg", "Freq") # 修改数据框的列名
percentage <- round(data$Freq / sum(data$Freq), 2) * 100 # 计算百分比
percentage <- paste0(percentage, "%") # 添加百分号
lb <- paste0(names(t), ": ", percentage) # 添加标签
pie(data$Freq, labels = lb) # 画出饼图
title("Piechart of numbers of pregnancies") # 添加标题
# 柱形图举例
barplot(rbind(Pima_n$bmi, Pima_n$skin), col = c("orange", "brown"))
legend("topleft", c("BMI", "skin"), cex = 0.6, fill = c("orange", "brown"))
title("BMI and skin thickness")
# 箱式图举例
Pima_y <- Pima[Pima$type == "Yes" & Pima$age == 22, ] # 抽取Pima数据集中年龄=22岁,糖尿病患者的数据
boxplot(Pima_y$glu, Pima_n$glu, names = c("Diabetes", "Non-diabetes"), ylab = "glu", col = c("red", "blue")) # 画出箱式图，比较糖尿病患者和非糖尿病患者的血糖浓度
title("Plasma glucose concentration")
