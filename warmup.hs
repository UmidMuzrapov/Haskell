mp f []=[]
mp f (h:t)=(f h):mp f t

filt f []=[]
filt f (h:t)
 |f h=h:filt f t
 |otherwise=filt f t

fl f accum []=accum
fl f accum (h:t)=fl f (f accum h) t

fr f accum list=frHelper f accum (reverse list)

frHelper f accum []=accum
frHelper f accum (h:t)=frHelper f (f h accum) t 

myany f []=False
myany f (h:tail)
 |f h=True
 |otherwise=myany f tail

myall f []=True
myall f (h:tail)
 |f h=myall f tail
 |otherwise=False

zw f [] _=[]
zw f _ []=[]
zw f (h1:t1) (h2:t2)= (f h1 h2):zw f t1 t2