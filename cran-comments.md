# Resubmission as of April 24, 2020
This is a resubmission. In this version, the following edits were included to resolve feedback from CRAN (c/o Martina Schmirl):

## Feedback from CRAN

### 1. Write package names, software names, and API names in DESCRIPTION file with single quotes

Feedback from CRAN:
```
Please always write package names, software names and API (application
programming interface) names in single quotes in title and description.
e.g: --> 'TCdata360'
Please note that those names are case sensitive.
```

* FIX/ACTION DONE: Updated the DESCRIPTION file's Title and Description fields to the following:

```
Title: Wrapper for 'TCdata360' and 'Govdata360' API
```
and

```
Description: Makes it easy to engage with the Application Program Interface (API)
    of the 'TCdata360' and 'Govdata360' platforms at <https://tcdata360.worldbank.org/>
    ...
```

### 2. De-duplicate Person calls

Feedback from CRAN:
```
Why do you have 2 person calls to (I guess) the same person?
```

* FIX/ACTION DONE: Updated the DESCRIPTION file's Authors@R field as follows:

Deleted the duplicate entry:
```
person("Ma. Regina Paz S.", "Onglao", email = "monglao@worldbank.org", role = c("aut")),
```

### 3. Removing commented out code lines in examples

Feedback from CRAN:
```
Some code lines in examples are commented out.
Please never do that.
```

* Response: There was an API connection error during testing when R CMD Check was running the example:

```{r}
df_related <- get_resources360(resource_type = 'related')
```

Upon closer look, it seems that the underlying API from which the code is calling (i.e., https://tcdata360.worldbank.org/docs#!/Other_Resources/get_related) is currently returning a 500 status response. 

* FIX/ACTION DONE: 
Deleted the example "df_related <- get_resources360(resource_type = 'related')". This error is out of my hands since I am relying on an external public API, and thus I am deleting this example to resolve the issue.


### 4. Usage of "dontrun" in examples:

Feedback from CRAN:
```
\dontrun{} should only be used if the example really cannot be executed
(e.g. because of missing additional software, missing API keys, ...) by
the user. That's why wrapping examples in \dontrun{} adds the comment
("# Not run:") as a warning for the user.
Does not seem necessary.
Please put functions which download data in \donttest{}.
```

* FIX/ACTION DONE: Updated the corresponding files for `get_data360.R`, `get_metadata360.R`, `get_resources360.R`, and `search_360.R` to convert the examples from using "dontrun" to "donttest". Note that since all functions download data through API, these are wrapped with the "donttest" function as advised by CRAN.

# Test environments
* local Windows install, 3.5.1 (2018-07-02) on x86_64-w64-mingw32 (64-bit)
* Ubuntu 14.04.5 LTS (on travis-ci), R 3.5.0 (2017-01-27)
* win-builder (R-devel (unstable) (2018-08-28 r75203))

# R CMD check results
Duration: 20.4s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

Note_to_CRAN_maintainers
Maintainer: 'Ma. Regina Paz Onglao-Drilon <reg@drilon.com>'
