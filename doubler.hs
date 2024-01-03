doubler:: [a] ->[a]
doubler = foldr (\elm accum->(replicate 2 elm)++accum) []