const roman = require("../roman_numerals");

test("Can convert from integer to roman numeral", () => {
  expect(roman.intToRoman(2005)).toBe("MMV");
  expect(roman.intToRoman(1)).toBe("I");
  expect(roman.intToRoman(2)).toBe("II");
  expect(roman.intToRoman(8)).toBe("VIII");
  expect(roman.intToRoman(9)).toBe("IX");
  expect(roman.intToRoman(95)).toBe("XCV");
  expect(roman.intToRoman(2024)).toBe("MMXXIV");
});

test("Can convert from roman numeral to integer", () => {
  expect(roman.romanToInt("MMV")).toBe(2005);
  expect(roman.romanToInt("MM")).toBe(2000);
  expect(roman.romanToInt("MDCLXVI")).toBe(1666);
  expect(roman.romanToInt("CD")).toBe(400);
  expect(roman.romanToInt("XL")).toBe(40);
});
