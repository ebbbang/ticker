import 'dart:math';

import 'package:intl/intl.dart';
import 'package:ticker/month.dart';
import 'package:ticker/weekday.dart';

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

  int get weekday {
    return _dateTime.weekday;
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

  int get microsecondsSinceEpoch {
    return _dateTime.microsecondsSinceEpoch;
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

    int diff = otherTicker.dateTime.difference(_dateTime).inDays;

    return absolute ? diff.abs() : diff;
  }

  int diffInDaysFiltered(
    bool Function(Ticker ticker) callback, [
    var dateTime,
    bool absolute = true,
  ]) {
    Ticker otherTicker = Ticker(dateTime);

    int diff = 0;

    int totalDays = diffInDays(otherTicker);

    Ticker startDate = this.copy();

    if (microsecondsSinceEpoch < otherTicker.microsecondsSinceEpoch) {
      for (int i = 0; i <= totalDays; i++) {
        if (callback(startDate)) {
          diff++;
        }

        startDate.addDay();
      }
    } else {
      for (int i = totalDays; i >= 0; i--) {
        if (callback(startDate)) {
          diff--;
        }

        startDate.subDay();
      }
    }

    return absolute ? diff.abs() : diff;
  }

  static Ticker createFromDate({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    DateTime now = DateTime.now();

    return Ticker(
      DateTime(
        year ?? now.year,
        month ?? now.month,
        day ?? now.day,
        hour ?? now.hour,
        minute ?? now.minute,
        second ?? now.second,
        millisecond ?? now.millisecond,
        microsecond ?? now.microsecond,
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
    addYears(1);

    return this;
  }

  Ticker addYears([int years = 1]) {
    add(years: years);

    return this;
  }

  Ticker addQuarter() {
    addQuarters(1);

    return this;
  }

  Ticker addQuarters([int quarters = 1]) {
    add(months: quarters * 3);

    return this;
  }

  Ticker addMonth() {
    addMonths(1);

    return this;
  }

  Ticker addMonths([int months = 1]) {
    add(months: months);

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

    setDateTime(year: newYear, month: newMonth, day: newDay);

    return this;
  }

  Ticker addMonthWithOverflow([int months = 1]) {
    return addMonthsWithOverflow(months);
  }

  Ticker addMonthsWithOverflow([int months = 1]) {
    add(months: months);

    return this;
  }

  Ticker addWeek() {
    addWeeks(1);

    return this;
  }

  Ticker addWeeks([int weeks = 1]) {
    add(days: weeks * 7);

    return this;
  }

  Ticker addDay() {
    addDays(1);

    return this;
  }

  Ticker addDays([int days = 1]) {
    add(days: days);

    return this;
  }

  Ticker addWeekDay() {
    addWeekDays(1);

    return this;
  }

  Ticker addWeekDays([int weekdays = 1]) {
    int addedDays = 0;

    while (addedDays < weekdays.abs()) {
      if (weekdays.isNegative) {
        sub(days: 1);
      } else {
        add(days: 1);
      }

      if (_dateTime.weekday != Weekday.SATURDAY &&
          _dateTime.weekday != Weekday.SUNDAY) {
        addedDays++;
      }
    }

    return this;
  }

  Ticker addHour() {
    addHours(1);

    return this;
  }

  Ticker addHours([int hours = 1]) {
    add(hours: hours);

    return this;
  }

  Ticker subYear() {
    subYears(1);

    return this;
  }

  Ticker subYears([int years = 1]) {
    sub(years: years);

    return this;
  }

  Ticker subQuarter() {
    subQuarters(1);

    return this;
  }

  Ticker subQuarters([int quarters = 1]) {
    sub(months: quarters * 3);

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

    setDateTime(year: newYear, month: newMonth, day: newDay);

    return this;
  }

  Ticker subMonthWithOverflow([int months = 1]) {
    return subMonthsWithOverflow(months);
  }

  Ticker subMonthsWithOverflow([int months = 1]) {
    sub(months: months);

    return this;
  }

  Ticker subWeek() {
    subWeeks(1);

    return this;
  }

  Ticker subWeeks([int weeks = 1]) {
    sub(days: weeks * 7);

    return this;
  }

  Ticker subDay() {
    subDays(1);

    return this;
  }

  Ticker subDays([int days = 1]) {
    sub(days: days);

    return this;
  }

  Ticker endOfMonth() {
    setDateTime(day: Month.daysInMonth(_dateTime.year, _dateTime.month));

    return this;
  }

  Ticker startOfMonth() {
    setDateTime(day: 1);

    return this;
  }

  Ticker add({
    int? years,
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
    bool overflow = true,
  }) {
    late int newMonth;

    if (months == null) {
      newMonth = _dateTime.month;
    } else if (overflow == true) {
      newMonth = _dateTime.month + months;
    } else {
      for (int i = 0; i < months; i++) {
        _dateTime = _dateTime.add(
          Duration(
            days: Month.daysInMonth(_dateTime.year, _dateTime.month + 1),
          ),
        );
      }

      newMonth = _dateTime.month;
    }

    _dateTime = new DateTime(
      years != null ? _dateTime.year + years : _dateTime.year,
      newMonth,
      days != null ? _dateTime.day + days : _dateTime.day,
      hours != null ? _dateTime.hour + hours : _dateTime.hour,
      minutes != null ? _dateTime.minute + minutes : _dateTime.minute,
      seconds != null ? _dateTime.second + seconds : _dateTime.second,
      milliseconds != null
          ? _dateTime.millisecond + milliseconds
          : _dateTime.millisecond,
      microseconds != null
          ? _dateTime.microsecond + microseconds
          : _dateTime.microsecond,
    );

    return this;
  }

  Ticker sub({
    int? years,
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
  }) {
    _dateTime = new DateTime(
      years != null ? _dateTime.year - years : _dateTime.year,
      months != null ? _dateTime.month - months : _dateTime.month,
      days != null ? _dateTime.day - days : _dateTime.day,
      hours != null ? _dateTime.hour - hours : _dateTime.hour,
      minutes != null ? _dateTime.minute - minutes : _dateTime.minute,
      seconds != null ? _dateTime.second - seconds : _dateTime.second,
      milliseconds != null
          ? _dateTime.millisecond - milliseconds
          : _dateTime.millisecond,
      microseconds != null
          ? _dateTime.microsecond - microseconds
          : _dateTime.microsecond,
    );

    return this;
  }

  Ticker setDateTime({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    _dateTime = new DateTime(
      year != null ? year : _dateTime.year,
      month != null ? month : _dateTime.month,
      day != null ? day : _dateTime.day,
      hour != null ? hour : _dateTime.hour,
      minute != null ? minute : _dateTime.minute,
      second != null ? second : _dateTime.second,
      millisecond != null ? millisecond : _dateTime.millisecond,
      microsecond != null ? microsecond : _dateTime.microsecond,
    );

    return this;
  }

  String format(String format) {
    return DateFormat(format).format(_dateTime);
  }

  @override
  String toString() {
    return _dateTime.toString();
  }
}
