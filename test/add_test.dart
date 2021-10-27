import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:ticker/ticker.dart';

void main() {
  test('Add Method', () {
    expect(Ticker.createFromDate(year: 1975).add(years: 2).year, 1977);
  });

  group('Add Year', () {
    test('Add Years Positive', () {
      expect(Ticker.createFromDate(year: 1975).addYears(1).year, 1976);
    });

    test('Add Years Zero', () {
      expect(Ticker.createFromDate(year: 1975).addYears(0).year, 1975);
    });

    test('Add Years Negative', () {
      expect(Ticker.createFromDate(year: 1975).addYears(-1).year, 1974);
    });

    test('Add Year', () {
      expect(Ticker.createFromDate(year: 1975).addYear().year, 1976);
    });
  });

  group('Add Days', () {
    test('Add Days Positive', () {
      expect(
        Ticker.createFromDate(year: 1975, month: 5, day: 31).addDays(1).day,
        1,
      );
    });

    test('Add Days Zero', () {
      expect(
        Ticker.createFromDate(year: 1975, month: 5, day: 31).addDays(0).day,
        31,
      );
    });

    test('Add Days Negative', () {
      expect(
        Ticker.createFromDate(year: 1975, month: 5, day: 31).addDays(-1).day,
        30,
      );
    });

    test('Add Day', () {
      expect(
        Ticker.createFromDate(year: 1975, month: 5, day: 31).addDay().day,
        1,
      );
    });
  });

  test('Add Overflow', () {
    expect(
      Ticker('2021-01-31').add(months: 1, overflow: true).format('yyyy-MM-dd'),
      '2021-03-03',
    );

    expect(
      Ticker('2021-01-31').add(months: 1).format('yyyy-MM-dd'),
      '2021-03-03',
    );

    expect(
      Ticker('2021-01-31').add(months: 1, overflow: false).format('yyyy-MM-dd'),
      '2021-02-28',
    );
  });

  group('Add Weekdays', () {
    test('Add Weekdays Positive', () {
      Ticker ticker = Ticker.createFromDate(
        year: 2012,
        month: 1,
        day: 4,
        hour: 13,
        minute: 2,
        second: 1,
      ).addWeekDays(9);

      expect(ticker.day, 17);
      expect(ticker.hour, 13);
      expect(ticker.minute, 2);
      expect(ticker.second, 1);
    });

    test('Add Weekdays Zero', () {
      expect(
        Ticker.createFromDate(
          year: 2012,
          month: 1,
          day: 4,
        ).addWeekDays(0).day,
        4,
      );
    });

    test('Add Weekdays Negative', () {
      expect(
        Ticker.createFromDate(
          year: 2012,
          month: 1,
          day: 31,
        ).addWeekDays(-9).day,
        18,
      );
    });

    test('Add Weekday', () {
      expect(
        Ticker.createFromDate(
          year: 2012,
          month: 1,
          day: 6,
        ).addWeekDay().day,
        9,
      );
    });

    test('Add Weekday During Weekend', () {
      expect(
        Ticker.createFromDate(
          year: 2012,
          month: 1,
          day: 7,
        ).addWeekDay().day,
        9,
      );
    });
  });
}
