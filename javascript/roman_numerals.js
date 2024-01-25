/**
 * @param {string} roman
 * @return {number}
 */
function romanToInt(roman) {
  const letterValues = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };

  return roman
    .split("")
    .reverse()
    .map((letter) => letterValues[letter])
    .reduce((total, value, index, allValues) =>
      allValues[index - 1] > value ? total - value : total + value,
    );
}

/**
 * @param {number} number
 * @return {string}
 */
function intToRoman(number) {
  if (number < 1) {
    return "";
  }

  const letterValues = {
    I: 1,
    IV: 4,
    V: 5,
    IX: 9,
    X: 10,
    XL: 40,
    L: 50,
    XC: 90,
    C: 100,
    CD: 400,
    D: 500,
    CM: 900,
    M: 1000,
  };

  const nextLetter = Object.keys(letterValues)
    .reverse()
    .find((letter) => number / letterValues[letter] >= 1);

  const numberOfLetters = Math.floor(number / letterValues[nextLetter]);
  const remainingAmount = number - numberOfLetters * letterValues[nextLetter];

  return nextLetter.repeat(numberOfLetters).concat(intToRoman(remainingAmount));
}

module.exports = { intToRoman, romanToInt };
