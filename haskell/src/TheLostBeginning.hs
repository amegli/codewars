-- https://www.codewars.com/kata/659af96994b858db10e1675f

module TheLostBeginning (beginning) where

import Data.List

beginning :: String -> Int
beginning numString = head $ filter consecTest firstDigits
  where
    firstDigits = map read $ tail $ inits numString
    consecTest start =
      numString
        `elem` takeWhile
          (\x -> length x <= length numString)
          (scanl1 (++) (map show [start ..]))
