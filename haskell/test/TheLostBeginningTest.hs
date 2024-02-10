module TheLostBeginningTest where

import Test.HUnit
import TheLostBeginning

test1 :: Test
test1 = TestCase (assertEqual "Test 1" 9 (beginning "91011"))

test2 :: Test
test2 = TestCase (assertEqual "Test 1" 101 (beginning "101"))

test3 :: Test
test3 = TestCase (assertEqual "Test 1" 17 (beginning "17181920"))

lostBeginningTests :: Test
lostBeginningTests = TestList [test1, test2, test3]
