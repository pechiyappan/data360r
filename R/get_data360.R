#' Get TC/Govdata360 data from API
#'
#' Downloads the requested data by using the TCdata360 API at \url{tcdata360.worldbank.org/docs}
#' or Govdata360 API at \url{govdata360.worldbank.org/docs}.
#' The function generates a data frame (wide or long, depending on user input).
#'
#' Hint: Don't know what codes to write as inputs for this function? Helpful functions include:
#' \itemize{
#'   \item See \code{\link{search_360}} to get search TC/Govdata360 indicators, countries, categories, and dataset lists.
#'   \item See \code{\link{get_metadata360}} to get indicator/dataset/country-level metadata.
#'   \item See \code{\link{get_resources360}} to get additional resource information.
#' }
#'
#' @param site string pertaining to the data360 site to download data from.
#'     Possible choices: 'tc' for TCdata360, 'gov' for Govdata360
#' @param indicator_id NULL (optional); Vector of indicators codes.
#'     Should be left NULL if \code{dataset_id} is not NULL.
#' @param dataset_id NULL (optional); Character vector of Dataset IDs for all indicator data is to be downloaded.
#'     Should be left NULL if \code{indicator_id} is not NULL.
#' @param country_iso3 defaults to c('USA', 'PNG', 'PHL') (optional); Vector of countries (ISO-3 3-letter character codes,
#'      e.g. 'PNG', 'USA', 'PHL') for which the data is needed.
#'     Leaving this NULL pulls data for every available country.
#' @param timeframes NULL (optional); Vector of years to restrict results data to.
#'      Leaving this NULL gets all available timeframes.
#'      Important note: \code{timeframes} parameter cannot be non-NULL while the other parameters are NULL, since data request is too large.
#' @param output_type string pertaining to the output type. Possible choices include:
#'      'wide' == one row contains multi-year observations
#'      'long' == one row refers to one year only.
#' @export
#' @return Data frame containing requested data
#' @examples
#' #get data for dataset ID 51 in TCdata360
#' #df <- get_data360(dataset_id = 51)
#'
#' #get data for countries USA, PHL in Govdata360
#' #df2 <- get_data360(site = 'gov', country_iso3 = c('USA', 'PHL'))
#'
#' #get data for indicator IDs 944, 972 in TCdata360
#' df3 <- get_data360(indicator_id = c(944, 972))
#'
#' #get data for indicator IDs 944, 972 in 2011-2013 in long format in TCdata360
#' #df4 <- get_data360(indicator_id = c(944, 972), timeframes = c(2011, 2012), output_type = 'long')

get_data360 <- function(site = "tc", indicator_id = NULL, dataset_id = NULL, country_iso3 = NULL, timeframes = NULL, output_type = "wide") {

    nondate_cols <- c("Country ISO3", "Country Name", "Dataset", "dataset_id", "Indicator", "Subindicator Type", "Product", "Partner")
    # determine API base based on site parameter
    if (site == "tc") {
        api_base <- "http://tcdata360-backend.worldbank.org/api/v1/"
    } else if (site == "gov") {
        api_base <- "http://govdata360-backend.worldbank.org/api/v1/"
    } else {
        # catch errors
        stop("site parameter should only be either 'tc' or 'gov'. Please try again.")
    }
    if (!(output_type %in% c("wide", "long"))) {
        stop("output_type parameter should only be either 'wide' or 'long'. Please try again.")
    }

    # check validity of inputs
    if ((is.null(indicator_id) == FALSE) && (is.null(dataset_id) == FALSE)) {
        stop("indicator_id and dataset_id parameters cannot be both non-NULL.
         Hint: If you want to download a certain indicator(s) only, list these down in indicator_id as a vector,
         and use dataset_id == NULL.")
    } else if (((is.null(indicator_id) == TRUE) && (is.null(dataset_id) == TRUE) && (is.null(country_iso3) == TRUE) && (is.null(timeframes) == FALSE))) {
        stop("timeframes parameter cannot be non-NULL while the other parameters are NULL, since data request is too large.
         Hint: Add inputs to the other parameters to constrain the data request.")
    }

    # determine best endpoint to use based on user inputs (/data vs /datasets/{id}/dump.csv vs /countries/{id}/dump.csv)
    if (is.null(indicator_id) && is.null(timeframes)) {

        # OPTION 1: generating data via CSV data dumps (preferred since faster download)
        if (is.null(dataset_id) && is.null(country_iso3)) {
            stop("the site parameters indicator_id, dataset_id, country_iso3, and timeframes cannot all be NULL.")
        } else if ((is.null(dataset_id) != is.null(country_iso3))) {
            if (!is.null(dataset_id) && is.null(country_iso3)) {
                api_endpoint <- "datasets/"
                query <- "/dump.csv"
                item_list <- dataset_id
                item_name <- "dataset_id"

            } else if (is.null(dataset_id) && !is.null(country_iso3)) {
                api_endpoint <- "countries/"
                query <- "/dump.csv"
                qtype <- "countrydump"
                item_list <- country_iso3
                item_name <- "Country ISO3"
            }

            df_compiled <- data.table::data.table()

            for (item in item_list) {
                dl_url <- paste(api_base, api_endpoint, item, query, sep = "")
                df <- data.table::fread(dl_url, header = TRUE, showProgress = FALSE)
                df <- cbind(df, placeholder_name = item)
                names(df)[names(df) == "placeholder_name"] <- item_name
                df_compiled <- data.table::rbindlist(list(df_compiled, df), fill = TRUE)
            }
        }
        # OPTION 2: Generating data via customized query
    } else {
        api_endpoint <- "data.csv?"
        if (!is.null(indicator_id)) {
            indicators <- paste(c("indicators=", indicator_id), collapse = "%2C")
        } else {
            indicators <- ""
        }
        if (!is.null(country_iso3)) {
            countries <- paste(c("countries=", country_iso3), collapse = "%2C")
        } else {
            countries <- ""
        }
        if (!is.null(timeframes)) {
            timefram <- paste(c("timeframes=", timeframes), collapse = "%2C")
        } else {
            timefram <- ""
        }
        query <- paste(c(countries, indicators, timefram), collapse = "&")
        dl_url <- paste(api_base, api_endpoint, query, sep = "")
        df_compiled <- data.table::fread(dl_url, header = TRUE, showProgress = FALSE)
        names(df_compiled)[names(df_compiled) == "Country ID"] <- "Country ISO3"
        names(df_compiled)[names(df_compiled) == "Value Type"] <- "Subindicator Type"
    }

    if (output_type == "long") {
        df_compiled <- reshape2::melt(df_compiled, id.vars = intersect(nondate_cols, names(df_compiled)), variable.name = "Period", value.name = "Observation")
    }

    return(df_compiled)
}
