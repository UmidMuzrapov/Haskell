import System.Environment (getArgs)
import Data.Char
import Data.List
import Text.Printf

main = do -- 'do' "sequences" its expressions
 args <- getArgs -- Get command line args as list
 bytes <- readFile (last args)
 putStr (mainLogic (lines bytes) (head args))

mainLogic:: [[Char]] ->[Char]->[Char]
mainLogic listH mode=myconcat(["n = "++(show num)++"\n", "mean = "++(printf "%.3f" mean)++"\n",
 "median = "++(printf "%.3f" medean)++"\n"]++invalidHoursNew)
 where
  validHours=getValidHours listH
  invalidHours=map addline (getInvalidHours listH 0)
  invalidHoursNew
   |length invalidHours>0="\nIgnored:\n":invalidHours
   |otherwise=[]
  doubleList=getStats (map addSpace validHours) mode
  mean=getMean doubleList
  medean=getMedian doubleList
  num=length validHours
  addline elem=elem++"\n"

getMedian listDouble
 |even (length listDouble)=(middle+oneBefore)/2
 |otherwise=middle
  where
   middle=(sort listDouble)!!(div (length listDouble) 2)
   oneBefore=(sort listDouble)!!((div (length listDouble) 2)-1)

getMean:: [Double]->Double
getMean listDouble=sum/num
 where
  sum=foldl (+) 0 listDouble
  num=fromIntegral $ length listDouble

getValidHours::[[Char]]->[[Char]]
getValidHours listHours=filter f listHours
 where
  f element=isPrefixOf "Hours:" element

getInvalidHours:: [[Char]]->Int->[[Char]]
getInvalidHours [] num=[]
getInvalidHours (h:t) num
 |invalid=("Line "++(show (num+1))++": "++h):getInvalidHours t (num+1)
 |otherwise=getInvalidHours t (num+1)
  where
   invalid =not (isPrefixOf "Hours:" h)
  
getStats:: [[Char]]->[Char]->[Double]
getStats list mode=map getHour list
 where
  getHour=f mode

f mode singleLine
 |not rangeVal=stringToDouble processedNum
 |otherwise=getOneNum
 where
  --"2 - 3"
  numberPart=last (words $ addSpace (filter allowed singleLine))
  --"3-4"
  processedNum=filter allowed numberPart
  rangeVal =elem '-' processedNum
  --"3-4 mode"
  getOneNum
   |mode=="-h"=high
   |mode=="-l"=low
   |otherwise=(low+high)/2.0
    where 
     listNum=splitHours processedNum
     high=stringToDouble  $ last listNum
     low=stringToDouble $ head listNum

addSpace::[Char]->[Char]
addSpace []=[]
addSpace (h:t)
 |h==':'=h:' ':t
 |otherwise=h:addSpace t

allowed charac
 |charac=='-'=True
 |charac=='.'=True
 |otherwise=isDigit charac
 
splitHours::String -> [String]
splitHours s
    | null left = [low]
    | otherwise = [low,left]
    where
     low = takeWhile (\c -> isDigit c || c == '.') s
     left=drop (length low + 1) s
	 
stringToDouble str = read str :: Double

myconcat=foldl (++) []