# Resubmission as of April 20, 2020
This is a resubmission. In this version, the following edits were included to resolve feedback from CRAN:

## Feedback from CRAN

### 1. Possibly mis-spelled words in DESCRIPTION:
```
APIs (13:11)
Govdata (3:23, 11:26)
TCdata (11:12)
```

* RESPONSE: These are properly spelled words within the context of the package, so I believe no action needs to be taken. Please let me know otherwise.

### 2. CRAN repository db overrides: X-CRAN-Comment: Archived on 2019-02-24 as issues were not corrected despite reminders.
Unfortunately my previous email in the "Maintainer" field (monglao@ifc.org) was suddenly deprecated and changed to monglao@worldbank.org and thus did not give me adequate time to update the Maintainer email from monglao@ifc.org to monglao@worldbank.org. Unfortunately, this led to me not being able to receive emails from CRAN on package issues, which is why I was not able to address them before the CRAN repository was archived.

* FIX/ACTION DONE: Updated the "Maintainer" field to my personal email, since my previous email for the Maintainer field (monglao@ifc.org) has been deprecated and changed to monglao@worldbank.org. I am using my personal email to be safe, in case the @worldbank.org email also gets deprecated in the future.

Revised "Authors" field in Description to:

```{r}
Authors@R: c(
    person("Ma. Regina Paz", "Onglao-Drilon", email = "reg@drilon.com", role = c("cre", "aut")),
    person("Ma. Regina Paz S.", "Onglao", email = "monglao@worldbank.org", role = c("aut")),
    person("World Bank Group", email = "tcdata360@worldbank.org", role = "cph"))
```
### 3. Has LICENSE with invalid COPYRIGHT HOLDER.

* RESPONSE: I believe the LICENSE has the correct COPYRIGHT HOLDER name. Please advise what needs to be revised to address this error.

### 4. Fix Examples with CPU elapsed time > 10s
```
Flavor: r-devel-linux-x86_64-debian-gcc
Check: examples, Result: NOTE
  Examples with CPU (user + system) or elapsed time > 10s
                   user system elapsed
  get_metadata360 0.063  0.012  10.817
```

* FIX/ACTION DONE: Added the `\dontrun{}` wrapper around the violating example for `get_metadata360.R` which takes too long to run.

### 5. Updated URIs in `man/*.Rd` files to include the protocol (e.g., HTTPS)
Addressing the following feedback from CRAN (c/o Uwe Ligges):

```
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
```

* FIX/ACTION DONE: Updated all violating files with the correct protocol, as follows:

- From: govdata360.worldbank.org/docs TO https://govdata360.worldbank.org/docs
- From: tcdata360.worldbank.org/docs TO https://tcdata360.worldbank.org/docs

## Other updates

### 1. Address API connection error in get_resources360.R file:
There was an API connection error during testing when R CMD Check was running the example:

```{r}
df_related <- get_resources360(resource_type = 'related')
```

Upon closer look, it seems that the underlying API from which the code is calling (i.e., https://tcdata360.worldbank.org/docs#!/Other_Resources/get_related) is currently return a 500 status response. 

* FIX/ACTION DONE: Revised "Authors" field in Description to:
Commented out the example "df_related <- get_resources360(resource_type = 'related')". This error is out of my hands since I am relying on an external public API, and thus commenting out is the best option to resolve the issue.

# Test environments
* local Windows install, 3.5.1 (2018-07-02) on x86_64-w64-mingw32 (64-bit)
* Ubuntu 14.04.5 LTS (on travis-ci), R 3.5.0 (2017-01-27)
* win-builder (R-devel (unstable) (2018-08-28 r75203))

# R CMD check results
Duration: 24.5s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

Note_to_CRAN_maintainers
Maintainer: 'Ma. Regina Paz Onglao-Drilon <reg@drilon.com>'
