#'@title Reading FARS csv data files
#'
#'@description  fars_read is used to read FARS (Fatality Analysis Reporting System) csv files.
#'
#'@param filename A character string of the path and the file name. For example
#'"./A/B/C/xyz.csv.bz2"
#'
#'@note Error Message: If a wrong file name is entered then an error is thrown
#'
#'@details Converts a FARS bz2 file into a dataframe
#'
#'@return This function returns a data frame.
#'
#'@examples
#'t <- system.file("extdata", "accident_2013.csv.bz2", package="fars")
#'fars_read(t)
#'
#'@importFrom readr read_csv
#'
#'@export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#'@title Create FARS data file
#'
#'@description  make_filename is used to create a FARS (Fatality Analysis Reporting System) character string filename.
#'
#'@param year A character or integer variable of the year
#'
#'@note Error message: If the wrong file name is used then an error will be thrown
#'
#'@details The function creates a character string with a filename of the year say 2006
#'in the format of accident_2006.csv.bz2
#'
#'
#'@return This function returns a filename in the form of a character string.
#'
#'@examples
#'\dontrun{
#'make_filename("2016")
#'make_filename(2016)
#'}
#'
#'@export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#'@title Create a dataframe of selected year from FARS dataset
#'
#'@description  fars_read_years is used to create a datafrane of selected year from FARS dataset
#'
#'@param years A character or integer vector of years
#'
#'@note Error message:If an incorrect year integer or string is entered then an error is thrown
#'
#'@details The function creates a dataframe of Month and year from the FARS base dataset
#'
#'
#'@return This function returns a dataframe.
#'
#'@examples
#'\dontrun{
#'fars_read_years(2013)
#'fars_read_years(c(2013,2014))
#'}
#'
#'@importFrom dplyr mutate select %>%
#'
#'
#'@export
fars_read_years <- function(years) {
   lapply(years, function(year) {
     file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
   })
}

#'@title Summarize FARS data set by year and each month in year
#'
#'@description  fars_summarize_years is used to create a summary of the number of data points per
#'year and each month in the year.
#'
#'@param years A character or integer vector of years
#'
#'@note Error message:If an incorrect year integer or string is entered then an error is thrown
#'
#'@details The function creates a summary dataframe of number of data points in the FARS data set
#'summarized per year and each month
#'
#'@return This function returns a dataframe.
#'
#'@examples
#'\dontrun{
#'fars_summarize_years(2013)
#'fars_summarize_years(c(2013,2014))
#'}
#'@importFrom dplyr bind_rows group_by summarize %>%
#'@importFrom tidyr spread
#'@export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

#'@title Graphical map of fatalities in FARS data STATE and year
#'
#'@description  fars_map_state is used to create a graphical map of number of fatalities per
#'STATE and year.
#'
#'@param state.num Integer of state
#'@param year A character or integer of year
#'
#'@note Error message: If an incorrect year or state is entered an error is thrown
#'
#'@details The function draws a maps with dots displaying the number of fatalities per STATE and year
#'
#'@return This function returns NULL.
#'
#'@examples
#'\dontrun{
#'fars_map_state(1,2013)
#'}
#'
#'@importFrom dplyr filter
#'@importFrom maps map
#'@importFrom graphics points
#'
#'@export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
