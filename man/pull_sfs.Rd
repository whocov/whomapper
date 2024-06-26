% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pull_sfs.R
\name{pull_sfs}
\alias{pull_sfs}
\title{function to pull sfs from local or server}
\usage{
pull_sfs(adm_level = 0, iso3 = NULL, region = NULL, query_server = TRUE)
}
\arguments{
\item{adm_level}{- which administrative level}

\item{iso3}{the iso3 code of the country to pull data from. Defaults to NULL}

\item{region}{the WHO region to pull data from. Defaults to NULL}

\item{query_server}{should the data be pulled from the server? defaults to TRUE}
}
\value{
shapefiles as specified
}
\description{
function to pull sfs from local or server
}
\details{
function to read shapefiles for plotting purposes. cNurrently supports admin levels 0 through 2.
Can pull data from WHO servers or from stored offline versions (only to level 1.)
Stored data is not guaranteed to be up to date
Pulling adm0 data will also pull disputed areas and territories, and lines for plots where borders do not include coastlines.
It is recommended to pull country or at most regional data at lower administrative levels due to API limitations.
Consider iterating over consecutive areas if more data needed.
}
\author{
HLS
}
