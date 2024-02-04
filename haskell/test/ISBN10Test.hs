module ISBN10Test where

import ISBN10
import Test.HUnit

testShortString :: Test
testShortString = TestCase (assertEqual "String too short" False (validISBN10 "000"))

testValidString1 :: Test
testValidString1 = TestCase (assertEqual "Valid string 1" True (validISBN10 "1112223339"))

testValidString2 :: Test
testValidString2 = TestCase (assertEqual "Valid string 2" True (validISBN10 "1234554321"))

testValidStringEndingWithX :: Test
testValidStringEndingWithX = TestCase (assertEqual "Valid string with X" True (validISBN10 "048665088X"))

testInvalidChecksum :: Test
testInvalidChecksum = TestCase (assertEqual "Invalid checksum" False (validISBN10 "1234512345"))

testInvalidX :: Test
testInvalidX = TestCase (assertEqual "Invalid X" False (validISBN10 "X123456788"))

isbn10Tests :: Test
isbn10Tests =
  TestList
    [ testShortString,
      testValidString1,
      testValidString2,
      testValidStringEndingWithX,
      testInvalidChecksum,
      testInvalidX
    ]
