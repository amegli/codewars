/**
 * https://www.codewars.com/kata/5279f6fe5ab7f447890006a7
 *
 * @param {number[]} values
 * @return {{pos: number[], peaks, number[]}}
 */
function pickPeaks(values) {
  const peakFinder = ([x, y, z, ...tail]) => {
    if (!z) {
      return [];
    }

    if (x.value < y.value && y.value > z.value) {
      return [y, ...peakFinder([z, ...tail])];
    }
    if (x.value < y.value && y.value === z.value) {
      return peakFinder([x, y, ...tail]);
    }
    return peakFinder([y, z, ...tail]);
  };

  const peaks = peakFinder(
    values.map((value, index) => ({ value: value, index: index })),
  );

  return {
    pos: peaks.map((peak) => peak.index),
    peaks: peaks.map((peak) => peak.value),
  };
}

module.exports = { pickPeaks };
