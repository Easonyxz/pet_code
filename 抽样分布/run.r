random_sampling <- function(dist, n) {
  switch(dist,
    "Normal" = rnorm(n, 5, 2),
    "Exponential" = rexp(n, 1 / 5),
    "Uniform" = runif(n, 1, 9)
  )
}


# # 设置样本量
# sample_sizes <- c(1, 5, 10, 30)

# # 创建一个空列表用于存储样本数据
# samples <- list()

# # 进行随机抽样
# for (n in sample_sizes) {
#   samples[[paste("Normal", n)]] <- replicate(10000, mean(random_sampling("Normal", n)))
#   samples[[paste("Exponential", n)]] <- replicate(10000, mean(random_sampling("Exponential", n)))
#   samples[[paste("Uniform", n)]] <- replicate(10000, mean(random_sampling("Uniform", n)))
# }

# # 设置图形布局
# par(mfrow = c(4, 3))

# # 绘制直方图
# for (sample_name in names(samples)) {
#   hist(samples[[sample_name]], main = sample_name, xlab = "", border = "black", xlim = c(0, 15))
# }

# # 设置样本量
# sample_sizes <- c(1, 5, 10, 30, 50, 100)
# distributions <- c("Normal", "Exponential", "Uniform")


# # 初始化结果数据框
# results_df <- data.frame(Sample_Size = sample_sizes)

# # 进行随机抽样并计算统计量
# for (dist in distributions) {
#   means <- sapply(sample_sizes, function(n) {
#     samples <- replicate(10000, mean(random_sampling(dist, n)))
#     round(mean(samples), 3)
#   })
#   sds <- sapply(sample_sizes, function(n) {
#     samples <- replicate(10000, mean(random_sampling(dist, n)))
#     round(sd(samples), 3)
#   })
  
#   results_df[paste(dist, "Mean", sep = "_")] <- means
#   results_df[paste(dist, "SD", sep = "_")] <- sds
# }

# # 显示统计结果表格
# print(results_df)
# write.csv(results_df, "sampling_distribution_results.csv")

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
write.csv(results, "sampling_r_results.csv")