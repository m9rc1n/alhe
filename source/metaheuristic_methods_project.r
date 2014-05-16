#A general pattern of a metaheuristic method
#(C)Jaroslaw Arabas, ALHE, 2012
#To define the METHOD completely the user must 
#code the procedures of selection, model update, and variation.
#Proper execution of the metaheuristic method needs 
#a list of start points, an evaluation method
#an initialization procedure, and a termination condition

############################################################################################################
#                                       GENETIC ALGORITHM METHOD                                           #  
############################################################################################################

ga.initModel<-function(history, mi, lambda)
{
  model<-data.frame(x=numeric(mi+lambda), y=numeric(mi+lambda), minimum=numeric(mi+lambda))
  model<-ga.selection(history, model)
  return (model)
}

ga.select<-function(p)
{ 
  k<-sample(1:nrow(p), 1)
  temp<-data.frame(sigma_x=p$sigma_x[k], sigma_y=p$sigma_y[k], x=p$x[k], y=p$y[k], minimum=p$minimum[k], best_x=p$x[1], best_y=p$y[1], best_minimum=p$minimum[1])
  return (temp)
}

ga.crossover<-function(parent1, parent2)
{
  a<-runif(1)
  parent1$x<-a*parent1$x+(1-a)*parent2$x
  parent1$y<-a*parent1$y+(1-a)*parent2$y
  parent1$sigma_x<-a*parent1$sigma_x+(1-a)*parent2$sigma_x
  parent1$sigma_y<-a*parent1$sigma_y+(1-a)*parent2$sigma_y
  return (parent1)
}

ga.mutation<-function(point)
{
  epsilon <- runif(1, -1, 1)
  epsilonX <- runif(1, -1, 1)
  epsilonY <- runif(1, -1, 1)
  vX <- runif(1, -1, 1)
  vY <- runif(1, -1, 1)
  rA <- 1/(1/sqrt(4))
  rB <- 1/(1/sqrt(2*sqrt(2)))
  point$sigma_x <- point$sigma_x*exp(rA*epsilon + rB*epsilonX)
  point$sigma_y <- point$sigma_y*exp(rA*epsilon + rB*epsilonY)
  point$x <- point$x + point$sigma_x*vX
  point$y <- point$y + point$sigma_y*vY
  if (point$x < -512) {
    point$x<-(-512)
  }
  if (point$x > 512) {
    point$x<-512
  }
  if (point$y < -512) {
    point$y<-(-512)
  }
  if (point$y > 512) {
    point$y<-512
  }
  return (point)
}

ga.replacement<-function(p, o)
{
  z <- order(o$minimum)
  for (i in 1:nrow(p))
  {
    if(i<=nrow(o)) {
      p[i,]<-o[z[i],]
    } else {
      p[i,]<-p[i,]
    }
  }
  return (p)
}

ga.startPoints<-function(mi)
{
  startPoints<-data.frame(sigma_x=numeric(mi), sigma_y=numeric(mi), x=numeric(mi), y=numeric(mi), minimum=numeric(mi))
  for (i in 1:mi)
  {
    startPoints$x[i]<-runif(1, -512, 512)
    startPoints$y[i]<-runif(1, -512, 512)
    startPoints$sigma_x[i]<-0.2
    startPoints$sigma_y[i]<-0.2
    startPoints$minimum[i]<-1000.0
    startPoints$best_minimum[i]<-1000.0
  }
  return (startPoints)
}

ga.initialization<-function(startPoints)
{
  return (startPoints)
}

ga.metaheuristicRun<-function(initialization, startPoints, termination, evaluation, mi, lambda, pc, n)
{
  i<-1
  history<-common.initHistory(n)
  p<-ga.initialization(startPoints)
  o<-data.frame(sigma_x=numeric(lambda), sigma_y=numeric(lambda), x=numeric(lambda), y=numeric(lambda), minimum=numeric(lambda))
  while (!termination(i, n))
  {
    a<-runif(1)
    if(a<pc)
    {
      temp <- ga.mutation(ga.crossover(ga.select(p), ga.select(p)))
    }
    else
    {  
      temp <- ga.mutation(ga.select(p)) 
    }
    temp<-common.evaluate(temp, evaluation)
    temp<-common.selection(i-1, temp, history)
    history<-common.historyPush(i, temp[3:8], history)
    o[i%%lambda+1,]<-temp[1:5]
    i<-i+1
    if (i%%lambda == 1) p <- ga.replacement(p, o)
  }
  return(history)
}

