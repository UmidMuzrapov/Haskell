nnn::[Int] ->[[Char]]
nnn list= map buildN list

buildN:: Int -> [Char]
buildN elem= (show elem) ++ myconcat (replicate (elem-1) ("-"++(show elem)))

myconcat=foldl (++) []