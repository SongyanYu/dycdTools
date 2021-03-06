% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Fun_Calib-assist.R
\name{calib.assist}
\alias{calib.assist}
\title{Assist calibration of DYRESM-CAEDYM model. Before using this function, make sure that you have set up "Bin" and "Files" sub-folders under the DYCD model folder.}
\usage{
calib.assist(
  cal.para = "Data/Calibration parameters.csv",
  combination = "random",
  n = 1,
  model.var = c("TEMP", "DO", "TN", "TP", "NO3", "PO4", "NH4", "SALINITY"),
  phyto.group = NA,
  obs.data = "Data/Obs.csv",
  objective.function = c("NSE", "RMSE"),
  start.date = "2017-06-06",
  end.date = "2020-02-29",
  dycd.wd = "work_directory",
  dycd.output = "work_directory/DYsim.nc",
  file_name = "work_directory/Calibration.csv",
  verbose = TRUE,
  parallel = FALSE,
  n.cores = NULL,
  write.out = FALSE
)
}
\arguments{
\item{cal.para}{a character string naming a file where parameters to be calibrated and their value ranges. this file need to have fixed colnames.}

\item{combination}{a vector of string character of how to pick up combinations of parameter values."random" or "all".}

\item{n}{the number of randomly selections. Must be provided if combination = random.}

\item{model.var}{a vector of string character of modelled variables for calibration.
When multiple phytoplankton groups will be combined for calibration, use "CHLA" and the following argument of "phyto.group" to specify them.
When phytoplankton groups will be calibrated separately, put their abbrev. in this argument. Currently, five abbrevs are supported: CHLOR, FDIAT, NODUL, CYANO and CRYPT.}

\item{phyto.group}{a vector of simulated phytoplankton groups, including CHLOR, FDIAT, NODUL, CYANO and CRYPT.}

\item{obs.data}{a character string naming a file of observed lake data. This file need to have fixed column names and orders.}

\item{objective.function}{a vector of string character claiming what objective function(s) to be used for calibration.
Selected from the following five functions: "NSE": Nash-Sutcliffe efficiency coefficient, "RMSE": Root Mean Square Error,
   "MAE": Mean Absolute Error, "RAE": Relative Absolute Error, "Pearson": Pearson's r.}

\item{start.date, end.date}{the beginning and ending simulation dates for the intended DYRESM-CAEDYM model run. The date format must be "\%Y-\%m-\%d".}

\item{dycd.wd}{working directory where input files (including the bat file) to DYRESM-CAEDYM are stored.}

\item{dycd.output}{a character string naming the output file from the model run.}

\item{file_name}{a character string naming a png file for writing out the auto-calibration results.}

\item{verbose}{if TRUE, the auto-calibration information is printed.}

\item{parallel}{if TRUE, the calibration process can be run on multiple cores.}

\item{n.cores}{When parallel is TRUE, n.cores is the number of cores the calibration function will be run on. If not provided,
the default value is the number of available cores on the computer -1.}

\item{write.out}{if TRUE, the auto-calibration results are saved a file with a file name set by the "file_name" argument.}
}
\value{
a dataframe of trialed values of parameters and corresponding values of objective function(s).
}
\description{
This function tries different combinations of selected parameter values and
  outputs corresponding values of fit-of-goodness by calculating some objective functions.
  Then users can choose the optimal set of parameter values to calibrate the model.
}
\note{
No executable examples are provided to illustrate the use of this function, as this function relies on the DYRESM-CAEDYM executables to work.
}
