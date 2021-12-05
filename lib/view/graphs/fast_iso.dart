
Duration toDuration(String isoString) {
  if (!RegExp(
      r"^(-|\+)?P(?:([-+]?[0-9,.]*)Y)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)W)?(?:([-+]?[0-9,.]*)D)?(?:T(?:([-+]?[0-9,.]*)H)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)S)?)?$")
      .hasMatch(isoString)) {
    throw ArgumentError("String does not follow correct format");
  }

  final weeks = _parseTime(isoString, "W");
  final days = _parseTime(isoString, "D");
  final hours = _parseTime(isoString, "H");
  final minutes = _parseTime(isoString, "M");
  final seconds = _parseTime(isoString, "S");

  return Duration(
    days: days + (weeks * 7),
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

/// Private helper method for extracting a time value from the ISO8601 string.
int _parseTime(String duration, String timeUnit) {
  dynamic timeMatch = RegExp(r"\d+" + timeUnit).firstMatch(duration) ?? "";

  if (timeMatch.toString().isEmpty) {
    return 0;
  }
  final timeString = timeMatch.group(0);
  return int.parse(timeString.substring(0, timeString.length - 1));
}
