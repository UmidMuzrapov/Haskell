import Data.Char


fa x y z = (chr x, ord z, (not y))

fb x y z
 |head x==not(head x)=show(x)
 |chr (head y)==chr (head y)=show(x)
 |ord z==head y=show(x)
 |otherwise=show(x)

fc [(a, b)]=(b*b, a*a)

fd (a, [b]) c
 |fromInteger a==fromInteger a=chr c==chr c
 |chr c==chr c= chr c==chr c

fe [[a]]
 |ord a==ord a=[[]]
 |otherwise=[[]]