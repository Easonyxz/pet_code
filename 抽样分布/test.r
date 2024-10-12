# 设置样本量和标准差
sample_size <- 25
num_samples <- 10000
means <- 155.4
sds <- c(1, 5, 10, 15, 20, 25, 30)

# 初始化结果数据框
results <- data.frame(
  SD = sds,
  Sample_Mean = numeric(length(sds)),
  Sample_SD = numeric(length(sds))
)

# 进行抽样并计算统计量
for (i in 1:length(sds)) {
  samples <- replicate(num_samples, mean(rnorm(sample_size, means, sds[i])))
  results$Sample_Mean[i] <-round(mean(samples),3) 
  results$Sample_SD[i] <-round(sd(samples),3) 
}

# 显示统计结果
print(results)
