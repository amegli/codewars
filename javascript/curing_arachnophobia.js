/**
 * @param {number} legSize
 * @param {number} bodySize
 * @param {string} mouth
 * @param {string} eye
 *
 * @return {string}
 */
function drawSpider(legSize, bodySize, mouth, eye) {
  const LEG_SIZES = {
    1: { left: "^", right: "^" },
    2: { left: "/\\", right: "/\\" },
    3: { left: "/╲", right: "╱\\" },
    4: { left: "╱╲", right: "╱╲" },
  };

  const BODY_SIZES = {
    1: { left: "(", right: ")" },
    2: { left: "((", right: "))" },
    3: { left: "(((", right: ")))" },
  };

  const aSideOfEyes = eye.repeat(2 ** bodySize / 2);

  return [
    LEG_SIZES[legSize].left,
    BODY_SIZES[bodySize].left,
    aSideOfEyes,
    mouth,
    aSideOfEyes,
    BODY_SIZES[bodySize].right,
    LEG_SIZES[legSize].right,
  ].join("");
}
