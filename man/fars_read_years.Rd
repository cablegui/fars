% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_read_years}
\alias{fars_read_years}
\title{Create a dataframe of selected year from FARS dataset}
\usage{
fars_read_years(years)
}
\arguments{
\item{years}{A character or integer vector of years}
}
\value{
This function returns a dataframe.
}
\description{
fars_read_years is used to create a datafrane of selected year from FARS dataset
}
\details{
The function creates a dataframe of Month and year from the FARS base dataset
}
\note{
Error message:If an incorrect year integer or string is entered then an error is thrown
}
\examples{
\dontrun{
fars_read_years(2013)
fars_read_years(c(2013,2014))
}

}

