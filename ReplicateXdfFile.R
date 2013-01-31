##-----------------------------------------------------
# ReplicateXdfFile will take an xdf file and
# repeatedly append it to itself a specified
# number of times, resulting in a larger
# file. The return value is the full
# path name of the output file.
# If inFileName = "AirlineData87to08"
# and reps=5, the output file will be
# "AirlineData87to08Rep5.xdf" 
##-----------------------------------------------------
ReplicateXdfFile <- function(
	inFileName, # The base name of the file with no extension or path (i.e. "AirlineData87to08")
	dataDirInput, dataDirOutput,reps	# The directory where the input is and the output file will be written
	reps		# The number of replications to make
	)
{
	outFileName = paste(inFileName, "Rep", reps, sep="")

	inFile <- file.path(dataDirInput, inFileName)
	outFile <- file.path(dataDirOutput, outFileName)

	overwrite = FALSE
	for (i in 1:reps)
	{
		rxDataStep(inFile, outFile, blocksPerRead=1, reportProgress=3, overwrite=overwrite, 
			append="rows")
		overwrite = TRUE
	}

	return(outFile)
}

##-----------------------------------------------------
# Example usage: uncomment and modify as appropriate
dataDirInput = "/home/julian/data/AirlineData87to08_83010/"
dataDirOutput = "/home/julian/data/Airline1Billion"
inFileName = "AirlineData87to08.xdf"
reps = 8
#
system.time(outFile <- ReplicateXdfFile(inFileName, dataDirInput,dataDirOutput, reps))
#
rxGetInfoXdf(outFile, TRUE)

