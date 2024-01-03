cpfx (h:t)=foldl cpfx' h t

cpfx' (a:as) (b:bs)
    | a == b = a:cpfx' as bs
    | otherwise = ""
cpfx' _ _ = ""
