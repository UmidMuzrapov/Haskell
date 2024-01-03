expand:: [Char]->[[Char]]
expand string=word:(map (wordCreator word) list)
 where
  word=head(words(parseWords string))
  list=tail (words(parseWords string))

wordCreator:: [Char]->[Char]->[Char]
wordCreator word ('@':t)=init word ++t
wordCreator word ('#':t)=word++[last word]++t
wordCreator word list=word++list

parseWords list=foldr f [] list

f ',' accum=' ':accum
f lettr accum=lettr:accum