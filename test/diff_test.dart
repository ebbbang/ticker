import 'package:test/test.dart';
import 'package:ticker/ticker.dart';

void main() {
  late Ticker ticker;

  setUp(() {
    ticker = Ticker.createFromDate(year: 2000, month: 1, day: 1);
  });

  group('Diff In Years', () {
    test('Diff In Years Positive', () {
      expect(ticker.diffInYears(ticker.copy().addYear()), 1);
    });

    test('Diff In Years Negative With Sign', () {
      expect(ticker.diffInYears(ticker.copy().subYear(), false), -1);
    });

    test('Diff In Years Negative No Sign', () {
      expect(ticker.diffInYears(ticker.copy().subYear()), 1);
    });

    test('Diff In Years Vs Default Now', () {
      expect(Ticker.now().subYear().diffInYears(), 1);
    });

    test('Diff In Years Ensure Is Truncated', () {
      expect(ticker.diffInYears(ticker.copy().addYear().addMonths(7)), 1);
    });
  });

  group('Diff In Quarters', () {
    test('Diff In Quarters Positive', () {
      expect(ticker.diffInQuarters(ticker.copy().addQuarter().addDay()), 1);
    });

    test('Diff In Quarters Negative With Sign', () {
      expect(ticker.diffInQuarters(ticker.copy().subQuarters(4), false), -4);
    });

    test('Diff In Quarters Negative With No Sign', () {
      expect(ticker.diffInQuarters(ticker.copy().subQuarters(4)), 4);
    });

    test('Diff In Quarters Vs Default Now', () {
      expect(Ticker.now().subYear().diffInQuarters(), 4);
    });

    test('Diff In Quarters Ensure Is Truncated', () {
      expect(ticker.diffInQuarters(ticker.copy().addQuarter().addDays(12)), 1);
    });
  });

  group('Diff In Months', () {
    test('Diff In Months Positive', () {
      expect(ticker.diffInMonths(ticker.copy().addYear().addMonth()), 13);
    });

    test('Diff In Months Negative With Sign', () {
      expect(
        ticker.diffInMonths(ticker.copy().subYear().addMonth(), false),
        -11,
      );
    });

    test('Diff In Months Negative No Sign', () {
      expect(ticker.diffInMonths(ticker.copy().subYear().addMonth()), 11);
    });

    test('Diff In Months Vs Default Now', () {
      expect(Ticker.now().subYear().diffInMonths(), 12);
    });

    test('Diff In Months Ensure Is Truncated', () {
      expect(ticker.diffInMonths(ticker.copy().addMonth().addDays(16)), 1);
    });
  });

  group('Diff In Days', () {
    test('Diff In Days Positive', () {
      expect(ticker.diffInDays(ticker.copy().addYear()), 366);
    });

    test('Diff In Days Negative With Sign', () {
      expect(ticker.diffInDays(ticker.copy().subYear(), false), -365);
    });

    test('Diff In Days Negative With No Sign', () {
      expect(ticker.diffInDays(ticker.copy().subYear()), 365);
    });

    test('Diff In Days Vs Default Now', () {
      expect(Ticker.now().subWeek().diffInDays(), 7);
    });

    test('DIff In Days Ensure Is Truncated', () {
      expect(ticker.diffInDays(ticker.copy().addDay().addHours(13)), 1);
    });
  });

  group('Diff In Days Filtered', () {
    test('Diff In Days Filtered Positive With Mutated', () {
      expect(
        ticker.diffInDaysFiltered(
          (Ticker ticker) {
            return ticker.weekday == 1;
          },
          ticker.copy().endOfMonth(),
        ),
        5,
      );
    });

    test('Diff In Days Filtered Positive With Second Subject', () {
      expect(
        ticker.diffInDaysFiltered(
          (Ticker ticker) {
            return ticker.weekday == Ticker.SUNDAY;
          },
          Ticker.createFromDate(year: 2000, month: 1, day: 31),
        ),
        5,
      );
    });

    test('Diff In Days Filtered Negative No Sign With Mutated', () {
      ticker = Ticker.createFromDate(year: 2000, month: 1, day: 31);

      expect(
        ticker.diffInDaysFiltered(
          (Ticker ticker) {
            return ticker.weekday == Ticker.SUNDAY;
          },
          ticker.copy().startOfMonth(),
        ),
        5,
      );
    });

    test('Diff In Days Filtered Negative No Sign With Second Object', () {
      ticker = Ticker.createFromDate(year: 2000, month: 1, day: 31);

      expect(
        ticker.diffInDaysFiltered(
          (Ticker ticker) {
            return ticker.weekday == Ticker.SUNDAY;
          },
          Ticker.createFromDate(year: 2000, month: 1, day: 1),
        ),
        5,
      );
    });

    test('Diff In Days Filtered Negative With Sign With Mutated', () {
      ticker = Ticker.createFromDate(year: 2000, month: 1, day: 31);

      expect(
        ticker.diffInDaysFiltered(
          (Ticker ticker) {
            return ticker.weekday == 1;
          },
          ticker.copy().startOfMonth(),
          false,
        ),
        -5,
      );
    });

    test('Diff In Days Filtered Negative With Sign With Second Object', () {
      ticker = Ticker.createFromDate(year: 2000, month: 1, day: 31);

      expect(
        ticker.diffInDaysFiltered(
          (Ticker ticker) {
            return ticker.weekday == Ticker.SUNDAY;
          },
          Ticker.createFromDate(year: 2000, month: 1, day: 1),
          false,
        ),
        -5,
      );
    });
  });
}
