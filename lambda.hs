-- fixpoint f = f (fixpoint f)

--Exemplos de expressoes lambda
square = \x -> x * x

--Implemente as funções anteriormente escritas usando expressões lambda
--consulte suas implementacoes anteriores para a documentacao dessas funcoes
pow = \a b -> if (b == 1) then a else a * pow a (b - 1)

fatorial = \x -> if (x==0) then 1 else x * fatorial(x-1)

isPrime = \x -> if (x < 4) then True else aux x (x -1)
    where aux = \a b -> if (b == 1) then True 
                        else if (a `mod` b) == 0 then False 
                        else aux a (b -1) 

fib = \x -> if x == 1 || x == 2 then 1 else fib (x - 1) + fib (x - 2)

mdc = \x y -> if x > y then mdc (x - y) y 
              else if x < y then mdc x (y - x)
              else x

mmc = \x y -> (x * y) `div` (mdc x y)

coprimo = \x y -> (mdc x y) == 1

goldbach = \x -> [ (y,z)| y <- filter isPrime [1..(x-1)], z <- filter isPrime [1..(x-1)], y + z == x ]

--Implemente as funções sobre listas escritas previsamente usando expressões lambda
--consulte suas implementacoes anteriores para a documentacao dessas funcoes
meuLast = \xs -> let size = (length xs) in 
                  if size > 0 then xs !! (size - 1) 
                  else error "Lista Vazia!"
 
penultimo = \xs -> let size = (length xs) in 
                 if size > 0 then xs !! (size - 2) 
                 else error "Lista Vazia!"

elementAt = \i xs -> xs !! (i - 1)

meuLength = \xs -> aux xs 0
    where aux = \l size -> if l == [] then size else aux (tail l) (size + 1) 

meuReverso = \xs -> if xs == [] then [] else meuReverso (tail xs) ++ [(head xs)]

isPalindrome = \xs -> let size = length xs in
                      if size < 2 then True
                      else if (head xs) == (last xs) then isPalindrome (init(tail xs))
                      else False

compress = \xs -> if xs == [] then [] else [head xs] ++ compress (auxCompress xs)

auxCompress = \l -> [y | y <- l, y `notElem` [head l]]

compact = \xs -> if xs == [] then [] else [head xs] ++ auxCompact xs ++ (compact (auxCompress xs))

auxCompact = \l -> tail [y | y <- l , y `elem` [head l]]

encode = \xs -> let h = (head xs) in 
                if xs == [] then [] 
                else [((h), length (auxCompact xs))] ++ (encode (auxCompress xs))

split = \xs i -> [(take i xs),(drop i xs)]

slice = \xs imin imax -> drop (imin - 1) (take imax xs)

insertAt = \el pos xs -> let ys = take (pos - 1) xs
                             zs = drop (pos - 1) xs in
                             ys ++ [el] ++ zs
        
sort = \xs -> let first = take half xs
                  second = drop half xs
                  half = length xs `div` 2 in
                  if length xs < 2 then xs else merge (sort first) (sort second) []

merge = \xs ys zs -> if xs == [] && ys == [] then zs
                     else if xs == [] then merge xs (tail ys) (zs ++ [head ys])
                     else if ys == [] then merge (tail xs) ys (zs ++ [head xs])
                     else if (head xs) > (head ys) then merge xs (tail ys) (zs ++ [head ys])
                     else merge (tail xs) ys (zs ++ [head xs])

mySum = \xs -> foldr (+) 0 xs

maxList = \xs -> if xs == [] then undefined else foldr max (head xs) (tail xs)

buildPalindrome = \xs -> let h = head xs
                             t = tail xs in
                             if xs == [] then [] 
                             else [h] ++ buildPalindrome t ++ [h]
                        
mean = \xs -> fromIntegral (sum xs) / fromIntegral (length xs) 

myAppend = \xs ys -> foldr (:) xs ys


main = do 
    print (square 2)
    print (pow 3 3)
    print (fatorial 5)
    print(isPrime 11)
    print(isPrime 3)
    print(isPrime 4)
    print (fib 4)
    print (mdc 27 18)
    print (mmc 27 18)
    print (coprimo 21 20)

    let lista = [1, 2, 3]
    print (meuLast lista)
    print (penultimo lista)
    print (elementAt 2 lista)
    print (meuLength lista)
    print (meuReverso lista)
    print (isPalindrome [1, 2, 1])
    print (compress [2,5,8,2,1,8])
    print (compact [2,5,8,2,1,8])
    print (encode [2,5,8,2,1,8])
    print (split [3,6,1,9,4] 3)
    print (slice [3,6,1,9,4] 2 4) 
    print (insertAt 7 4 [3,6,1,9,4])
    print (merge [1, 4, 6] [2, 3, 8] [])
    print (sort [3,6,1,9,4])
    print (mySum [2,5,8,2,1,8])
    print (maxList [2,5,8,2,1,8])
    print (buildPalindrome lista)
    print (mean lista)
    print (myAppend lista [2,5,8,2,1,8])