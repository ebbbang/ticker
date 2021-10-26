import 'dart:math';

import 'package:intl/intl.dart';
import 'package:ticker/month.dart';

class Ticker {
  late DateTime _dateTime;

  static const int SUNDAY = 7;

  Ticker([var dateTime]) {
    if (dateTime == null) {
      _dateTime = DateTime.now();
    } else if (dateTime is Ticker) {
      _dateTime = dateTime.dateTime;
    } else if (dateTime is DateTime) {
      _dateTime = dateTime;
    } else {
      _dateTime = DateTime.parse(dateTime);
    }
  }

  int get year {
    return _dateTime.year;
  }

  int get month {
    return _dateTime.month;
  }

  int get day {
    return _dateTime.day;
  }

  int get hour {
    return _dateTime.hour;
  }

  int get minute {
    return _dateTime.minute;
  }

  int get second {
    return _dateTime.second;
  }

  int get millisecond {
    return _dateTime.millisecond;
  }

  int get microsecond {
    return _dateTime.microsecond;
  }

  int get weekday {
    return _dateTime.weekday;
  }

  DateTime get dateTime {
    return _dateTime;
  }

  static Ticker now() {
    return Ticker();
  }

  int diffInYears([var dateTime, bool absolute = true]) {
    Ticker otherTicker = Ticker(dateTime);

    int diff = otherTicker.year - year;

    return absolute ? diff.abs() : diff;
  }

  int diffInMonths([var dateTime, bool absolute = true]) {
    Ticker otherTicker = Ticker(dateTime);

    int diffInYears = this.diffInYears(otherTicker, false);

    int diff = (diffInYears * 12) + (otherTicker.month - month);

    return absolute ? diff.abs() : diff;
  }

  int diffInQuarters([var dateTime, bool absolute = true]) {
    Ticker otherTicker = Ticker(dateTime);

    int diff = this.diffInMonths(otherTicker, false) ~/ 3;

    return absolute ? diff.abs() : diff;
  }

  int diffInDays([var dateTime, bool absolute = true]) {
    Ticker otherTicker = Ticker(dateTime);

    print(this);
    print(otherTicker);

    int diff = otherTicker.dateTime.difference(_dateTime).inDays;

    return absolute ? diff.abs() : diff;
  }

  int diffInDaysFiltered(bool Function(Ticker ticker) callback,
      [var dateTime, bool absolute = true]) {
    Ticker otherTicker = Ticker(dateTime);

    int diff = 0;

    int totalDays = diffInDays(otherTicker);

    Ticker startDate = this.copy();

    for (int i = 0; i <= totalDays; i++) {
      if (callback(startDate)) {
        diff++;
      }

      startDate.addDay();
    }

    return absolute ? diff.abs() : diff;
  }

  static Ticker createFromDate({int? year, int? month, int? day}) {
    DateTime now = DateTime.now();

    return Ticker(
      DateTime(
        year ?? now.year,
        month ?? now.month,
        day ?? now.day,
      ),
    );
  }

  static Ticker createFromFormat(String format, [String? dateTime]) {
    if (dateTime == null) {
      return Ticker();
    } else {
      return Ticker(
        DateFormat(format).parse(dateTime),
      );
    }
  }

  Ticker copy() {
    return Ticker(_dateTime.toString());
  }

  Ticker addYear() {
    _dateTime = DateTime(
      _dateTime.year + 1,
      _dateTime.month,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker addMonth() {
    addMonths(1);

    return this;
  }

  Ticker addMonths(int months) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month + months,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker addQuarter() {
    addQuarters(1);

    return this;
  }

  Ticker addQuarters(int quarters) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month + (quarters * 3),
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker addWeek() {
    addWeeks(1);

    return this;
  }

  Ticker addWeeks(int weeks) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day + (weeks * 7),
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker addDay() {
    addDays(1);

    return this;
  }

  Ticker addDays(int days) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day + days,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker addHour() {
    addHours(1);

    return this;
  }

  Ticker addHours(int hours) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      _dateTime.hour + hours,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker subYear() {
    _dateTime = DateTime(
      _dateTime.year - 1,
      _dateTime.month,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker subQuarter() {
    subQuarters(1);

    return this;
  }

  Ticker subQuarters(int quarters) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month - (quarters * 3),
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker subWeek() {
    subWeeks(1);

    return this;
  }

  Ticker subWeeks(int weeks) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day - (weeks * 7),
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker addMonthNoOverflow([int months = 1]) {
    return addMonthsNoOverflow(months);
  }

  Ticker addMonthsNoOverflow([int months = 1]) {
    var extraMonths = months % 12;

    var extraYears = (months - extraMonths) ~/ 12;

    var newYear = _dateTime.year + extraYears;
    var newMonth = _dateTime.month + extraMonths;

    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }

    var newDay = min(_dateTime.day, Month.daysInMonth(newYear, newMonth));

    _dateTime = new DateTime(
        newYear,
        newMonth,
        newDay,
        _dateTime.hour,
        _dateTime.minute,
        _dateTime.second,
        _dateTime.millisecond,
        _dateTime.microsecond);

    return this;
  }

  Ticker subMonthNoOverflow([int months = 1]) {
    return subMonthsNoOverflow(months);
  }

  Ticker subMonthsNoOverflow([int months = 1]) {
    var extraMonths = months % 12;

    var extraYears = (months - extraMonths) ~/ 12;

    var newYear = _dateTime.year - extraYears;

    var newMonth = _dateTime.month - extraMonths;

    if (newMonth < 1) {
      newYear--;
      newMonth += 12;
    }

    var newDay = min(_dateTime.day, Month.daysInMonth(newYear, newMonth));

    _dateTime = new DateTime(
        newYear,
        newMonth,
        newDay,
        _dateTime.hour,
        _dateTime.minute,
        _dateTime.second,
        _dateTime.millisecond,
        _dateTime.microsecond);

    return this;
  }

  Ticker addMonthWithOverflow([int months = 1]) {
    return addMonthsWithOverflow(months);
  }

  Ticker addMonthsWithOverflow([int months = 1]) {
    _dateTime = new DateTime(
      _dateTime.year,
      _dateTime.month + months,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker subMonthWithOverflow([int months = 1]) {
    return subMonthsWithOverflow(months);
  }

  Ticker subMonthsWithOverflow([int months = 1]) {
    _dateTime = new DateTime(
      _dateTime.year,
      _dateTime.month - months,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker endOfMonth() {
    int lastDay = Month.daysInMonth(_dateTime.year, _dateTime.month);

    _dateTime = new DateTime(
      _dateTime.year,
      _dateTime.month,
      lastDay,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  Ticker startOfMonth() {
    _dateTime = new DateTime(
      _dateTime.year,
      _dateTime.month,
      1,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
      _dateTime.millisecond,
      _dateTime.microsecond,
    );

    return this;
  }

  @override
  String toString() {
    return _dateTime.toString();
  }
}
