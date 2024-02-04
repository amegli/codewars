import ISBN10Test
import PickPeakTest
import System.Exit
import Test.HUnit

main :: IO ()
main = do
  (Counts _ _ errors failures) <- runTestTT $ TestList [isbn10Tests, pickPeakTests]
  if errors > 0 || failures > 0
    then exitFailure
    else exitSuccess
