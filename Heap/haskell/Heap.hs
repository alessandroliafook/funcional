module Heap (
    Heap(..),
    insert,
    removeRoot,
    getRoot,
    value,
    left,
    right
    ) where

data Heap a = NIL | Node a (Heap a) (Heap a) Bool deriving (Eq,Show)

value NIL = error "Cannot get value from a NIL Heap Node"
value (Node key _ _ _) = key

left NIL = NIL
left (Node _ left_node _ _) = left_node

right NIL = NIL
right (Node _ _ right_node _) = right_node

lastPut NIL = error "Cannot get last_put from a NIL Heap Node"
lastPut (Node _ _ _ last_put) = last_put

getLast (Node key NIL NIL False) = key
getLast (Node key left right last_put)
    | last_put == False = getLast right 
    | otherwise = getLast left 

getBestChild NIL right = right
getBestChild left NIL = left
getBestChild left right 
    | (value left) < (value right) = left
    | otherwise = right

insert NIL value = (Node value (NIL) (NIL) False)
insert (Node key left right last_put) value
    | last_put == False = (
        \(Node c_key c_left c_right c_last_put) -> 
            if c_key < key 
                then (Node c_key (Node key c_left c_right c_last_put) right True)
                else (Node key (Node c_key c_left c_right c_last_put) right True)
        ) (insert left value)
    | otherwise = (
        \(Node c_key c_left c_right c_last_put) ->
            if c_key < key
                then (Node c_key left (Node key c_left c_right c_last_put) False)
                else (Node key left (Node c_key c_left c_right c_last_put) False)
        ) (insert right value)

rollback (Node key NIL NIL False) = NIL
rollback (Node key left right last_put) 
    | last_put == False = (Node key left (rollback right) True)
    | otherwise = (Node key (rollback left) right False)

forwardHeapify (Node key NIL NIL last_put) = (Node key NIL NIL last_put)
forwardHeapify (Node key left right last_put)
    | child == left = (
        \(Node c_key c_left c_right c_last_put) ->
            if c_key < key
                then (Node c_key (forwardHeapify (Node key c_left c_right c_last_put)) right last_put)
                else (Node key (forwardHeapify (Node c_key c_left c_right c_last_put)) right last_put)
        ) child
    | otherwise = (
        \(Node c_key c_left c_right c_last_put) ->
            if c_key < key
                then (Node c_key left (forwardHeapify (Node key c_left c_right c_last_put)) last_put)
                else (Node key left (forwardHeapify (Node c_key c_left c_right c_last_put)) last_put)
        ) child
    where
        child = getBestChild left right

removeRoot NIL = NIL
removeRoot root 
    | new_root == NIL = NIL
    | otherwise = forwardHeapify (Node new_root_key (left new_root) (right new_root) (lastPut new_root))
    where 
        new_root_key = getLast root
        new_root = rollback root

getRoot heap = value heap