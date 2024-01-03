paired:: [Char] -> Bool
paired [] =True
paired myList=checkBalance 0 myList

checkBalance:: Int -> [Char] -> Bool
checkBalance 0 []=True
checkBalance _ []=False
checkBalance num (x:xs)
 |num<0=False
 |x=='('=checkBalance (num+1) xs
 |x==')'=checkBalance (num-1) xs
 |otherwise=checkBalance num xs
