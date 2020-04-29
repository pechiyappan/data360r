# Updated as of April 29, 2020
In this version, the package Maintainer has been transferred from Ma. Regina Paz Onglao-Drilon <reg@drilon.com> to Ramin Aliyev <tcdata360@worldbank.org> for sustainability purposes. This was also done to address feedback from CRAN that the new maintainer must be a person.

Changes made are:

## 1. Updated the DESCRIPTION file

Addressed the following feedback from CRAN:
```
No, the new maintainer does not work for us, see the CRAN policies:

"The package’s DESCRIPTION file must show both the name and email
address of a single designated maintainer (a person, not a mailing
list). That contact address must be kept up to date, and be usable for
information mailed by the CRAN team without any form of filtering,
confirmation … "

So please change back or change to another person.
```

* FIX/ACTION DONE: Updated the DESCRIPTION file's Authors@R field to the following to reflect the new package Maintainer (a person):

```
Authors@R: c(
    person("Ramin", "Aliyev", email = "tcdata360@worldbank.org", role = "cre"),
    person("Ma. Regina Paz", "Onglao-Drilon", email = "reg@drilon.com", role = "aut"),
    person("World Bank Group", role = "cph"))
```

# Test environments
* local Windows install, 3.5.1 (2018-07-02) on x86_64-w64-mingw32 (64-bit)
* Ubuntu 14.04.5 LTS (on travis-ci), R 3.5.0 (2017-01-27)
* win-builder (R-devel (unstable) (2018-08-28 r75203))

# R CMD check results
Duration: 24.1s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

Note_to_CRAN_maintainers
Maintainer: 'Ramin Aliyev <tcdata360@worldbank.org>'
Note that previous Maintainer was 'Ma. Regina Paz Onglao-Drilon <reg@drilon.com>'
