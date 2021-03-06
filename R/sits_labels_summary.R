#' @title Returns the information about labels of a tibble data set
#'
#' @name sits_labels_summary
#'
#' @author Rolf Simoes, \email{rolf.simoes@@inpe.br}
#'
#' @description  Finds labels in a sits tibble
#'
#' @param data      Valid sits tibble
#'
#' @return A tibble with labels frequency.
#'
#' @examples
#' # read a tibble with 400 samples of Cerrado and 346 samples of Pasture
#' data(cerrado_2classes)
#' # print the labels
#' sits_labels_summary(cerrado_2classes)
#'
#' @export
#'
sits_labels_summary <- function(data) {

    UseMethod("sits_labels_summary", data)
}

#' @export
#'
sits_labels_summary.sits <- function(data) {

    # get frequency table
    data_labels <- table(data$label)

    # compose tibble containing labels, count and relative frequency columns
    result <- tibble::as_tibble(list(
        label = names(data_labels),
        count = as.integer(data_labels),
        prop = as.numeric(prop.table(data_labels))
    ))
    return(result)
}
