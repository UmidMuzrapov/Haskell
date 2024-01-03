join::[Char]->[[Char]]->[Char]
join sep []=""
join sep [x]=x
join sep (h:t)=h++sep++(join sep t)