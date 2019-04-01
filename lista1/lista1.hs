module Main where

    xor:: Bool -> Bool -> Bool
    xor a b = (a || b) && not (a && b)

    impl:: Bool -> Bool -> Bool
    impl a b = not a || b
    
    equiv:: Bool -> Bool -> Bool
    equiv a b = impl a b && impl b a

    pow:: Integer -> Integer -> Integer
    pow a b = a

    fatorial:: Integer -> Integer
    fatorial a | a == 0 = 1
               | otherwise = a * fatorial (a - 1)

    isPrime:: Integer -> Bool
    isPrime a | a == 1 = True
              | a == 2 = True
              | a == 3 = True
              | otherwise = isPrimeAux a (a - 1)

    isPrimeAux:: Integer -> Integer -> Bool
    isPrimeAux _ 1 = True
    isPrimeAux a b = if (a `mod` b) == 0 then False else isPrimeAux a (b -1)

    fib:: Integer -> Integer
    fib a | a == 1 = 1
          | a == 2 = 1
          | otherwise = fib (a - 1) + fib (a - 2)

    mdc:: Integer -> Integer -> Integer
    mdc a b | a < b = mdc a (b - a)
            | a > b = mdc (a - b) b
            | otherwise = a

    mmc:: Integer -> Integer -> Integer
    mmc a b = (a * b) `div` (mdc a b) 

    coprimo:: Integer -> Integer -> Bool
    coprimo a b = (mdc a b) == 1

    goldbach:: Integer -> [(Integer, Integer)]
    goldbach x = [ (y,z)| y <- filter isPrime [1..(x-1)], z <- filter isPrime [1..(x-1)], y + z == x ]
    
    main = do putStrLn "What is 5! ?"
              x <- readLn
              if x == fatorial 5
                  then putStrLn "You're right!"
                  else putStrLn "You're wrong!"
              
              y <- readLn
              z <- readLn

              print (goldbach y)
