import 'package:test/test.dart';
import 'package:ticker/ticker.dart';

void main() {
  test('now', () {
    Ticker t = Ticker.now();

    expect(DateTime.now().millisecondsSinceEpoch, t.millisecondsSinceEpoch);

    Ticker.setTestNow();
  });
}
