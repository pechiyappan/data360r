## Resubmission as of April 20, 2020
This is a resubmission. In this version, the following edits were included to resolve feedback from CRAN (c/o Uwe Ligges):

### 1. Updated URIs in man/*.Rd files to include the protocol (e.g., HTTPS)
Addressing feedback from CRAN (c/o Uwe Ligges):

Found the following (possibly) invalid file URIs:
     URI: tcdata360.worldbank.org/docs
       From: man/get_data360.Rd
     URI: govdata360.worldbank.org/docs
       From: man/get_data360.Rd
     URI: tcdata360.worldbank.org/docs
       From: man/get_metadata360.Rd
     URI: govdata360.worldbank.org/docs
       From: man/get_metadata360.Rd
     URI: tcdata360.worldbank.org/docs
       From: man/get_resources360.Rd
     URI: govdata360.worldbank.org/docs
       From: man/get_resources360.Rd
     URI: tcdata360.worldbank.org/docs
       From: man/search_360.Rd
     URI: govdata360.worldbank.org/docs
       From: man/search_360.Rd

Please use fully specified URLs incl the protocol, e.g. starting
https://.....

Please fix and resubmit.

* FIX/ACTION DONE: Updated all violating files with the correct protocol, as follows:

From: govdata360.worldbank.org/docs TO https://govdata360.worldbank.org/docs
From: tcdata360.worldbank.org/docs TO https://tcdata360.worldbank.org/docs

### 2. For DESCRIPTION file
Updated the "Maintainer" field to my personal email, since my previous email for the Maintainer field (monglao@ifc.org) has been deprecated and changed to monglao@worldbank.org. I am using my personal email to be safe, in case the @worldbank.org email also gets deprecated in the future.

* FIX/ACTION DONE: Revised "Authors" field in Description to:

Authors@R: c(
    person("Ma. Regina Paz", "Onglao-Drilon", email = "reg@drilon.com", role = c("cre", "aut")),
    person("Ma. Regina Paz S.", "Onglao", email = "monglao@worldbank.org", role = c("aut")),
    person("Trade and Competitiveness Global Practice",
    "World Bank Group", email = "tcdata360@worldbank.org", role = "cph"))

### 3. For the get_resources360.R file:
There was an API connection error during testing when R CMD Check was running the example:
```{r}
df_related <- get_resources360(resource_type = 'related')
```

Upon closer look, it seems that the underlying API from which the code is calling (i.e., https://tcdata360.worldbank.org/docs#!/Other_Resources/get_related) is currently return a 500 status response. 

* FIX/ACTION DONE: Revised "Authors" field in Description to:
Commented out the example "df_related <- get_resources360(resource_type = 'related')". This error is out of my hands since I am relying on an external public API, and thus commenting out is the best option to resolve the issue.

## Test environments
* local Windows install, 3.5.1 (2018-07-02) on x86_64-w64-mingw32 (64-bit)
* Ubuntu 14.04.5 LTS (on travis-ci), R 3.5.0 (2017-01-27)
* win-builder (R-devel (unstable) (2018-08-28 r75203))

## R CMD check results
Duration: 40.1s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

Note_to_CRAN_maintainers
Maintainer: 'Ma. Regina Paz Onglao-Drilon <reg@drilon.com>'
