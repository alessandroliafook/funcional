module Heap () where

data Heap a = NIL | Node a (Heap a) (Heap a) Bool deriving (Eq,Show)

value NIL = error "Cannot get value from a NIL Heap Node"
value (Node key _ _ _) = key

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

