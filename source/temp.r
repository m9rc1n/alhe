sphere.function<-function(coords)
{
  return(coords$x^2 + coords$y^2)
}

egg.function<-function(coordinates)
{
  x = coordinates$x
  y = coordinates$y
  remaind<-(-(y+47))*sin(sqrt(abs(y+x/2+47)))
  remainder<-x*sin(sqrt(abs(x-(y+47))))
  return(remaind-remainder)
}

sphere.termination<-function(point)
{
  point
  if (point$i < 100000) { return (F) } 
  else { return (T) }
}