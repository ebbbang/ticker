import 'package:test/test.dart';
import 'package:ticker/ticker.dart';

void assertTicker(
  Ticker ticker,
  int year,
  int month,
  int day, [
  int? hour,
  int? minute,
  int? second,
  int? millisecond,
  int? microsecond,
]) {
  Map expected = {'year': year, 'month': month, 'day': day};

  Map actual = {'year': ticker.year, 'month': ticker.month, 'day': ticker.day};

  if (hour != null) {
    expected['hour'] = ticker.hour;
  }

  if (minute != null) {
    expected['minute'] = ticker.minute;
  }

  if (second != null) {
    expected['second'] = ticker.second;
  }

  if (millisecond != null) {
    expected['millisecond'] = ticker.millisecond;
  }

  if (microsecond != null) {
    expected['microsecond'] = ticker.microsecond;
  }

  expect(actual, expected);
}

void assertTrue(var actual) {
  expect(actual, true);
}
