-- https://www.codewars.com/kata/526c7b931666d07889000a3c/solutions/haskell

module Befunge93 where

import Data.Char
import Data.Maybe
import qualified Data.Vector as V
import System.Random

data Direction
  = Upward
  | Downward
  | Forward
  | Backward
  deriving (Eq, Ord, Show, Read, Enum)

data Position = Position {x :: Int, y :: Int} deriving (Eq, Show)

data ReadMode = ASCII_MODE | INT_MODE deriving (Eq, Ord, Show, Read)

type Grid = V.Vector (V.Vector Char)

type Stack = [Int]

type Output = [Char]

data ProgramState = ProgramState
  { direction :: Direction,
    position :: Position,
    grid :: Grid,
    mode :: ReadMode,
    stack :: Stack,
    output :: Output,
    rando :: StdGen
  }
  deriving (Show)

generateGrid :: String -> Grid
generateGrid program = V.fromList $ take 25 $ map rowMaker $ lines (program ++ replicate 25 '\n')
  where
    rowMaker row = V.fromList $ take 80 (row ++ replicate 80 ' ')

updateGrid :: Grid -> Position -> Char -> Grid
updateGrid grid (Position x y) value = grid'
  where
    row = grid V.! y
    grid' = grid V.// [(y, row V.// [(x, value)])]

readCell :: Grid -> Position -> Char
readCell grid (Position x y) = case grid V.!? y of
  Just row -> fromMaybe ' ' (row V.!? x)
  Nothing -> ' '

moveHead :: ProgramState -> ProgramState
moveHead state@(ProgramState {position = pos, direction = dir})
  | dir == Upward = state {position = Position (x pos) (y pos - 1)}
  | dir == Downward = state {position = Position (x pos) (y pos + 1)}
  | dir == Forward = state {position = Position (x pos + 1) (y pos)}
  | dir == Backward = state {position = Position (x pos - 1) (y pos)}

randomizeDirection :: StdGen -> (Direction, StdGen)
randomizeDirection rando =
  let (index, rando') = randomR (0, 3) rando
      direction = toEnum index :: Direction
   in (direction, rando')

division :: Stack -> Stack
division (x : y : xs)
  | x == 0 = 0 : xs
  | otherwise = (x `div` y) : xs

modulus :: Stack -> Stack
modulus (x : y : xs)
  | x == 0 = 0 : xs
  | otherwise = (x `mod` y) : xs

greaterThan :: Stack -> Stack
greaterThan (x : y : xs)
  | x < y = 1 : xs
  | otherwise = 0 : xs

duplicate :: Stack -> Stack
duplicate [] = [0]
duplicate (x : xs) = x : x : xs

swap :: Stack -> Stack
swap [x] = [0, x]
swap (x : y : xs) = y : x : xs

addToStack :: Char -> ReadMode -> Stack -> Stack
addToStack ' ' INT_MODE stack = stack
addToStack c INT_MODE stack = digitToInt c : stack
addToStack c ASCII_MODE stack = ord c : stack

popInteger :: ProgramState -> ProgramState
popInteger state@(ProgramState {stack = stack, output = output}) =
  state
    { output = output ++ show (head stack),
      stack = tail stack
    }

popAscii :: ProgramState -> ProgramState
popAscii state@(ProgramState {stack = stack, output = output}) =
  state {output = output ++ [chr (head stack)], stack = tail stack}

put :: ProgramState -> ProgramState
put state@(ProgramState {grid = grid, stack = (y : x : v : xs)}) =
  state {grid = grid', stack = xs}
  where
    grid' = updateGrid grid (Position x y) (chr v)

get :: ProgramState -> ProgramState
get state@(ProgramState {grid = grid, stack = (y : x : xs)}) =
  state {stack = addToStack (readCell grid (Position x y)) ASCII_MODE xs}

horizontalCondition :: ProgramState -> ProgramState
horizontalCondition state@(ProgramState {stack = stack}) = state {stack = stack', direction = direction'}
  where
    stack' = tail stack
    direction' = if head stack == 0 then Forward else Backward

verticalCondition :: ProgramState -> ProgramState
verticalCondition state@(ProgramState {stack = stack}) = state {stack = stack', direction = direction'}
  where
    stack' = tail stack
    direction' = if head stack == 0 then Downward else Upward

executeInstruction :: Char -> ProgramState -> ProgramState
executeInstruction instruction state@(ProgramState {stack = stack, mode = ASCII_MODE})
  | instruction == '"' = state {mode = INT_MODE}
  | otherwise = state {stack = addToStack instruction ASCII_MODE stack}
executeInstruction instruction state@(ProgramState {stack = stack, rando = rando})
  | instruction == '#' = moveHead state
  | instruction == '$' = state {stack = tail stack}
  | instruction == '^' = state {direction = Upward}
  | instruction == 'v' = state {direction = Downward}
  | instruction == '>' = state {direction = Forward}
  | instruction == '<' = state {direction = Backward}
  | instruction == '"' = state {mode = ASCII_MODE}
  | instruction == '+' = state {stack = sum (take 2 stack) : drop 2 stack}
  | instruction == '-' = state {stack = foldr1 (-) (reverse $ take 2 stack) : drop 2 stack}
  | instruction == '*' = state {stack = product (take 2 stack) : drop 2 stack}
  | instruction == '/' = state {stack = division stack}
  | instruction == '%' = state {stack = modulus stack}
  | instruction == '!' = state {stack = (if head stack == 0 then 1 else 0) : tail stack}
  | instruction == '`' = state {stack = greaterThan stack}
  | instruction == ':' = state {stack = duplicate stack}
  | instruction == '\\' = state {stack = swap stack}
  | instruction == '.' = popInteger state
  | instruction == ',' = popAscii state
  | instruction == 'p' = put state
  | instruction == 'g' = get state
  | instruction == '_' = horizontalCondition state
  | instruction == '|' = verticalCondition state
  | instruction == '?' =
      let (direction', rando') = randomizeDirection rando
       in state {direction = direction', rando = rando'}
  | otherwise = state {stack = addToStack instruction INT_MODE stack}

executeInstructions :: ProgramState -> String
executeInstructions state@(ProgramState {grid = grid, position = position, output = output})
  | instruction == '@' = output
  | otherwise = executeInstructions $ moveHead $ executeInstruction instruction state
  where
    instruction = readCell grid position

interpret :: StdGen -> String -> String
interpret gen program =
  executeInstructions
    ProgramState
      { direction = Forward,
        position = Position 0 0,
        mode = INT_MODE,
        grid = generateGrid program,
        stack = [],
        output = [],
        rando = gen
      }
