% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sits_bbox.R
\name{sits_bbox}
\alias{sits_bbox}
\title{Get the bounding box of the data}
\usage{
sits_bbox(data, wgs84 = FALSE, ...)
}
\arguments{
\item{data}{Valid sits tibble (time series or a cube).}

\item{wgs84}{Take effect only for data cubes.
Reproject bbox to WGS84 (EPSG:4326).}

\item{...}{Additional parameters (not implemented).}
}
\value{
named vector with bounding box in WGS84 for time series and
        on the cube projection for a data cube unless wgs84 parameter
        is TRUE.
}
\description{
Obtain a vector of limits (either on lat/long for time series
              or in projection coordinates in the case of cubes)
}
\author{
Gilberto Camara, \email{gilberto.camara@inpe.br}

Rolf Simoes, \email{rolf.simoes@inpe.br}
}
