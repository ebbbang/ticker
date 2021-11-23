import 'package:test/test.dart';
import 'package:ticker/ticker.dart';

import 'helpers.dart';

void main() {
  test('Creates An Instance Default To Now', () {
    Ticker t = new Ticker();
    Ticker now = Ticker.now();

    expect(t.runtimeType, now.runtimeType);
    assertSameTicker(t, now);
    assertTicker(
      t,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
  });

  test('Creates An Instance From A Date Time', () {
    Ticker t1 = new Ticker(Ticker.parse('2009-09-09 09:09:09'));

    expect(t1.format('y-MM-dd HH:mm:ss'), '2009-09-09 09:09:09');

    Ticker t2 = new Ticker(DateTime.parse('2009-09-09 09:09:09'));

    expect(t2.format('y-MM-dd HH:mm:ss'), '2009-09-09 09:09:09');
  });
}
