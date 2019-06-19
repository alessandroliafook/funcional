import Control.Monad (when)    
import System.Exit (exitFailure)
import Test.QuickCheck
import qualified Data.List as DL
import Heap

sorted [] = True
sorted [x] = True
sorted (x:xs)
    | x > (head xs) = False
    | otherwise = sorted xs

prop_sorted xs = sorted (heapSort xs)

prop_idempotent xs = heapSort (heapSort xs) == heapSort xs

prop_key xs = isHeap (fromList xs)

prop_insert xs x = isHeap (insert (fromList xs) x)

prop_remove xs = isHeap (removeRoot (fromList xs))

prop_height xs = not (null xs) ==> let heap = fromList xs in floor (logBase 2 (size heap) + 1.0) == height heap

main :: IO ()
main = do 
    let tests = [ verboseCheckResult (prop_sorted :: [Integer] -> Bool), verboseCheckResult (prop_idempotent :: [Integer] -> Bool), verboseCheckResult (prop_key :: [Integer] -> Bool), verboseCheckResult (prop_insert :: [Integer] -> Integer -> Bool), verboseCheckResult (prop_remove :: [Integer] -> Bool), verboseCheckResult (prop_height :: [Integer] -> Property)]
    success <- fmap (all isSuccess) . sequence $ tests
    when (not success) $ exitFailure