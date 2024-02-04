module PickPeakTest where

import PickPeak
import Test.HUnit

testMultiplePeaks :: Test
testMultiplePeaks =
  TestCase
    ( assertEqual
        "Test 1"
        PickedPeaks {pos = [3, 7], peaks = [6, 3]}
        (pickPeaks [3, 2, 3, 6, 4, 1, 2, 3, 2, 1, 2, 3])
    )

testPlateau :: Test
testPlateau =
  TestCase
    ( assertEqual
        "Test Plateau"
        PickedPeaks {pos = [1], peaks = [2]}
        (pickPeaks [1, 2, 2, 2, 1])
    )

testEmptyList :: Test
testEmptyList =
  TestCase
    ( assertEqual
        "Test empty list"
        PickedPeaks {pos = [], peaks = []}
        (pickPeaks [])
    )

testNoPeaks :: Test
testNoPeaks =
  TestCase
    ( assertEqual
        "Test no peaks"
        PickedPeaks {pos = [], peaks = []}
        (pickPeaks [2, 2, 2, 2, 2, 3])
    )

pickPeakTests :: Test
pickPeakTests =
  TestList
    [ testMultiplePeaks,
      testPlateau,
      testEmptyList,
      testNoPeaks
    ]
