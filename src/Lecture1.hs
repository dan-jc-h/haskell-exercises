{- |
Module                  : Lecture1
Copyright               : (c) 2021-2022 Haskell Beginners 2022 Course
SPDX-License-Identifier : MPL-2.0
Maintainer              : Haskell Beginners 2022 Course <haskell.beginners2022@gmail.com>
Stability               : Stable
Portability             : Portable

Exercises for the Lecture 1 of the Haskell Beginners course.

To complete exercises, you need to complete implementation and add
missing top-level type signatures. You can implement any additional
helper functions. But you can't change the names of the given
functions.

Comments before each function contain explanations and example of
arguments and expected returned values.

It's absolutely okay if you feel that your implementations are not
perfect. You can return to these exercises after future lectures and
improve your solutions if you see any possible improvements.
-}

module Lecture1
    ( makeSnippet
    , sumOfSquares
    , lastDigit
    , minmax
    , subString
    , strSum
    , lowerAndGreater
    ) where

-- VVV If you need to import libraries, do it after this line ... VVV

-- ^^^ and before this line. Otherwise the test suite might fail  ^^^

{- | Specify the type signature of the following function. Think about
its behaviour, possible types for the function arguments and write the
type signature explicitly.
-}
makeSnippet :: Int -> String -> String
makeSnippet limit text = take limit ("Description: " ++ text) ++ "..."

{- | Implement a function that takes two numbers and finds sum of
their squares.

>>> sumOfSquares 3 4
25

>>> sumOfSquares (-2) 7
53

Explanation: @sumOfSquares 3 4@ should be equal to @9 + 16@ and this
is 25.
-}

sumOfSquares :: Int -> Int -> Int
sumOfSquares x y = x * x + y * y

{- | Implement a function that returns the last digit of a given number.

>>> lastDigit 42
2
>>> lastDigit (-17)
7

🕯 HINT: use the @mod@ function

-}

lastDigit :: Int -> Int
lastDigit n = (abs n) `mod` 10

{- | Write a function that takes three numbers and returns the
difference between the biggest number and the smallest one.

>>> minmax 7 1 4
6

Explanation: @minmax 7 1 4@ returns 6 because 7 is the biggest number
and 1 is the smallest, and 7 - 1 = 6.

Try to use local variables (either let-in or where) to implement this
function.
-}

minmax :: Int -> Int -> Int -> Int

-- this works, below is are versions using let and where, 
-- as suggested in the instructions

{--}
minmax x y z = (maximum [x,y,z]) - (minimum [x,y,z])
--}

-- implementation with let
{--
minmax x y z = 
    let 
        max3 a b c = if a>b && a>c then a else if b>a && b>c then b else c
        min3 a b c = if a<b && a<c then a else if b<a && b<c then b else c
    in (max3 x y z) - (min3 x y z)
--}

-- implementation with where
{--
minmax x y z = (max3 x y z) - (min3 x y z)
    where
        max3 a b c = if a>b && a>c then a else if b>a && b>c then b else c
        min3 a b c = if a<b && a<c then a else if b<a && b<c then b else c
--}


{- | Implement a function that takes a string, start and end positions
and returns a substring of a given string from the start position to
the end (including).

>>> subString 3 7 "Hello, world!"
"lo, w"

>>> subString 10 5 "Some very long String"
""

This function can accept negative start and end position. Negative
start position can be considered as zero (e.g. substring from the
first character) and negative end position should result in an empty
string.
-}
subString :: Int -> Int -> String -> String
subString start end str = take (eend + 1 - sstart) (drop sstart str)
    where   sstart = max start 0
            eend = if end < 0 then sstart - 1  else end

{- | Write a function that takes a String — space separated numbers,
and finds a sum of the numbers inside this string.

>>> strSum "100    -42  15"
73

The string contains only spaces and/or numbers.
-}
strSum :: String -> Int
strSum str = sum (map (\ n -> read n :: Int) (words str))

{- | Write a function that takes a number and a list of numbers and
returns a string, saying how many elements of the list are strictly
greater than the given number and strictly lower.

>>> lowerAndGreater 3 [1 .. 9]
"3 is greater than 2 elements and lower than 6 elements"

Explanation: the list [1 .. 9] contains 9 elements: [1, 2, 3, 4, 5, 6, 7, 8, 9]
The given number 3 is greater than 2 elements (1 and 2)
and lower than 6 elements (4, 5, 6, 7, 8 and 9).

🕯 HINT: Use recursion to implement this function.
-}


lowerAndGreater :: Int -> [Int] -> String

-- My implementation is not (explicitly recursive), I did a recursive version below

{--}
lowerAndGreater n list = show n ++ " is greater than " ++ show nGreater ++ " elements and lower than " ++ show nLower ++ " elements"
    where
        nGreater = length $ filter (<n) list
        nLower   = length $ filter (>n) list
--}

{--
lowerAndGreater n list = show n ++ " is greater than " ++ show (nGreater n list) ++ " elements and lower than " ++ show (nLower n list) ++ " elements"
    where
        nGreater _ [] = 0
        nGreater n (x:xs) = if n > x then 1 + nGreater n xs else nGreater n xs 
        nLower _ [] = 0
        nLower n (x:xs) = if n < x then 1 + nLower n xs else nLower n xs 
--}