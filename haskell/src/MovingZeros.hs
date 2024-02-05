-- https://www.codewars.com/kata/52597aa56021e91c93000cb0
module MovingZeros (moveZeros) where

import Data.List

moveZeros :: [Int] -> [Int]
moveZeros xs = uncurry (++) $ partition (/= 0) xs
