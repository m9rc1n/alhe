sphereFunction<-function(coordinates)
{
  return(coordinates$x^2 + coordinates$y^2)
}

eggHolderFunction<-function(coordinates)
{
  x = coordinates$x
  y = coordinates$y
  remaind<-(-(y+47))*sin(sqrt(abs(y+x/2+47)))
  remainder<-x*sin(sqrt(abs(x-(y+47))))
  return(remaind-remainder)
}

F<-2144

uniformMethodEggHolder<-function()
{
  while (F>-959.6)
  {
    x <- runif(1)*1024-512
    y <- runif(1)*1024-512
    minimum = eggHolderFunction(x, y)  
    if (minimum < F)
    {
      print("x= ")
      print(x)
      print("y= ")
      print(y)
      print(minimum)
      F = minimum
    }
  }
  return(F)
}

Fxy<-2144

uniformMethodSphere<-function()
{
  while (Fxy>0.001)
  {
    x <- runif(1)*10-5
    y <- runif(1)*10-5
    minimum = sphereFunction(x, y)  
    if (minimum < Fxy)
    {
      print("x= ")
      print(x)
      print("y= ")
      print(y)
      print(minimum)
      Fxy = minimum
    }
  }
  return(Fxy)
}


uniformMethodSphere()

