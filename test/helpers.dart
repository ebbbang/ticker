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
  Map expected = {
    'year': year,
    'month': month,
    'day': day,
  };

  Map actual = {
    'year': ticker.year,
    'month': ticker.month,
    'day': ticker.day,
  };

  if (hour != null) {
    expected['hour'] = hour;
    actual['hour'] = ticker.hour;
  }

  if (minute != null) {
    expected['minute'] = minute;
    actual['minute'] = ticker.minute;
  }

  if (second != null) {
    expected['second'] = second;
    actual['second'] = ticker.second;
  }

  if (millisecond != null) {
    expected['millisecond'] = millisecond;
    actual['millisecond'] = ticker.millisecond;
  }

  expect(actual, expected);
}

void assertSameTicker(Ticker ticker1, Ticker ticker2) {
  expect(
    {
      'year': ticker1.year,
      'month': ticker1.month,
      'day': ticker1.day,
      'hour': ticker1.hour,
      'minute': ticker1.minute,
      'second': ticker1.second,
      'millisecond': ticker1.millisecond,
    },
    {
      'year': ticker2.year,
      'month': ticker2.month,
      'day': ticker2.day,
      'hour': ticker2.hour,
      'minute': ticker2.minute,
      'second': ticker2.second,
      'millisecond': ticker2.millisecond,
    },
  );
}

void assertTrue(var actual) {
  expect(actual, true);
}

void assertFalse(var actual) {
  expect(actual, false);
}

void assertNull(var actual) {
  expect(actual, null);
}
