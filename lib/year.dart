class Year {
  static int daysInYear(int year) =>
      year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) ? 366 : 365;
}
