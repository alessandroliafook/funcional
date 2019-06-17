import Control.Monad (when)    
import System.Exit (exitFailure)
import Test.QuickCheck (quickCheckResult)
import Test.QuickCheck.Test (isSuccess)
import qualified Data.List as DL
import Heap

sorted [] = True
sorted [x] = True
sorted (x:xs)
    | x > (head xs) = False
    | otherwise = sorted xs

prop_sorted xs = sorted (heapSort xs)

prop_idempotent xs = heapSort (heapSort xs) == heapSort xs

isHeap NIL = True
isHeap (Node key NIL NIL _) = True
isHeap (Node key left NIL _) = (key < (value left)) && (isHeap left)
isHeap (Node key NIL right _) = (key < (value right)) && (isHeap right)
isHeap (Node key left right _) = (key < (value left)) && (key < (value right)) && (isHeap left) && (isHeap right)

prop_key xs = isHeap (fromList xs)

prop_insert xs x = isHeap (insert (fromList xs) x)

prop_remove xs = isHeap (removeRoot (fromList xs))

main :: IO ()
main = do 
    let tests = [ quickCheckResult (prop_sorted :: [Integer] -> Bool), quickCheckResult (prop_idempotent :: [Integer] -> Bool),quickCheckResult (prop_key :: [Integer] -> Bool), quickCheckResult (prop_insert :: [Integer] -> Integer -> Bool), quickCheckResult (prop_remove :: [Integer] -> Bool)]
    success <- fmap (all isSuccess) . sequence $ tests
    when (not success) $ exitFailure