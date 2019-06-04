{-
- Dada uma tupla, divide o primeiro pelo segundo usando pattern matching.
- Ela deve ser indefinida quando o denominador for zero.
-}
divTuple (x, 0) = undefined
divTuple (x, y) = x / y

{-
 - Calcula o somatorio entre dois numeros a e b (a < b). Procure usar alguma funcao pronta sobre listas. 
 - Ex: somatorio 0 1 = 1
 -     somatorio 1 3 = 6
-}
somatorio x y = sum [x..y]

{-
 - Calcula o somatorio (recursivo) entre dois numeros a e b (a < b).
 - Ex: somatorio 0 1 = 1
 -     somatorio 1 3 = 6
-}
somatorioRec a b | a == b = a
                 | otherwise = b + somatorioRec a (b - 1)

-- Defina a funcao que eleva um membro ao quadrado
square x = x * x

-- Soma os quadrados de dois numeros.
sumSquares x y = square x + square y

-- Defina uma funcao de alta ordem que aceita uma função (Int -> Int) e aplica a funcao a dois numeros
higherOrderSum f x y = f x + f y

-- Defina a soma dos quadrados em termos de higherOrderSum
hoSumSquares = higherOrderSum square

--Implemente a funcao mapFilter que primeiro aplica o map de uma funcao f a uma lista e depois aplica a funcao filter
-- a lista resultante. Procure usar a composicao de funcoes
mapFilter f p = (filter p).(map f)

-- tests

main = do 
          print (divTuple (4, 2))
          print (somatorio 0 1)
          print (somatorio 1 3)
          print (somatorioRec 1 3)
          print (square 3)
          print (sumSquares 3 4)
          print (higherOrderSum square 1 3)
          print (mapFilter square even [2, 1, 2, 3, 4, 5])