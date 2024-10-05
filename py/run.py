import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix


# 读取数据
df = pd.read_csv("data/breast_cancer_new.csv")
X = df.drop(columns=["diagnosis"])
y = df["diagnosis"]

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=123
)

# 数据标准化
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# 训练逻辑回归模型
log_reg = LogisticRegression()
log_reg.fit(X_train, y_train)


from py_func import create_prediction_dataframe

dp = create_prediction_dataframe(
    log_reg, X_test, y_test, need_save=True, filename="data/123.csv"
)
print(dp.head(5))
