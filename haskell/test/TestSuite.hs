import Befunge93Test
import ISBN10Test
import MovingZerosTest
import PickPeakTest
import System.Exit
import Test.HUnit
import TheLostBeginningTest

main :: IO ()
main = do
  (Counts _ _ errors failures) <-
    runTestTT $
      TestList
        [ isbn10Tests,
          pickPeakTests,
          movingZerosTests,
          lostBeginningTests,
          befunge93Tests
        ]
  if errors > 0 || failures > 0
    then exitFailure
    else exitSuccess
