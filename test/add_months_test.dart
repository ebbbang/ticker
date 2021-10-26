import 'package:test/test.dart';
import 'package:ticker/ticker.dart';

import 'helpers.dart';

void main() {
  late Ticker ticker;

  setUp(() {
    ticker = Ticker.createFromDate(year: 2016, month: 1, day: 31);
  });

  List<List> addMonthNoOverflowDates = [
    [-2, 2015, 11, 30],
    [-1, 2015, 12, 31],
    [0, 2016, 1, 31],
    [1, 2016, 2, 29],
    [2, 2016, 3, 31],
  ];

  test('Add Month No Overflow', () {
    for (List date in addMonthNoOverflowDates) {
      assertTicker(
          ticker.copy().addMonthNoOverflow(date[0]), date[1], date[2], date[3]);
    }
  });

  test('Add Months No Overflow', () {
    for (List date in addMonthNoOverflowDates) {
      assertTicker(ticker.copy().addMonthsNoOverflow(date[0]), date[1], date[2],
          date[3]);
    }
  });

  List<List> subMonthNoOverflowDates = [
    [-2, 2016, 3, 31],
    [-1, 2016, 2, 29],
    [0, 2016, 1, 31],
    [1, 2015, 12, 31],
    [2, 2015, 11, 30],
  ];

  test('Sub Month No Overflow', () {
    for (List date in subMonthNoOverflowDates) {
      assertTicker(
          ticker.copy().subMonthNoOverflow(date[0]), date[1], date[2], date[3]);
    }
  });

  test('Sub Months No Overflow', () {
    for (List date in subMonthNoOverflowDates) {
      assertTicker(ticker.copy().subMonthsNoOverflow(date[0]), date[1], date[2],
          date[3]);
    }
  });

  List<List> addMonthWithOverflowDates = [
    [-2, 2015, 12, 1],
    [-1, 2015, 12, 31],
    [0, 2016, 1, 31],
    [1, 2016, 3, 2],
    [2, 2016, 3, 31],
  ];

  test('Add Month With Overflow', () {
    for (List date in addMonthWithOverflowDates) {
      assertTicker(ticker.copy().addMonthWithOverflow(date[0]), date[1],
          date[2], date[3]);
    }
  });

  test('Add Months With Overflow', () {
    for (List date in addMonthWithOverflowDates) {
      assertTicker(ticker.copy().addMonthsWithOverflow(date[0]), date[1],
          date[2], date[3]);
    }
  });

  List<List> subMonthWithOverflowDates = [
    [-2, 2016, 3, 31],
    [-1, 2016, 3, 2],
    [0, 2016, 1, 31],
    [1, 2015, 12, 31],
    [2, 2015, 12, 1],
  ];

  test('Sub Month With Overflow', () {
    for (List date in subMonthWithOverflowDates) {
      assertTicker(ticker.copy().subMonthWithOverflow(date[0]), date[1],
          date[2], date[3]);
    }
  });

  test('Sub Months With Overflow', () {
    for (List date in subMonthWithOverflowDates) {
      assertTicker(ticker.copy().subMonthsWithOverflow(date[0]), date[1],
          date[2], date[3]);
    }
  });
}
