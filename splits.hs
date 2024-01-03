splits []=error "shortList"
splits [x]=error "shortList"
splits myList=init (splitHelper 1 myList)

splitHelper x myList
 |x<length myList=(take x myList, drop x myList):splitHelper (x+1) myList
 |otherwise=[([], [])]