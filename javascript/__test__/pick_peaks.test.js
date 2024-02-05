const Peaks = require("../pick_peaks");

test("Basic tests", () => {
  expect(Peaks.pickPeaks([3, 2, 3, 6, 4, 1, 2, 3, 2, 1, 2, 3])).toEqual({
    pos: [3, 7],
    peaks: [6, 3],
  });
  expect(Peaks.pickPeaks([1, 2, 2, 2, 1])).toEqual({
    pos: [1],
    peaks: [2],
  });
  expect(Peaks.pickPeaks([])).toEqual({
    pos: [],
    peaks: [],
  });
  expect(Peaks.pickPeaks([2, 2, 2, 2, 2, 3])).toEqual({
    pos: [],
    peaks: [],
  });
});
