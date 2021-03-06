#' Extract simulations from DYRESM-CAEDYM output.
#'
#' @description
#' Extract simulations from DYRESM-CAEDYM output. It is recommended to use the following example code to
#' assign values of each simulated variable to a corresponding matrix.
#'
#' @param dycd.output a string of characters of the output netcdf file names of DYRESM-CAEDYM model
#' @param var.extract a vector of variables to be extracted from the output file.
#'    Options include TEMP, DO, TP, NO3, NH4, TN, CHLOR, FDIAT, SSOL1, SSOL2, and PO4.
#'    Apart from nominated variables, simulation period and layer height data are also extracted.
#'
#' @import ncdf4
#'
#' @examples
#'  # extract simulated temperature values from DYRESM-CAEDYM simulation file
#'  var.values<-ext.output(dycd.output=system.file("extdata", "dysim.nc", package = "dycdtools"),
#'                        var.extract=c("TEMP"))
#'
#'  for(i in 1:length(var.values)){
#'   expres<-paste0(names(var.values)[i],"<-data.frame(var.values[[",i,"]])")
#'   eval(parse(text=expres))
#'  }
#'
#' @return a list of values of those variables of interest,
#'    as well as two compulsory variables (i.e. simulation period, water level)
#' @export
#'

ext.output<-function(dycd.output="data/dysim.nc",
                     var.extract=c("TEMP","DO","TP","TN","NO3","NH4","CHLA")){


  simData <- nc_open(dycd.output)
  varNames <- names(simData$var)

  message("You are going to extract ",length(var.extract)," variables.\n")

  if(any(is.na(match(var.extract,output_name$var.name)))){
    message(var.extract[is.na(match(var.extract,output_name$var.name))],"are not on the optional variable list.\n")
  }

  actual.var<-as.character(na.omit(output_name$output.name[match(var.extract,output_name$var.name)]))

  if("CHLA" %in% var.extract){
    actual.var<-append(actual.var,as.character(output_name$output.name[output_name$var.name=="CHLA"]))
    actual.var<-unique(actual.var)
  }

  actual.var<-append(actual.var,c("dyresmTime","dyresmLAYER_HTS_Var")) # add compulsory variables

  var.values<-lapply(actual.var,FUN = function(x) ncvar_get(simData,varNames[which(varNames==x)]))
  nc_close(simData)
  names(var.values)<-actual.var
  var.values[["dyresmTime"]]<-var.values[["dyresmTime"]]-450275

  return(var.values)
}
