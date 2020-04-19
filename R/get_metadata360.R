#' Get TC/Govdata360 metadata from API
#'
#' Downloads the requested metadata by using the TCdata360 API at \url{https://tcdata360.worldbank.org/docs}
#' or Govdata360 API at \url{https://govdata360.worldbank.org/docs}.
#' The function generates a wide dataframe.
#'
#' Hint: Want to get other data? Helpful functions include:
#' \itemize{
#'   \item See \code{\link{search_360}} to get search TC/Govdata360 indicators, countries, categories, and dataset lists.
#'   \item See \code{\link{get_data360}} to get actual indicator/dataset/country-level data.
#'   \item See \code{\link{get_resources360}} to get additional resource information.
#' }
#'
#' @param site string pertaining to the data360 site to download data from.
#'     Possible choices: 'tc' for TCdata360, 'gov' for Govdata360
#' @param metadata_type string pertaining to the metadata to be downloaded.
#'     Possible choices: 'countries' == Lists metadata for all countries and regions.
#'     'indicators' == Lists metadata for all indicators. Does not return actual data.
#'     'datasets' == Lists metadata for all datasets.
#' @export
#' @return Data frame (wide) containing requested metadata
#' @examples
#' ##examples that take > 5 sec to run are not run for examples using "dontrun"
#' #get all indicator metadata in Govdata360
#' \dontrun{df_indicators <- get_metadata360(site="gov", metadata_type = "indicators")}
#'
#' #get all country metadata in TCdata360
#' df_countries <- get_metadata360(metadata_type = 'countries')
#'
#' #get all dataset metadata in TCdata360
#' \dontrun{df_datasets <- get_metadata360(metadata_type = 'datasets')}

get_metadata360 <- function(site = "tc", metadata_type = "countries") {
    # determine API base based on site parameter
    if (site == "tc") {
        api_base <- "http://tcdata360-backend.worldbank.org/api/v1/"
    } else if (site == "gov") {
        api_base <- "http://govdata360-backend.worldbank.org/api/v1/"
    } else {
        # catch errors
        stop("site parameter should only be either 'tc' or 'gov'. Please try again.")
    }

    metadata_types <- c("countries", "indicators", "datasets")

    if (!is.null(metadata_type) && (length(metadata_type) == sum(metadata_type %in% metadata_types))) {
        dl_url <- paste(api_base, metadata_type, "/", sep = "")
        df <- jsonlite::fromJSON(dl_url)
        return(df)
    } else {
        stop("metadata_type parameter should only be one or a combination of \"countries\", \"indicators\", \"datasets\".")
    }

}
