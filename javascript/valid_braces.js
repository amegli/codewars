/**
 * @param {string} braces
 * @return {bool}
 */
function areBracesValid([...braces]) {
  const braceMappings = { "}": "{", ")": "(", "]": "[" };

  const braceStack = [];
  return (
    braces.every((brace) => {
      if (["{", "(", "["].includes(brace)) {
        return braceStack.push(brace);
      }
      return braceMappings[brace] === braceStack.pop();
    }) && braceStack.length === 0
  );
}

module.exports = { areBracesValid };
