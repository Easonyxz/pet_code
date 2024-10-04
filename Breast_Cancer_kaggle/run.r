
temp_res <- cancer_diagnosis_predict(pre_data, svmRadial)


pre_res <- data.frame(id = patient$id)
pre_res <- pre_res %>%
    mutate(
        predict_diagnosis = temp_res,
        orgin_diagnosis = patient$diagnosis,
        correct = ifelse(predict_diagnosis == orgin_diagnosis, "True", "False")
    )
print(head(pre_res))
print(prop.table(table(pre_res$correct)))

# write.csv(pre_res, "Breast_Cancer_kaggle/pre_res.csv")

print("Complete predict ")
