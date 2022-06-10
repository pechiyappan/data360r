#' Get TC/Govdata360 resource information from API
#'
#' Downloads the requested resource information by using the TCdata360 API at \url{https://tcdata360.worldbank.org/docs}
#' or Govdata360 API at \url{https://govdata360.worldbank.org/docs}.
#' The function generates a wide dataframe containing resource information.
#'
#' Hint: Want to get other data? Helpful functions include:
#' \itemize{
#'   \item See \code{\link{search_360}} to get search TC/Govdata360 indicators, countries, categories, and dataset lists.
#'   \item See \code{\link{get_data360}} to get actual indicator/dataset/country-level data.
#'  \item See \code{\link{get_metadata360}} to get indicator/dataset/country-level metadata.
#' }
#'
#' @param site string pertaining to the data360 site to download data from.
#'     Possible choices: 'tc' for TCdata360, 'gov' for Govdata360
#' @param resource_type string pertaining to the metadata to be downloaded. Possible choices:
#'     'related' == Find WBG content related to certain topics and countries.
#'                 Note that this endpoint calls a number of external API so may take around 10s to return on the initial call,
#'                however after this the response will be cached.
#'     'toolkits' == Find WBG toolkits related to certain topics and subtopics.
#'     'nav' == List root categories in navigational hierarchy.
#' @export
#' @return Data frame (wide) containing requested resource information
#' @examples
#' ## Since all functions download data through API, these are wrapped with
#' ## the "donttest" function as advised by CRAN
#' #get all root-level categories in TCdata360
#' \donttest{df_nav <- get_resources360()}
#'
#' #get all toolkits from Govdata360
#' \donttest{df_toolkits <- get_resources360(site='gov', resource_type = 'toolkits')}

get_resources360 <- function(site = "tc", resource_type = "nav") {
    # determine API base based on site parameter
    if (site == "tc") {
        api_base <- "https://tcdata360-backend.worldbank.org/api/v1/"
    } else if (site == "gov") {
        api_base <- "https://govdata360-backend.worldbank.org/api/v1/"
    } else {
        # catch errors
        stop("site parameter should only be either 'tc' or 'gov'. Please try again.")
    }

    resource_types <- c("related", "toolkits", "nav")

    if (!is.null(resource_type) && (length(resource_type) == sum(resource_type %in% resource_types))) {
        dl_url <- paste(api_base, resource_type, "/", sep = "")
        df <- jsonlite::fromJSON(dl_url)
        return(df)
    } else {
        stop("resource_type parameter should only be one or a combination of 'related', 'toolkits', 'nav'.")
    }

}
