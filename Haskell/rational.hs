--rational.hs
import System.Random (randomRIO)
import System.Random 

data MyRational = Frac Integer Integer

makeRational :: Integer -> Integer -> MyRational
makeRational n d 
    | d == 0 = error "makeRational: denominator can't be 0"
    | otherwise = (Frac n d)

-- Returns the numerator of a rational.
getNum :: MyRational -> Integer
getNum  (Frac n _) = n

-- Returns the denominator of a rational.
getDenom :: MyRational -> Integer
getDenom  (Frac _ d) = d

-- Returns a pair of the numerator and denominator of a MyRational.
pair :: MyRational -> (Integer, Integer)
pair (Frac n d) = (n, d)

-- Implement an instance of the show function that returns the usual string
-- representation of the rational. For instance, 5/3 would be the string
-- "5/3".
instance Show MyRational where 
    show (Frac n d) = (show n) ++ "/" ++ (show d)

-- Convert the fraction to a floating point value Returns the value as the
-- number as a floating point number. For example, 5/2 is 2.5, 1/3 is 0.3333,
-- etc. Hint: use fromIntegral.    
toFloat :: MyRational -> Float
toFloat (Frac n d) = (fromInteger n) / (fromInteger d)   

-- Implement an instance of == that test if two MyRationals are equal. Be
-- careful if either is not in lowest terms!
instance Eq MyRational where 
    (Frac n1 d1) == (Frac n2 d2) = toFloat(Frac n1 d1) == toFloat(Frac n2 d2) 
 
-- Implement an instance of compare x y that tests if the MyRationals x and y
-- are the same (return EQ), or x is less than y (return LT), or x is greater
-- than y (return GT). Be careful with negative values, and when x or y is not
-- in lowest terms!    
instance Ord MyRational where
    (Frac n1 d1) `compare` (Frac n2 d2) = toFloat(Frac n1 d1) `compare` toFloat(Frac n2 d2) 

-- Return True if the given MyRational represents an integer, and False
-- otherwise. For example, 4/1, 21/3, and 0/99 are all integers.   
isInt :: MyRational -> Bool
isInt (Frac n d) = toFloat(Frac n d) == fromInteger(round (toFloat (Frac n d)))

-- Adds two given MyRationals and returns a new MyRational that is there sum.
add :: MyRational -> MyRational -> MyRational
add (Frac n1 d1) (Frac n2 d2) 
    | d1 == d2  = toLowestTerms (Frac (n1 + n2) d1) 
    | otherwise = toLowestTerms (Frac (n1*d2 + n2*d1) (d1*d2)) 

-- Multiplies two given MyRationals and returns a new MyRational that is there
-- product.    
mult :: MyRational -> MyRational -> MyRational
mult (Frac n1 d1) (Frac n2 d2) 
    | n1 == 0 || n2 == 0 = (Frac 0 (d1*d2))
    | otherwise = toLowestTerms (Frac (n1*n2) (d1*d2))

-- Divides two given MyRationals and returns a new MyRational that is there
-- quotient. Call the error function if division by zero would occur.   
divide :: MyRational -> MyRational -> MyRational
divide  (Frac n1 d1) (Frac n2 d2) = toLowestTerms (mult((Frac n1 d1)) (invert(Frac n2 d2)))

-- Inverts a given MyRational and returns a new one with the numerator and
-- denominator switched. For example, 2/3 inverts to 3/2. Call the error
-- function for 0 numerators, e.g. 0/3 inverts to 3/0, which is not a
-- rational.
invert :: MyRational -> MyRational    
invert (Frac n d)  
     | n == 0 = error "invert: denominator can't be 0"
     | otherwise = (Frac d n)

-- Reduces a given MyRational and returns a new MyRational that is in lowest
-- terms. For example, 36/20 reduces to 9/5. Use the gcd function to help do
-- this. Be careful in the case where the numerator or denominator is
-- negative.    
toLowestTerms :: MyRational -> MyRational
toLowestTerms (Frac n d) = (Frac (n `div`  ((toLowestTerms_helper_gcd n) d))) ((d `div`  ((toLowestTerms_helper_gcd n) d)))

toLowestTerms_helper_gcd :: (Integral a) => a -> a -> a
toLowestTerms_helper_gcd x y  =  toLowestTerms_helper_gcd' (abs x) (abs y)
            where toLowestTerms_helper_gcd' a 0  =  a
                  toLowestTerms_helper_gcd' a b  =  toLowestTerms_helper_gcd' b (a `rem` b)

