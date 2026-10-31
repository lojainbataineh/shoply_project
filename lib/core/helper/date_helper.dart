class DateHelper {
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// Formats a date like "Oct 15, 2026".
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return '${_months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
