#################################################################
# Run a logistic regression on a dataset with about 1 billion 
# observations using our 5-node cluster
#
# Estimate whether or not a flight is late using days of the
# week as explanatory variables
#################################################################
	
sink('BenchMarktest.txt')
billionRowsData <- file.path("/home/julian/data/Airline1Billion","AirlineData87to08.xdfRep8.xdf")

billionRowsData <- RxXdfData(billionRowsData)
# Set options to use our cluster, waiting for the results

# if running on NumaConnect
rxOptions(computeContext=RxLocalParallel())
#rxOptions( computeContext = myWaitCluster )

# Model with 7 coefficients
system.time(
clusterLogit <- rxLogit(Diverted ~ DayOfWeek, data = billionRowsData)
)

sink()

