import 'dart:io';

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateFormatUtil {
  static String? yyyyMMddFormat(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return '$year/${month < 10 ? '0$month' : month}/${day < 10 ? '0$day' : day}';
  }

  static String? ddMMyyyyFormat(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return '${day < 10 ? '0$day' : day}-${month < 10 ? '0$month' : month}-$year';
  }

  static String? dateFormatVietnamese(String? source) {
    if (source?.isEmpty ?? true) {
      return '';
    }
    final date = DateTime.tryParse(source!);
    if (date == null) {
      return '';
    }
    final localDateTime = date.toLocal();
    final year = localDateTime.year;
    final month = localDateTime.month;
    final day = localDateTime.day;
    final hour = localDateTime.hour;
    final min = localDateTime.minute;
    final sec = localDateTime.second;
    return '${hour < 10 ? '0$hour' : hour}:${min < 10 ? '0$min' : min}:${sec < 10 ? '0$sec' : sec} - ${day < 10 ? '0$day' : day}-${month < 10 ? '0$month' : month}-$year';
  }

  static String yyyyMMddNow() {
    return DateFormat('yyyyMMdd').format(DateTime.now().toUtc());
  }

  static String ddMMyyyyWithSplash(String source) {
    if (source.isEmpty) {
      return '';
    }

    final date = DateTime.parse(source);
    final localDateTime = date.toLocal();
    final year = localDateTime.year;
    final month = localDateTime.month;
    final day = localDateTime.day;
    return '${day < 10 ? '0$day' : day}/${month < 10 ? '0$month' : month}/$year';
  }

  static String ddMMyyyyWithLocalTime(String source) {
    final temp = ddMMyyyyWithSplash(source);
    final date = DateTime.parse(source);
    final localDateTime = date.toLocal();
    final hour = localDateTime.hour;
    final formatHour = hour > 12 ? hour - 12 : hour;
    final minute = localDateTime.minute;
    final second = localDateTime.second;
    final clock = hour > 12 ? 'PM' : 'AM';
    return temp +
        ' ' +
        '${formatHour < 10 ? '0$formatHour' : formatHour}' +
        ':' +
        '${minute < 10 ? '0$minute' : minute}' +
        ':' +
        '${second < 10 ? '0$second' : second}' +
        ' ' +
        clock;
  }

  static bool isToDay(DateTime startDate, DateTime endDate) {
    if (startDate == null || endDate == null) {
      return false;
    }
    final now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final start = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final end = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );

    return now.isAtSameMomentAs(start) && now.isAtSameMomentAs(end);
  }

  static String nowOrderFormat() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  static String timeDateFormat(String? dateTime) {
    return DateFormat('HH:mm dd-MM-yyyy').format(
      DateTime.tryParse(dateTime ?? DateTime.now().toIso8601String()) ??
          DateTime.now(),
    );
  }

  static String eeeeddMMyyyyFormat({String? date, String? locale}) {
    return DateFormat('EEEE, dd/MM/yyyy', locale ?? Platform.localeName).format(
        (date?.isNotEmpty ?? false)
            ? DateTime.parse(date!)
            : DateTime.now().toUtc());
  }

  static String nowUtcFormat() {
    final format = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss.SSS",
      Platform.localeName,
    );
    final now = DateTime.now();
    return format.format(now.toUtc());
  }

  static DateTime dateWithZeroTime(DateTime source) {
    return DateTime(source.year, source.month, source.day);
  }

  /// This function are return all [DateTime] in a month
  static List<DateTime> allDateInMonths(List<Jiffy> source) {
    final items = <DateTime>[];
    for (final date in source) {
      for (var i = 1; i <= date.daysInMonth; i++) {
        items.add(
          dateWithZeroTime(
            DateTime(date.year, date.month, i),
          ),
        );
      }
    }
    return items;
  }

  static bool isValidSelectedDate(
    DateTime selectedDate,
    DateTime startDate,
    DateTime endDate,
  ) {
    if (startDate == null || endDate == null) {
      return false;
    }

    final selected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final start = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final end = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );

    if (selected.isAtSameMomentAs(start) && selected.isAtSameMomentAs(end)) {
      return true;
    }

    return start.isBefore(selected) && end.isAfter(selected);
  }
}
