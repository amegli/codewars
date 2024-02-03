const braces = require("../valid_braces");

test("Kata tests", () => {
  expect(braces.areBracesValid("(){}[]")).toBe(true);
  expect(braces.areBracesValid("([{}])")).toBe(true);
  expect(braces.areBracesValid("(}")).toBe(false);
  expect(braces.areBracesValid("[(])")).toBe(false);
  expect(braces.areBracesValid("[({})](]")).toBe(false);
  expect(braces.areBracesValid("()))")).toBe(false);
  expect(braces.areBracesValid("()")).toBe(true);
  expect(braces.areBracesValid("[]")).toBe(true);
  expect(braces.areBracesValid("{}")).toBe(true);
  expect(braces.areBracesValid("(((({{")).toBe(false);
});
