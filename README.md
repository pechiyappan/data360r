# WBdata360R
This R package makes it easy to engage with the API of from the TCdata360 and Govdata360 platforms at tcdata360.worldbank.org and govdata360.worldbank.org, respectively. Functionalities include easier download of datasets, metadata, and related information, as well as searching based on user-inputted query.

# Installation
This package can be easily installed by typing this in the `R` console:
```
install.packages("devtools")
devtools::install_github("mrpsonglao/WBdata360R")
```

# Usage and Examples
This version of the package supports the following functionalities. For more information, use the built-in `help()` function and `?` help operator in `R` to access the detailed documentation pages for each function.

## get_data360: Download TC/Govdata360 data by country, indicator, dataset, timeframe, or a combination of these
This function downloads the requested data by using the TC/Govdata360 API and transforms it into a dataframe.

**Output:** data frame (wide or long, depending on user input) containing requested data.

Some examples of its usage:
```
#get data for dataset ID 51 in TCdata360
df <- get_data360(dataset_id = 51)

#get data for countries USA, PHL in Govdata360
df2 <- get_data360(site = 'gov', country_iso3 = c('USA', 'PHL'))

#get data for indicator IDs 944, 972 in TCdata360
df3 <- get_data360(indicator_id = c(944, 972))

#get data for indicator IDs 944, 972 in 2011-2013 in long format in TCdata360
df4 <- get_data360(indicator_id = c(944, 972),
timeframes = c(2011, 2012, 2013), output_type = 'long')
```

## get_metadata360: Download TC/Govdata360 metadata
This function downloads the requested TC/Govdata360 metadata, such as:
  - `'countries'` == Lists metadata for all countries and regions.
  - `'indicators'` == Lists metadata for all indicators. Does not return actual data.
  - `'datasets'` == Lists metadata for all datasets.

**Output:** wide  dataframe containing requested metadata.

Some examples of its usage:
```
#get all indicator metadata in Govdata360
df_indicators <- get_metadata360(site="gov", metadata_type = "indicators")

#get all country metadata in TCdata360
df_countries <- get_metadata360(metadata_type = 'countries')

#get all dataset metadata in TCdata360
df_datasets <- get_metadata360(metadata_type = 'datasets')
```

## search_360: Search TC/Govdata360 indicators, countries, categories, and dataset lists
Don't know what codes to write as inputs for the above two functions? This helpful function searches TC/Govdata360 indicators, countries, categories, and dataset lists based on a user-inputted search query.

**Output:** dataframe containing top search results

Some examples of its usage:
```
#search a country's code in TCdata360
search_360('Philippines', search_type = 'country')

#search for top 10 relevant indicator codes in TCdata360
search_360('GDP', search_type = 'indicator', limit_results = 10)

#search for top 10 indicators of a database in TCdata360
search_360('World Development Indicators', search_type = 'indicator', limit_results = 10)

#search for top 10 indicators of a data provider in TCdata360
search_360('WEF', search_type = 'indicator', limit_results = 10)

#search for top 10 relevant categories in Govdata360
search_360('Governance', site='gov', search_type = 'category', limit_results = 10)
```

## get_resources360: Download TC/Govdata360 resource information
This function downloads the requested TC/Govdata360 resource information such as:
  - `'related'` == Find WBG content related to certain topics and countries. Note that this endpoint calls a number of external API so may take around 10s to return on the initial call, however after this the response will be cached.
  - `'toolkits'` == Find WBG toolkits related to certain topics and subtopics.
  - `'nav'` == List root categories in navigational hierarchy.

**Output:** wide dataframe containing requested resource information.

Some examples of its usage:
```
#get all indicator metadata in Govdata360
df_indicators <- get_metadata360(site="gov", metadata_type = "indicators")

#get all country metadata in TCdata360
df_countries <- get_metadata360(metadata_type = 'countries')

#get all dataset metadata in TCdata360
df_datasets <- get_metadata360(metadata_type = 'datasets')
```
