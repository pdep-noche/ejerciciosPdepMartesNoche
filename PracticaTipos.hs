
p :: (a -> Bool) -> [a] -> a 
p n = (head . filter n)

f :: (Ord b)  => ( a -> b ) -> [( a , a )] -> Bool
f x y = (x.fst.head) y > (x.snd.head) y

g  :: (Eq t) =>  ( x -> t ) ->  x  ->  x  -> Bool
g f a b = f a == f b 


h :: (Eq t) =>  t -> [(x,t,s)]  -> (x,t,s)
h nom  = head.filter ((nom==).g1)

g1 :: (h, a, f) -> a
g1 (_, c, _) = c

f2 :: (Ord s, Num s, Num t) =>  t -> (t -> s)  -> [t]   -> t
f2 x _ [] = x
f2 x y (z:zs)  | y z > 0 = z + f2 x y zs
               | otherwise = f2 x y zs

f3 :: (Ord t) => t  -> (t  -> h ) -> [t]  -> h   
f3 a b (c:cs) | a > c = f3 a b cs
              | otherwise = b c

f4 :: (Num g ) =>  (f -> Bool ) -> t -> [t]-> (Int ->(g , Bool) -> f )-> Int -> Int
f4 a b c d e | (a . d e) (1, True) = 0
             | otherwise = length (b:c) + e

g2 :: (Eq t) => (a -> t ) ->  t -> [a] -> a
g2 f x l = (head . filter ((x==).f)) l

qfsort :: (Ord h)  => (t  -> h) ->  [t] ->  [t]
qfsort f [ ] = [ ]
qfsort f (x:xs) = (qfsort f (filter ((> f x).f) xs)) ++ [x] ++ (qfsort f (filter ((< f x).f) xs))

floca :: (Num t) => (a -> Bool) -> (t -> a ) -> t -> [t] 
floca g f n | (g . f ) n = n : floca g f (n + 1)
            | otherwise = floca g f (n + 1)