############################################################################################################
#                                       UNIFORM DISTRIBUTION METHOD                                        #  
############################################################################################################

ud.variation<-function(point)
{
  point$x<-runif(1, -512, 512)
  point$y<-runif(1, -512, 512)
  return(point)
}

ud.metaheuristicRun<-function(initialization, termination, evaluation, n)
{
  i<-1
  history<-common.initHistory(n)
  point<-initialization()
  point<-common.evaluate(point, evaluation)
  history<-common.historyPush(i, point, history)
  while (!termination(i, n))
  {
    i<-i+1
    point<-ud.variation(point)
    point<-common.evaluate(point, evaluation)
    point<-common.selection(i-1, point, history)
    history<-common.historyPush(i, point, history)
  }
  return(history)
}

ud.initialization<-function()
{
  x <- runif(1, -512, 512)
  y <- runif(1, -512, 512)
  minimum <- 1000.0
  return (data.frame(x=x, y=y, minimum=minimum, best_x=x, best_y=y, best_minimum=minimum))
}

############################################################################################################
#                                       COMMON FUNCTIONS FOR METHODS                                       #  
############################################################################################################

common.initHistory<-function(n)
{
  history<-data.frame(x=numeric(n), y=numeric(n), minimum=numeric(n), best_x=numeric(n), best_y=numeric(n), best_minimum=numeric(n))
  return (history)
}

common.historyPush<-function(i, newPoint, history)
{
  if (i <= nrow(history))
  {
    history[i,] = newPoint
  }
  return (history)
}

common.historyPop<-function(history, number)
{
  stop=nrow(history)
  start=max(stop-number+1,1)
  return(history[start:stop,])
}

common.evaluate<-function(point, evaluation)
{
  point$minimum<-evaluation(point$x, point$y)
  return(point)
}

common.selection<-function(i, point, history)
{
  len<-max(i, 1)
  if(len == 1 || point$minimum<history$best_minimum[len]) 
  {
    point$best_x<-point$x
    point$best_y<-point$y
    point$best_minimum<-point$minimum
  } else {
    point$best_x<-history$best_x[len]
    point$best_y<-history$best_y[len]
    point$best_minimum<-history$best_minimum[len]
  }
  return(point) 
}

common.termination<-function(i, n)
{
  if (i <= n) { return (F) } 
  else { return (T) }
}

############################################################################################################
#                                            EGG HOLDER FUNCTION                                           #  
############################################################################################################

egg.function<-function(x, y)
{
  remaind<-(-(y+47))*sin(sqrt(abs(y+x/2+47)))
  remainder<-x*sin(sqrt(abs(x-(y+47))))
  return(remaind-remainder)
}

egg.termination<-function(p)
{
  minimum<-p$minimum[1]
  if(minimum<(-950)) {
    return (T)
  } else {
    return (F)
  }
}

############################################################################################################
#                                              SPHERE FUNCTION                                             #  
############################################################################################################

sphere.function<-function(x, y)
{
  return(x^2 + y^2)
}

############################################################################################################
#                                                   MAIN                                                   #  
############################################################################################################


# install.packages('ggplot2', dep = TRUE)
library(ggplot2)

mi<-10
lambda<-30
prawdopodobienstwo_kopulacji<-0.1
n<-10000

startPoints <- ga.startPoints(mi)
history<-ga.metaheuristicRun(ga.initialization, startPoints, common.termination, egg.function, mi, lambda, prawdopodobienstwo_kopulacji, n)
print(qplot(seq_along(history$best_minimum), history$best_minimum, data=history))
print(common.historyPop(history, 10))

#history<-ud.metaheuristicRun(ud.initialization, common.termination, egg.function, 3000)
#print(qplot(seq_along(history$best_minimum), history$best_minimum, data=history))
#common.historyPop(history, 20)