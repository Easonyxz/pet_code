# 创建一个列表
my_list <- list("a", "b", "c", "d")

# 创建一个新的空名称向量
new_names <- character(length(my_list))

# 使用for循环来给列表元素重命名
for(i in seq_along(my_list)) {
  new_names[i] <- paste("new_", my_list[[i]])
}

# 重命名列表
names(my_list) <- new_names

# 查看结果
print(my_list)
