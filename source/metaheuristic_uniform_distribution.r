#A general pattern of a metaheuristic method
#(C)Jaroslaw Arabas, ALHE, 2012
#To define the METHOD completely the user must 
#code the procedures of selection, model update, and variation.
#Proper execution of the metaheuristic method needs 
#a list of start points, an evaluation method
#an initialization procedure, and a termination condition

############################################################

#### TO BE DEFINED BY THE USER

#generation of a LIST of new points
#to be defined
ud.selection<-function(history, point)
{
  if(point$quality < history$quality) { return(point) } 
  else { return(history) }
}

ud.variation<-function(point)
{
  point$x <- runif(1)*1024-512
  point$y <- runif(1)*1024-512
  return (point)
}

#####  THE METAHEURISTIC "ENGINE"

#The main loop of a metaheuristic.
#The user must define a LIST of start points,
#a termination condition, an initialization procedure
#and an evaluation procedure.
#The result is the history of the run
ud.metaheuristicRun<-function(initialization, termination, evaluation)
{
  history<-initialization()
  point<-ud.evaluateList(history, evaluation)
  while (!termination(point))
  {
    point<-ud.variation(point)
    point<-ud.evaluateList(point, evaluation)
    history<-ud.selection(history, point)
  }
  return(history)
}

#evaluate a LIST of points
ud.evaluateList<-function(point, evaluation)
{
  point$i<-point$i+1
  point$quality<-evaluation(point)
  return(point)
}

ud.initialization<-function()
{
  x <- runif(1)*1024-512
  y <- runif(1)*1024-512
  quality <- 1000000.0
  i <- 0
  return (data.frame(x=x, y=y, quality=quality, i=i))
}

#push a LIST of points into the history
ud.historyPush<-function(oldHistory, newPoints)
{
  newHistory<-c(oldHistory,newPoints)
  return (newHistory)
}

#read a LIST of points pushed recently into the history
ud.historyPop<-function(history, number)
{
  stop=length(history)
  start=max(stop-number+1,1)
  return(history[start:stop])
}

ud.metaheuristicRun(ud.initialization, sphere.termination, sphere.function)

####  THAT'S ALL FOLKS

