--pancakes::[[Int]]->IO()
pancakes (list)=putStr (myconcat(map addLine (foldl f (stack (head list)) t)))
 where
  addLine elem=elem++"\n"
  h=head list
  t=tail list
  maxHeight=maximum (map length list)
  stack elem=refineStack maxHeight (maximum elem) (constructStack (maximum elem) elem)
  f accum elem=zipWith (++) accum (stack elem)

refineStack::Int->Int->[[Char]]->[[Char]]
refineStack maxHeight width list=replicate additionalHeight (replicate (width+1) ' ')++list
 where
  additionalHeight=maxHeight-(length list)


constructStack:: Int->[Int]->[[Char]]
constructStack width list=map constructLine list
 where
  constructLine elem=replicate (div (width-elem) 2) ' '++replicate elem '*'++replicate (div (width-elem) 2) ' '++" "

myconcat=foldl (++) []