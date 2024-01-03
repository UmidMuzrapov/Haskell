import System.Environment (getArgs)

main = do -- 'do' "sequences" its expressions
 args <- getArgs -- Get command line args as list
 bytes <- readFile (head args)
 putStr (makeList (lines bytes))

makeList::[[Char]] ->[Char]
makeList myList=myconcat(finalFormat (addSep removedList))
 where
  removeBlank []=False;
  removeBlank _=True;
  removedList=filter removeBlank myList

addSep :: Foldable t => t [Char] -> [[Char]]
addSep list=foldl f [] list
  
f:: [[Char]]->[Char]->[[Char]]
f [] elem=[]++[elem++"\n"]
f accum elem
 |previousChar==newChar=accum++[elem++"\n"]
 |otherwise=accum++["------\n"]++[elem++"\n"]
  where
   previousChar=head (last accum)
   newChar=head elem

myconcat=foldl (++) []

counter::[[Char]]->Int
counter list=length (filter remove list)
 where
  remove "------\n"=False
  remove _=True

finalFormat::[[Char]]->[[Char]]
finalFormat list=foldl f2 [] list

f2:: [[Char]] ->[Char]->[[Char]]
f2 accum elem
 |elem=="------\n"=accum++[elem]
 |otherwise=accum++[show(counter accum+1)++" "++elem]