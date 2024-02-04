module ISBN10 where

import Data.Char (digitToInt)

validISBN10 :: String -> Bool
validISBN10 isbn
  | length isbn < 10 = False
  | lastCharacterInvalid || preceedingCharactersInvalid = False
  | positionalSum == 0 = False
  | otherwise = (positionalSum `mod` 11) == 0
  where
    lastCharacterInvalid = last isbn `notElem` ('X' : ['0' .. '9'])
    preceedingCharactersInvalid = any (`notElem` ['0' .. '9']) (init isbn)
    values = case last isbn of
      'X' -> map digitToInt (init isbn) ++ [10]
      _ -> map digitToInt isbn
    positionalSum = sum (zipWith (*) [1 ..] values)
