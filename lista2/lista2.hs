divTuple(x, 0) = undefined
divTuple(x, y) = x / y

somatorio x y = sum [x..y]

somatorioRec a b | a == b = a
somatorioRec a b | otherwise = b + somatorioRec a (b - 1)

square x = x * x

sumSquares x y = square x + square y

higherOrderSum f x y = f x + f y

hoSumSquares = higherOrderSum square

mapFilter f p = (filter p) . (map f)

main = do 
          print (divTuple (4, 2))
          print (somatorio 0 1)
          print (somatorio 1 3)
          print (somatorioRec 1 3)
          print (square 3)
          print (sumSquares 3 4)
          print (higherOrderSum square 1 3)
          print (mapFilter square even [2, 1, 2, 3, 4, 5])
