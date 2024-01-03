rep from to = ("rep", from, to)
xlt from to = ("xlt", from, to)
len = ("len", "", "")
rev = ("rev", "", "")
x n = ("x", show n, "")

editstr::[([Char], [Char], [Char])]->[Char]->[Char]
editstr [] word=word
editstr operatios []=[]
editstr ((operation, firstArg, secondArg):rest) word
 |(operation=="xlt") && (length firstArg==length secondArg)=editstr rest (xltF firstArg secondArg word)
 |operation=="xlt"=error "badSpec"
 |operation=="rep"=editstr rest (repF firstArg secondArg word)
 |operation=="x"=editstr rest (xF firstArg secondArg word)
 |operation=="len"=editstr rest (show(lenF word))
 |operation=="rev"=editstr rest (revF word)
 |otherwise=error "badSpec"



xltF:: [Char] -> [Char] ->[Char] ->[Char]
xltF [] to word=word
xltF (fromH:fromT) (toH:toT) word=xltF fromT toT (repF [fromH] [toH] word)

repF:: [Char]-> [Char]-> [Char]->[Char]
repF from to []=[]
repF [from] to (h:t)
 |from==h=to++repF [from] to t
 |otherwise=h:repF [from] to t
repF from _ _=error "badSpec"

xF:: [Char]-> [Char]->[Char]->[Char]
xF times _ word=joinList(replicate (read times) word) 

lenF:: [Char]->Int
lenF word=length word

revF:: [Char] ->[Char]
revF word=reverse word

joinList:: [[Char]]->[Char]
joinList []=""
joinList (x:t)=x++joinList t

