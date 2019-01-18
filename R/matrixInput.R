#' Create a matrix input field
#'
#' @param inputId The input slot that will be used to access the value
#' @param inputClass class of the matrix input html element
#' @param value Inital value. Should be a matrix
#' @param class Matrix will be coerced to a matrix of this class. `character` and `numeric`
#' are supported
#' @param rows list of options to configure rows
#' @param cols list of options to configure cols
#' @param paste enable paste functionality
#' @param copy enable copy functionality
#' 
#' @export
matrixInput <- function(inputId,
                        value = matrix("", 1, 1),
                        inputClass = "",
                        rows = list(),
                        cols = list(),
                        class = "character",
                        paste = FALSE,
                        copy = FALSE){
  stopifnot(is.matrix(value))
  tagList(
    singleton(tags$head(tags$script(src = "shinyMatrix/matrixInput.js"))),
    singleton(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "shinyMatrix/matrixInput.css"))),
    tags$div(
      id = inputId,
      class = paste("matrix-input", inputClass),
      "data-data" = jsonlite::toJSON(value),
      "data-rownames" = jsonlite::toJSON(rownames(value)),
      "data-colnames" = jsonlite::toJSON(colnames(value)),
      "data-rows" = jsonlite::toJSON(rows, auto_unbox = TRUE),
      "data-cols" = jsonlite::toJSON(cols, auto_unbox = TRUE),
      "data-class" = class,
      "data-copy" = jsonlite::toJSON(copy, auto_unbox = TRUE),
      "data-paste" = jsonlite::toJSON(paste, auto_unbox = TRUE)
    )
  )
}

#' Update matrix input
#'
#' @param session shiny session
#' @param inputId id of matrix input
#' @param value new value for matrix
#'
#' @export
updateMatrixInput <- function(session, inputId, value) {
  stopifnot(is.matrix(value))

  message <- list(value = list(
    data = value,
    rownames = rownames(value),
    colnames = colnames(value)
  ))
  session$sendInputMessage(inputId, message)
}