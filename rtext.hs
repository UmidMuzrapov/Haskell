rtext repSpec numRows numCols=putStr result
 where
  result=myconcat (createRow (createLongLine (createPattern repSpec) (numRows*numCols)) numCols numRows)

createRow:: [Char]->Int->Int->[[Char]]
createRow line numCol numRow=map (get10 line numCol) [1..numRow]

createLongLine:: [Char] ->Int->[Char]
createLongLine pattern max= take max (myconcat (replicate max pattern))

createPattern list= myconcat (map (\(elem, times)-> replicate times elem) list)

myconcat=foldl (++) []

get10 line numCol num =drop (numCol*num-numCol) (take (numCol*num) line)++"\n"