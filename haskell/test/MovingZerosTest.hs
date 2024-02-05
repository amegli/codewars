module MovingZerosTest where

import MovingZeros
import Test.HUnit

test1 :: Test
test1 =
  TestCase
    ( assertEqual
        "Test 1"
        [1, 2, 1, 1, 3, 1, 0, 0, 0, 0]
        (moveZeros [1, 2, 0, 1, 0, 1, 0, 3, 0, 1])
    )

movingZerosTests :: Test
movingZerosTests =
  TestList
    [ test1
    ]
