module PickPeak where

data PickedPeaks = PickedPeaks {pos :: [Int], peaks :: [Int]} deriving (Eq, Show)

pickPeaks :: [Int] -> PickedPeaks
pickPeaks xs = PickedPeaks {pos = snd peaksAndPositions, peaks = fst peaksAndPositions}
  where
    peaksAndPositions = unzip $ pickPeaks' $ zip xs [0 ..]

pickPeaks' :: [(Int, Int)] -> [(Int, Int)]
pickPeaks' ((x, xpos) : (y, ypos) : (z, zpos) : xs)
  | x < y && y > z = (y, ypos) : pickPeaks' ((z, zpos) : xs)
  | x < y && y == z = pickPeaks' ((x, xpos) : (y, ypos) : xs)
  | otherwise = pickPeaks' ((y, ypos) : (z, zpos) : xs)
pickPeaks' _ = []
