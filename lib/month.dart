class Month {
  static const _daysInMonth = const [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  static bool isLeapYear(int year) =>
      year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);

  static int daysInMonth(int year, int month) {
    int days = _daysInMonth[month];

    if (month == 2 && isLeapYear(year)) days++;

    return days;
  }
}
