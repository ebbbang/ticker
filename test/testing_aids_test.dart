import 'package:test/test.dart';
import 'package:ticker/ticker.dart';

import 'helpers.dart';

void main() {
  setUp(() {
    Ticker.setTestNow();
  });

  test('Testing Aids With Test Now Not Set', () {
    Ticker.setTestNow();

    assertFalse(Ticker.hasTestNow());
    assertNull(Ticker.getTestNow());
  });

  test('Testing Aids With Test Now Set', () {
    Ticker yesterday = Ticker.yesterday();

    Ticker.setTestNow(yesterday);

    assertTrue(Ticker.hasTestNow());
    assertSameTicker(Ticker.getTestNow()!, yesterday);
  });

  test('Testing Aids With Test Now Set To String', () {
    Ticker.setTestNow('2016-11-23');

    assertTrue(Ticker.hasTestNow());
    assertSameTicker(Ticker.parse('2016-11-23'), Ticker.getTestNow()!);
  });
}
