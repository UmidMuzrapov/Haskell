type Square=(Int, Int, Int, [Char])

constructString:: [[Char]]->[Char]
constructString []=[]
constructString (h:t)=h++"\n"++constructString t

drawSquares []=putStr ""
drawSquares [x]= putStr (constructString (constructSingleSquare x 0))
drawSquares lst=putStr(med lst)

med:: [Square] -> String
med input =constructString (mergeEverything (constructSquares((maxWidth, maxHeight,0, ".."):input)))
 where
  (maxWidth, maxHeight)=findDim input 0 0

constructSquares:: [Square] -> [[[Char]]]
constructSquares []=[]
constructSquares (h:t)=constructSingleSquare h 0: constructSquares t


mergeEverything::[[[Char]]] -> [[Char]]
mergeEverything []=[]
mergeEverything (first:[])=first
mergeEverything (first:second:xs)=mergeEverything ((mergeSq first second):xs)

findDim::[Square] ->Int->Int -> (Int, Int)
findDim [] maxWidth maxHeight=(maxWidth, maxHeight)
findDim ((x, y, dim, _):t) maxWidth maxHeight
 |(x+dim)>maxWidth && (y+dim)>maxHeight=findDim t (x+dim) (y+dim)
 |(x+dim)>maxWidth && (y+dim)<=maxHeight=findDim t (x+dim) maxHeight
 |(x+dim)<=maxWidth && (y+dim)>maxHeight=findDim t maxWidth (y+dim)
 |otherwise=findDim t maxWidth maxHeight

mergeSq:: [[Char]]->[[Char]]->[[Char]]
mergeSq first []=first
mergeSq [] second=second
mergeSq (firstH:firstT) (secondH:secondT)=(mergeRow firstH secondH): mergeSq firstT secondT


constructSingleSquare:: Square -> Int -> [[Char]]
constructSingleSquare (x, y, dim, [border, fill]) rowNum
  | rowNum < y = replicate width '.': constructSingleSquare (x, y, dim, [border, fill]) (rowNum + 1)
  | rowNum == y = (replicate x '.'++replicate dim border++".") : constructSingleSquare (x, y, dim, [border, fill]) (rowNum + 1)
  | rowNum == (height - 1) =(replicate x '.'++replicate dim border++".") : constructSingleSquare (x, y, dim, [border, fill]) (rowNum + 1)
  | rowNum < height = constructSingleRow x dim [border, fill] 0 : constructSingleSquare (x, y, dim, [border, fill]) (rowNum + 1)
  | rowNum == height = replicate width '.': constructSingleSquare (x, y, dim, [border, fill]) (rowNum + 1)
  | otherwise = []
  where
    width = x + dim+1
    height = y + dim



constructSingleRow :: Int -> Int -> [Char] -> Int -> [Char]
constructSingleRow col num [border, fill] colNum
  | colNum < col = '.':constructSingleRow col num [border, fill] (colNum + 1)
  | colNum == col = border:constructSingleRow col num [border, fill] (colNum + 1)
  | colNum == (col + num-1) = border:constructSingleRow col num [border, fill] (colNum + 1)
  | (colNum < width) && (fill=='#')= '.':constructSingleRow col num [border, fill] (colNum + 1)
  | colNum < width = fill:constructSingleRow col num [border, fill] (colNum + 1)
  | colNum == width = '.':constructSingleRow col num [border, fill] (colNum + 1)
  | otherwise = []
  where
    width = col + num


mergeRow:: [Char] -> [Char] -> [Char]
mergeRow first []=first
mergeRow [] second=second
mergeRow (firstH:firstT) (secondH: secondT)
 |firstH=='.'=secondH: mergeRow firstT secondT
 |secondH=='.'=firstH: mergeRow firstT secondT
 |otherwise=secondH: mergeRow firstT secondT
