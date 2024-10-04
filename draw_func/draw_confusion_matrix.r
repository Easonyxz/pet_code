draw_confusion_matrix <- function(con_matrix, title = "CONFUSION MATRIX", col_pos = "#3F97D0", col_neg = "#F7AD50", save_img = FALSE) {
  if (save_img == TRUE) {
    png(paste(title, ".png", sep = ""), units = "in", width = 6, height = 8, res = 300)
  }
  layout(matrix(c(1, 1, 2)))
  par(mar = c(2, 2, 2, 2))
  plot(c(100, 345), c(300, 450), type = "n", xlab = "", ylab = "", xaxt = "n", yaxt = "n")
  title(title, cex.main = 2)

  res <- con_matrix$table
  col_names <- colnames(res)
  row_names <- rownames(res)

  # xy label
  text(125, 370, "Predicted", cex = 1.3, srt = 90, font = 2)
  text(140, 400, row_names[1], cex = 1.2, srt = 90)
  text(140, 335, row_names[2], cex = 1.2, srt = 90)
  text(245, 450, "Actual", cex = 1.3, font = 2)
  text(195, 435, col_names[1], cex = 1.2)
  text(295, 435, col_names[2], cex = 1.2)

  rect(150, 430, 240, 370, col = col_pos)
  text(195, 400, paste("TP:", res[1]), cex = 1.6, font = 2, col = "white")

  rect(250, 430, 340, 370, col = col_neg)
  text(295, 400, paste("FN:", res[3]), cex = 1.6, font = 2, col = "white")

  rect(150, 305, 240, 365, col = col_neg)
  text(195, 335, paste("FP:", res[2]), cex = 1.6, font = 2, col = "white")

  rect(250, 305, 340, 365, col = col_pos)
  text(295, 335, paste("TN:", res[4]), cex = 1.6, font = 2, col = "white")


  # DETAILS
  plot(c(100, 0), c(100, 0), type = "n", xlab = "", ylab = "", main = "DETAILS", xaxt = "n", yaxt = "n")

  #   [1] "Sensitivity"          "Specificity"          "Pos Pred Value"
  #  [4] "Neg Pred Value"       "Precision"            "Recall"
  #  [7] "F1"                   "Prevalence"           "Detection Rate"
  class_names <- names(con_matrix$byClass)
  class_values <- as.numeric(con_matrix$byClass)
  # print(class_names)
  # print(class_values)

  class_show <- c(1, 2, 5, 6, 7, 8)
  class_length <- length(class_show)
  class_gap <- ceiling(100 / class_length)
  for (i in 1:class_length) {
    j <- class_show[i]
    text(-10 + class_gap * i, 85, labels = class_names[j], cex = 1.4, font = 2)
    text(-10 + class_gap * i, 70, labels = round(class_values[j], 3), cex = 1.4, font = 1)
  }

  #   [1] "Accuracy"       "Kappa"          "AccuracyLower"  "AccuracyUpper"
  # [5] "AccuracyNull"   "AccuracyPValue" "McnemarPValue"
  overall_names <- names(con_matrix$overall)
  overall_values <- as.numeric(con_matrix$overall)
  #   print(overall_names)
  #   print(overall_values)


  overall_show <- c(1, 2)
  for (i in overall_show) {
    text(-10 + 40 * i, 45, labels = overall_names[i], cex = 1.8, font = 4)
    text(-10 + 40 * i, 30, labels = round(overall_values[i], 3), cex = 1.5, font = 1)
  }
  # "Accuracy  95% CI 95%置信区间"
  acc_ci <- paste("95% CI:", "(", round(overall_values[3], 3), ",", round(overall_values[4], 3), ")")
  text(30, 13, labels = acc_ci, cex = 1.2, font = 3)
  if (save_img == TRUE) {
    dev.off()
  }
}
