rme 0=0
rme n
 |odd remainder=10*rme whole+remainder
 |otherwise=rme whole
 where{
  remainder=n `mod` 10;
  whole=n `div` 10;
 }