[![Build Status](https://travis-ci.org/cablegui/fars.svg?branch=master)](https://travis-ci.org/cablegui/fars)
[![Build status](https://ci.appveyor.com/api/projects/status/c6te6ehiviejf5st/branch/master?svg=true)](https://ci.appveyor.com/project/cablegui/fars/branch/master)

Coursera creating an R Package
------------------------------

This is my first package setup in github to play with the concepts of building packages, creating documentation, testing, github versioning, continuous integration with builds on Linux and Windows to make the package CRAN ready. All triggered so as to make the R package ready to ship

Some of the important steps and reminders are
---------------------------------------------

-   library(devtools) \# Run this within the package folder
-   document() \#This will document all the functions in the man directory
-   setwd("..") \# Go one directory step up
-   install("fars", build\_vignettes = TRUE) \#Enter your package name here. \#Including the build\_vignettes = TRUE will make the vignettes available
-   check("fars") \#Shortcut to do a R CMD check .
-   shell("rm -f fars.pdf") \# Create a pdf documentation of all the functions
-   setwd("./fars") \#Reset to the top of the directory tress

### Create a vignette skeleton sitting within the package directory using

use\_vignette("fars\_function\_details")\# You can create as many vignettes as you need.

### Create a testing framework skeleton using

use\_testthat() \#Will create s testthat directory and testthat.R file

### To create a data store

use\_data() \#FUnction to create an RDA dataset and stores in data folder. You need to create a data.R file describing the dataset for this to work before running checks.

### Make the package Travis ready for LINUX builds

use\_travis() \#Remember to insert the badge at the top of the Readme.md file so that whenever you make a change to the package and push to github an automatic integration test will be done.

### Make the package AppVeyor ready for windows build

use\_appveyor() \#Remember to insert the badge at the top of the Readme.md file so that whenever you make a change to the package and push to github an automatic integration test will be done.
