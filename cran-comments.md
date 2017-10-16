## Resubmission
This is a resubmission. In this version, the following edits were included to resolve feedback from CRAN (c/o Swetlana Herbrandt):

### 1. For DESCRIPTION file
Thanks, please write URLs in your description in the form
<http:...> or <[https:...]https:...>
with angle brackets for auto-linking and no space after 'http:' and 'https:'.

* Done. Revised Description to: <https://tcdata360.worldbank.org/> and <https://govdata360.worldbank.org/>

Please do not start the description with 'This R package' or similar. 
Perhaps just start with 'Makes it easy to ...'.
* Done. Removed "This R package" phrase at the start of Description.

Please explain what kind of the data these APIs provide.
* Done. Added this sentence in Description: "These APIs provide access to over 5000 trade, competitiveness, and governance indicator data, metadata, and related information from sources both inside and outside the World Bank Group."

Please omit the redundant 'R' in your title.
* Done. Revised the title to "Wrapper for TC/Govdata360 API"

### 2. For R scripts in /R directory
Please do not comment out your examples.
Something like
```
\examples{
        examples for users:
        executable in < 5 sec
        for checks
        \dontshow{
               examples for checks:
               executable in < 5 sec together with the examples above
               not shown to users
        }
        donttest{
               further examples for users (not used for checks)
        }
}
```
would be desirable.
* Done. Examples that take more than 5 seconds collectively to run are not run using "\dontrun{}" function for the package to pass R cmd check.

## Test environments
* local Windows install, R 3.4.2 (2017-09-28)
* ubuntu 14.04 (on travis-ci), R 3.4.1 (2017-01-27)
* win-builder (R-devel)

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Ma. Regina Paz S. Onglao <monglao@ifc.org>'

New submission

Possibly mis-spelled words in DESCRIPTION:
  API (3:34, 10:78)
  APIs (13:11)
  Govdata (3:23, 11:26)
  TCdata (11:12)
  metadata (14:21, 16:61)

  
This is my first submission.
These are the proper spellings of the terms used above.
