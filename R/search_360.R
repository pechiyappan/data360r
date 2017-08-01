#' Search TC/Govdata360 indicators, countries, categories, and dataset lists
#'
#' Searches using the TCdata360 API at \url{tcdata360.worldbank.org/docs}
#' or Govdata360 API at \url{govdata360.worldbank.org/docs}.
#' The function generates a wide dataframe containing the top search results related to the query.
#'
#' Hint: Want to use your search results to call data? Helpful functions include:
#' \itemize{
#'   \item See \code{\link{get_data360}} to get actual indicator/dataset/country-level data.
#'   \item See \code{\link{get_metadata360}} to get indicator/dataset/country-level metadata.
#'  \item See \code{\link{get_resources360}} to get additional resource information.
#' }
#'
#' @param search_string string to query in TC/Govdata360
#' @param site string pertaining to the data360 site to download data from.
#'     Possible choices: 'tc' for TCdata360, 'gov' for Govdata360
#' @param search_type NULL (optional). Character vector of search types to include.
#'     Possible values include: 'indicator', 'category', 'country'
#'     Leaving this NULL will return all possible search results.
#' @param limit_results NULL (optional). Number pertaining to the number of top results to be kept.
#'
#' @return List containing top search results
#' @examples
#' #search a country's code in TCdata360
#' search_360('Philippines', search_type = 'country')
#'
#' #search for top 10 relevant indicator codes in TCdata360
#' search_360('GDP', search_type = 'indicator', limit=10)
#'
#' #search for top 10 indicators of a database in TCdata360
#' search_360('World Development Indicators', search_type = 'indicator', limit=10)
#'
#' #search for top 10 indicators of a data provider in TCdata360
#' search_360('WEF', search_type = 'indicator', limit=10)
#'
#' #search for top 10 relevant categories in Govdata360
#' search_360('Governance', site='gov', search_type = 'category', limit_results = 10)

search_360 <- function(search_string = "World Bank", site = "tc", search_type = NULL, limit_results = NULL) {
    # determine API base based on site parameter
    if (site == "tc") {
        api_base <- "http://tcdata360-backend.worldbank.org/api/v1/search?q="
    } else if (site == "gov") {
        api_base <- "http://govdata360-backend.worldbank.org/api/v1/search?q="
    } else {
        # catch errors
        stop("site parameter should only be either 'tc' or 'gov'. Please try again.")
    }

    query <- utils::URLencode(tolower(search_string))
    dl_url <- paste(api_base, query, sep = "")
    df <- jsonlite::fromJSON(dl_url)
    df <- as.data.frame(df$results)

    search_types <- c("indicator", "category", "country")

    if (!is.null(search_type)) {
        if (length(search_type) == sum(search_type %in% search_types)) {
            df <- df[df$type %in% search_type, ]
        } else {
            # catch errors
            stop("search_type parameter should only be one or a combination of \"indicator\", \"category\", or \"country\". Please try again.")
        }
    }

    if (!is.null(limit_results)) {
        df <- utils::head(df, limit_results)
    }

    return(df)
}
