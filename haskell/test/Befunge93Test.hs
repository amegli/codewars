module Befunge93Test where

import Befunge93
import System.Random (newStdGen)
import Test.HUnit

testBasics :: Test
testBasics =
  TestCase
    ( do
        g <- newStdGen
        assertEqual
          "Basic operations - pop and discard"
          (interpret g "123.$.@")
          "31"
        assertEqual
          "Basic operations - swap values"
          (interpret g "123\\...@")
          "231"
        assertEqual
          "Basic operations - greater than"
          (interpret g "65`.@")
          "1"
        assertEqual
          "Basic operations - greater than"
          (interpret g "25`.@")
          "0"
        assertEqual
          "Basic operations - math"
          (interpret g "99*76*+.@")
          "123"
        assertEqual
          "Basic operations - bridge"
          (interpret g ">123#...@")
          "32"
    )

testFactorial :: Test
testFactorial =
  TestCase
    ( do
        g <- newStdGen
        assertEqual
          "Factorial"
          ( interpret g $
              concat
                [ "08>:1-:v v *_$.@ \n",
                  "  ^    _$>\\:^"
                ]
          )
          "40320"
    )

testOutputCode :: Test
testOutputCode =
  TestCase
    ( do
        g <- newStdGen
        assertEqual
          "Output code"
          (interpret g "01->1# +# :# 0# g# ,# :# 5# 8# *# 4# +# -# _@")
          "01->1# +# :# 0# g# ,# :# 5# 8# *# 4# +# -# _@"
    )

testHelloWorld :: Test
testHelloWorld =
  TestCase
    ( do
        g <- newStdGen
        assertEqual
          "Hello World"
          ( interpret g $
              concat
                [ ">25*\"!dlroW olleH\":v\n",
                  "                v:,_@\n",
                  "                >  ^"
                ]
          )
          "Hello World!\n"
    )

testEratosthenes :: Test
testEratosthenes =
  TestCase
    ( do
        g <- newStdGen
        assertEqual
          "Eratosthenes"
          ( interpret g $
              concat
                [ "2>:3g\" \"-!v\\  g30          <\n",
                  " |!`\"&\":+1_:.:03p>03g+:\"&\"`|\n",
                  " @               ^  p3\\\" \":<\n",
                  "2 2345678901234567890123456789012345678"
                ]
          )
          "23571113171923293137"
    )

befunge93Tests :: Test
befunge93Tests =
  TestList
    [ testBasics,
      testFactorial,
      testOutputCode,
      testHelloWorld,
      testEratosthenes
    ]
