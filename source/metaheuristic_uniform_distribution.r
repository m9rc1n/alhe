#A general pattern of a metaheuristic method
#(C)Jaroslaw Arabas, ALHE, 2012
#To define the METHOD completely the user must 
#code the procedures of selection, model update, and variation.
#Proper execution of the metaheuristic method needs 
#a list of start points, an evaluation method
#an initialization procedure, and a termination condition

############################################################

#### TO BE DEFINED BY THE USER

#selection of a LIST of points from the history
#to be defined
selection<-function(history)
{
  #select a number of points from the history using the 
  #method's parameters and the current state of the model
  return(selectedPoints)
}

#generation of a LIST of new points
#to be defined
variation<-function(selectedPoint)
{
  selectedPoint$coordinates$x <- runif(1)*1024-512
  selectedPoint$coordinates$y <- runif(1)*1024-512
  return (selectedPoint)
}

#####  THE METAHEURISTIC "ENGINE"

#The main loop of a metaheuristic.
#The user must define a LIST of start points,
#a termination condition, an initialization procedure
#and an evaluation procedure.
#The result is the history of the run
metaheuristicRun<-function(initialization, startPoint, termination, evaluation)
{
  history<-initialization(startPoint)
  #history<-evaluateList(history)
  while (!termination(history))
  {
    newPoint<-variation()
    #newPoint<-evaluateList(newPoint, evaluation)
    history<-historyPush(history, newPoint)
  }
  return(history)
}

#push a LIST of points into the history
historyPush<-function(oldHistory, newPoint)
{
  newHistory<-c(oldHistory,newPoint)
  return (newHistory)
}

#read a LIST of points pushed recently into the history
historyPop<-function(history, number)
{
  stop=length(history)
  start=max(stop-number+1,1)
  return(history[start:stop])
}

#evaluate a LIST of points
evaluateList<-function(point, evaluation)
{
  point$quality<-evaluation(point$coords)
  return(point)
}

initialization<-function(startPoint)
{
  startPoint$coordinates$x <- runif(1)*1024-512
  startPoint$coordinates$y <- runif(1)*1024-512
  return (startPoint)
}

termination<-function(history)
{
  if (history$quality < 0.01) { return (F) } 
  else { return (T) }
}

x <- 1
y <- 1

evaluation<-function(history)
{
  sphereFunction(history)
}

metaheuristicRun(initialization, xy.coords(x, y), termination, evaluation)

####  THAT'S ALL FOLKS

