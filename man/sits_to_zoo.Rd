% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sits_zoo.R
\name{sits_to_zoo}
\alias{sits_to_zoo}
\title{Export data to be used to the zoo format}
\usage{
sits_to_zoo(data, band = NULL)
}
\arguments{
\item{data}{A sits tibble with time series.}

\item{band}{Band to be exported (if NULL all bands are exported).}
}
\value{
List of time series in zoo format.
}
\description{
Converts data from a sits tibble to a list of a zoo series.
}
\examples{
# read a tibble with 400 samples of Cerrado and 346 samples of Pasture
data(cerrado_2classes)
# export a time series to zoo
zoo.lst <- sits_to_zoo(cerrado_2classes[1:5, ])

}
\author{
Gilberto Camara, \email{gilberto.camara@inpe.br}
}
