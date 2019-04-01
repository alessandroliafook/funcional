meuLast xs | length xs > 0 = xs !! ((length xs) - 1)
           | otherwise = error "Lista vazia!"

penultimo xs | length xs < 2 = error "Lista sem penúltimo!"
             | otherwise = xs !! ((length xs) - 2)

elementAt i xs = xs !! (i - 1)

-- meuLength [] = 0
-- meuLength xs = 1 + length (tail xs)

meuLength l = meuLengthAux l 0

meuLength [] i = i
meuLength xs i = meuLengthAux (tail xs) (i + 1)

main = do
        let lista = [1, 2, 3]
        print (meuLast lista)
        -- print (meuLast [])
        print (penultimo lista)
        print (elementAt 2 lista)
        -- print (meuLength lista)


