library(shinyMatrix)

function(input, output, session) {
  output$table <- renderTable(input$matrix, rownames = TRUE)

  observeEvent(input$button, {
    nrow <- sample(1:10, 1)
    ncol <- sample(1:10, 1)

    m <- matrix(round(rnorm(nrow * ncol), 2), nrow, ncol)

    m[1, 1] <- NA

    colnames(m) <- sample(letters, ncol)
    rownames(m) <- paste(sample(LETTERS, nrow), 1:nrow)

    updateMatrixInput(session, "matrix", m)
  })
}