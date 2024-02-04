const clock = require("../latest_clock");

test("Basic tests", () => {
  expect(clock.latestClock(1, 9, 8, 3)).toBe("19:38");
  expect(clock.latestClock(9, 1, 2, 5)).toBe("21:59");
  expect(clock.latestClock(1, 2, 8, 9)).toBe("19:28");
  expect(clock.latestClock(0, 0, 0, 0)).toBe("00:00");
  expect(clock.latestClock(2, 4, 0, 0)).toBe("20:40");
  expect(clock.latestClock(9, 0, 5, 9)).toBe("09:59");
});
