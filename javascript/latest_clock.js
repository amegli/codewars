/**
 * https://www.codewars.com/kata/58925dcb71f43f30cd00005f/train/javascript
 *
 * @param {number} a
 * @param {number} b
 * @param {number} c
 * @param {number} d
 * @return {string}
 */
function latestClock(a, b, c, d) {
  const digits = [a, b, c, d].sort().reverse();

  const findAndRemove = (max) =>
    digits
      .splice(
        digits.findIndex((digit) => digit <= max),
        1,
      )
      .at(0);

  const fiveOrLess = digits.filter((digit) => digit <= 5);
  const firstDigit = findAndRemove(fiveOrLess.length <= 2 ? 1 : 2);
  const secondDigit = findAndRemove(firstDigit === 2 ? 3 : 9);
  const thirdDigit = findAndRemove(5);
  const fourthDigit = digits.pop();

  return `${firstDigit}${secondDigit}:${thirdDigit}${fourthDigit}`;
}

module.exports = { latestClock };
