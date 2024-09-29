draw_confusion_matrix <- function(con_matrix, title = "CONFUSION MATRIX") {
  layout(matrix(c(1, 1, 2)))
  par(mar = c(2, 2, 2, 2))
  plot(c(100, 345), c(300, 450), type = "n", xlab = "", ylab = "", xaxt = "n", yaxt = "n")
  title(title, cex.main = 2)


  res <- con_matrix$table
  col_names <- colnames(res)
  row_names <- rownames(res)

  # create the matrix
  rect(150, 430, 240, 370, col = "#3F97D0")
  text(195, 435, col_names[1], cex = 1.2)
  rect(250, 430, 340, 370, col = "#F7AD50")
  text(295, 435, col_names[2], cex = 1.2)
  text(125, 370, "Predicted", cex = 1.3, srt = 90, font = 2)
  text(245, 450, "Actual", cex = 1.3, font = 2)
  rect(150, 305, 240, 365, col = "#F7AD50")
  rect(250, 305, 340, 365, col = "#3F97D0")
  text(140, 400, row_names[1], cex = 1.2, srt = 90)
  text(140, 335, row_names[2], cex = 1.2, srt = 90)


  text(195, 400, paste("TP:", res[1]), cex = 1.6, font = 2, col = "white")
  text(195, 335, paste("FP:", res[2]), cex = 1.6, font = 2, col = "white")
  text(295, 400, paste("FN:", res[3]), cex = 1.6, font = 2, col = "white")
  text(295, 335, paste("TN:", res[4]), cex = 1.6, font = 2, col = "white")

  # add in the specifics
  plot(c(100, 0), c(100, 0), type = "n", xlab = "", ylab = "", main = "DETAILS", xaxt = "n", yaxt = "n")
  text(10, 85, names(con_matrix$byClass[1]), cex = 1.2, font = 2)
  text(10, 70, round(as.numeric(con_matrix$byClass[1]), 3), cex = 1.2)
  text(30, 85, names(con_matrix$byClass[2]), cex = 1.2, font = 2)
  text(30, 70, round(as.numeric(con_matrix$byClass[2]), 3), cex = 1.2)
  text(50, 85, names(con_matrix$byClass[5]), cex = 1.2, font = 2)
  text(50, 70, round(as.numeric(con_matrix$byClass[5]), 3), cex = 1.2)
  text(70, 85, names(con_matrix$byClass[6]), cex = 1.2, font = 2)
  text(70, 70, round(as.numeric(con_matrix$byClass[6]), 3), cex = 1.2)
  text(90, 85, names(con_matrix$byClass[7]), cex = 1.2, font = 2)
  text(90, 70, round(as.numeric(con_matrix$byClass[7]), 3), cex = 1.2)

  # add in the accuracy information
  text(30, 35, names(con_matrix$overall[1]), cex = 1.5, font = 2)
  text(30, 20, round(as.numeric(con_matrix$overall[1]), 3), cex = 1.4)
  text(70, 35, names(con_matrix$overall[2]), cex = 1.5, font = 2)
  text(70, 20, round(as.numeric(con_matrix$overall[2]), 3), cex = 1.4)
}
