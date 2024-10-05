import pandas as pd


def create_prediction_dataframe(
    model, X_test, y_test, need_save=False, filename="prediction.csv"
):
    y_pred_df = pd.DataFrame()
    y_pred_df["real"] = y_test
    y_pred_df["pred"] = model.predict(X_test)

    df_probabilities = pd.DataFrame(
        model.predict_proba(X_test), columns=["Prob_0", "Prob_1"], index=y_pred_df.index
    )
    # 创建数据框
    df = pd.concat([y_pred_df, df_probabilities], axis=1)

    if need_save:
        df.to_csv(filename, index=False)
    return df
