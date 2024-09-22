library(BPSC)
set.seed(2015)
dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


input <- function(inputfile) {
        pfix <<- prefix()
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
}

run <- function() {}

output <- function(outputfile) {

#Create a simulated gene expression by randomly generating 100 data points
#from a beta-poisson model
#alp=0.6;bet=1.5;lam1=20;lam2=0.05
alp = as.numeric(parameters["alpha", 2])
bet = as.numeric(parameters["beta", 2])
lam1 = as.numeric(parameters["lam1", 2])
lam2 = as.numeric(parameters["lam2", 2])
par0=c(alp,bet,lam1,lam2)
bp.vec=rBP(100,par0)
#Estimate parameters of the four-parameter beta-Poisson model from the data points
res=estimateBP(bp.vec,para.num=4)
#Print the goodness-of-fit of the model and the optimal parameters
print(res$X2)
print(res$par)
}