-- Given an integer, return a rational equal to 1/1 + 1/2 + ... + 1/n.                  
harmonicSum :: Integer -> MyRational
harmonicSum n
           | n == 1 = (Frac 1 1)
           | otherwise = add (Frac 1 n) (harmonicSum (n-1))


-- insertionSort 
insertionSort :: Ord a => [a] -> [a]       
insertionSort [] = []
insertionSort [x] = [x]
insertionSort (x:xs) = insert $ insertionSort xs
    where insert [] = [x]
          insert (y:ys)
              | x < y = x : y : ys
              | otherwise = y : insert ys

--generate data 
randomList :: Int -> IO([Int])
randomList 0 = return []
randomList n = do r  <- randomRIO (-65536, 65535)
                  rs <- randomList (n-1)
                  return (r:rs) 

randomListPairs :: Int -> IO([MyRational])
randomListPairs 0 = return []
randomListPairs n = do a <- randomRIO (-65536, 65535)
                       b <- randomRIO (-65536, 65535)
                       ps <- randomListPairs (n-1)
                       return ((Frac a b):ps) 

randomString :: Int -> IO([Char])
randomString 0 = return []
randomString n = do r  <- randomRIO ('!', '~')
                    rs <- randomString (n-1)
                    return (r:rs) 
                    
--main
main = do 
          putStrLn "Here's a list of random numbers:"
          lst <- randomList 1000 --(0.77 secs, 63,301,800 bytes)
        --   lst <- randomList 2000 --(2.06 secs, 241,606,480 bytes)
        --   lst <- randomList 3000 --(3.50 secs, 547,306,344 bytes)
        --   lst <- randomList 4000 --(5.87 secs, 998,581,288 bytes)
        --   lst <- randomList 5000 --(8.35 secs, 1,574,943,384 bytes)
        --   lst <- randomList 6000 --(10.53 secs, 2,254,231,880 bytes)
        --   lst <- randomList 7000 --(13.90 secs, 3,027,769,088 bytes)
        --   lst <- randomList 8000 --(17.65 secs, 3,987,452,544 bytes)
        --   lst <- randomList 9000 --(22.32 secs, 5,030,601,328 bytes)
        --   lst <- randomList 10000 --(26.30 secs, 6,196,867,736 bytes)
        --   putStrLn(show(insertionSort lst))

          putStrLn "Here's a list of random pairs:"
          plst <- randomListPairs 1000 --(2.33 secs, 249,155,432 bytes)
        --   plst <- randomListPairs 2000 --(6.58 secs, 934,373,216 bytes)
        --   plst <- randomListPairs 3000 --(14.74 secs, 2,103,544,360 bytes)
        --   plst <- randomListPairs 4000 --(33.54 secs, 3,615,148,584 bytes)
        --   plst <- randomListPairs 5000 --(34.49 secs, 5,671,370,456 bytes)
        --   plst <- randomListPairs 6000 --(48.63 secs, 8,117,256,520 bytes)
        --   plst <- randomListPairs 7000 --(58.19 secs, 11,109,333,984 bytes)
        --   plst <- randomListPairs 8000 --(75.11 secs, 14,606,346,320 bytes)
        --   plst <- randomListPairs 9000 --(90.36 secs, 18,594,205,512 bytes)
        --   plst <- randomListPairs 10000 --(112.52 secs, 22,677,478,360 bytes)
          putStrLn (show (insertionSort(plst)))


          putStrLn "Here's a list of random string:"
          slst <- randomString 1000 -- (0.36 secs, 54,676,656 bytes)
        --   slst <- randomString 2000 -- (0.93 secs, 230,417,944 bytes)
        --   slst <- randomString 3000 -- (1.93 secs, 535,467,416 bytes)
        --   slst <- randomString 4000 -- (3.20 secs, 966,059,640 bytes)
        --   slst <- randomString 5000 -- (5.15 secs, 1,537,791,480 bytes)
        --   slst <- randomString 6000 -- (7.56 secs, 2,195,711,040 bytes)
        --   slst <- randomString 7000 -- (10.05 secs, 2,999,819,312 bytes)
        --   slst <- randomString 8000 -- (12.43 secs, 3,929,982,816 bytes)
        --   slst <- randomString 9000 -- (15.31 secs, 5,023,754,912 bytes)
        --   slst <- randomString 10000 -- (19.09 secs, 6,190,190,552 bytes)
          putStrLn (show (insertionSort(slst)))
          

{-
:l test.hs
main
let a = makeRational 1 2
let b = makeRational 3 7
let c = makeRational 6 14
let d = makeRational 14 7
let e = makeRational 0 7
getNum b
getDenom b
pair b 
toFloat b 
-}


 
