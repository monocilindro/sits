
#' @keywords internal
#' @export
.sits_raster_api_check_package.terra <- function() {

    # package namespace
    pkg_name <- "terra"

    # check if raster package is available
    if (!requireNamespace(pkg_name, quietly = TRUE)) {

        stop(paste(".sits_config_raster_package: package", pkg_name,
                   "not available. Install the package or change the",
                   "config file."), call. = FALSE)
    }

    class(pkg_name) <- pkg_name

    return(invisible(pkg_name))
}


#' @keywords internal
#' @export
.sits_raster_api_data_type.terra <- function(data_type, ...) {

    return(data_type)
}

#' @keywords internal
#' @export
.sits_raster_api_get_values.terra <- function(r_obj, ...) {

    # read values and close connection
    terra::readStart(x = r_obj)
    res <- terra::readValues(x = r_obj, mat = TRUE, ...)
    terra::readStop(x = r_obj)

    return(res)
}

#' @keywords internal
#' @export
.sits_raster_api_set_values.terra <- function(r_obj, values, ...) {

    terra::values(x = r_obj) <- as.matrix(values)

    return(invisible(r_obj))
}

#' @keywords internal
#' @export
.sits_raster_api_extract.terra <- function(r_obj, xy, ...) {

    terra::extract(x = r_obj, y = xy, fun = NULL, cells = FALSE, ...)
}

#' @keywords internal
#' @export
.sits_raster_api_rast.terra <- function(r_obj, nlayers = 1, ...) {

    suppressWarnings(
        terra::rast(x = r_obj, nlyrs = nlayers, ...)
    )
}

#' @keywords internal
#' @export
.sits_raster_api_open_rast.terra <- function(file, ...) {

    suppressWarnings(
        terra::rast(x = file, ...)
    )
}

#' @keywords internal
#' @export
.sits_raster_api_read_rast.terra <- function(file,
                                             block = NULL, ...) {

    return(.sits_raster_api_read_stack.terra(files = file,
                                             block = block))

}

#' @keywords internal
#' @export
.sits_raster_api_write_rast.terra <- function(r_obj,
                                              file,
                                              format,
                                              data_type,
                                              gdal_options,
                                              overwrite, ...) {

    suppressWarnings(
        terra::writeRaster(
            x         = r_obj,
            filename  = file,
            wopt      = list(filetype = format,
                             datatype = data_type,
                             gdal     = gdal_options),
            overwrite = overwrite, ...
        )
    )

    # was the file written correctly?
    assertthat::assert_that(
        file.exists(file),
        msg = ".sits_raster_api_write_rast: unable to write raster object"
    )

    return(invisible(NULL))
}

#' @keywords internal
#' @export
.sits_raster_api_new_rast.terra <- function(nrows,
                                            ncols,
                                            xmin,
                                            xmax,
                                            ymin,
                                            ymax,
                                            nlayers,
                                            crs, ...) {

    # create a raster object
    suppressWarnings(
        terra::rast(
            nrows = nrows,
            ncols = ncols,
            nlyrs = nlayers,
            xmin  = xmin,
            xmax  = xmax,
            ymin  = ymin,
            ymax  = ymax,
            crs   = crs
        )
    )
}

#' @keywords internal
#' @export
.sits_raster_api_open_stack.terra <- function(files, ...) {

    suppressWarnings(
        terra::rast(files, ...)
    )
}

#' @keywords internal
#' @export
.sits_raster_api_read_stack.terra <- function(files,
                                              block = NULL, ...) {

    # create raster objects
    r_obj <- .sits_raster_api_open_stack.terra(files = files, ...)

    # start read
    if (purrr::is_null(block)) {

        # read values
        terra::readStart(r_obj)
        values <- terra::readValues(x   = r_obj,
                                    mat = TRUE)
        # close file descriptor
        terra::readStop(r_obj)
    } else {

        # read values
        terra::readStart(r_obj)
        values <- terra::readValues(x      = r_obj,
                                    row    = block[["row"]],
                                    nrows  = block[["nrows"]],
                                    col    = block[["col"]],
                                    ncols  = block[["ncols"]],
                                    mat    = TRUE)
        # close file descriptor
        terra::readStop(r_obj)
    }

    return(values)
}

#' @keywords internal
#' @export
.sits_raster_api_crop.terra <- function(r_obj, block, ...) {

    # obtain coordinates from columns and rows
    x1 <- terra::xFromCol(object = r_obj,
                          col    = c(block[["col"]]))
    x2 <- terra::xFromCol(object = r_obj,
                          col    = block[["col"]] + block[["ncols"]] - 1)
    y1 <- terra::yFromRow(object = r_obj,
                          row    = c(block[["row"]]))
    y2 <- terra::yFromRow(object = r_obj,
                          row    = block[["row"]] + block[["nrows"]] - 1)

    # xmin, xmax, ymin, ymax
    extent <- terra::ext(
        x = c(min(x1, x2), max(x1, x2), min(y1, y2), max(y1, y2))
    )

    # crop raster
    suppressWarnings(
        terra::crop(x = r_obj, y = extent, snap = "out")
    )
}

#' @keywords internal
#' @export
.sits_raster_api_nrows.terra <- function(r_obj, ...) {

    terra::nrow(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_ncols.terra <- function(r_obj, ...) {

    terra::ncol(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_nlayers.terra <- function(r_obj, ...) {

    terra::nlyr(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_xmax.terra <- function(r_obj, ...) {

    terra::xmax(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_xmin.terra <- function(r_obj, ...) {

    terra::xmin(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_ymax.terra <- function(r_obj, ...) {

    terra::ymax(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_ymin.terra <- function(r_obj, ...) {

    terra::ymin(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_xres.terra <- function(r_obj, ...) {

    terra::xres(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_yres.terra <- function(r_obj, ...) {

    terra::yres(x = r_obj)
}

#' @keywords internal
#' @export
.sits_raster_api_crs.terra <- function(r_obj, ...) {

    suppressWarnings(
        as.character(terra::crs(x = r_obj))
    )
}

#' @keywords internal
#' @export
.sits_raster_api_freq.terra <- function(r_obj, ...) {

    terra::freq(x = r_obj, bylayer = TRUE)
}

#' @keywords internal
#' @export
.sits_raster_api_focal.terra <- function(r_obj,
                                         window_size,
                                         fn, ...) {

    # check fun parameter
    if (is.character(fn)) {

        if (fn == "modal")
            fn <- terra::modal
    }

    suppressWarnings(
        terra::focal(
            x   = r_obj,
            w   = window_size,
            fun = fn, ...
        )
    )
}
