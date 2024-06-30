import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';


class Logger {
  log(Object? logStr, {StrColor? color, String name = 'appLog',int maxLength = 1500}) {
    String? logStr0 = logStr.toString().cut(maxLength);
    if (kDebugMode || kProfileMode) {
      if (color != null) {
        dev.log((logStr0??'').toColoredString(color), name: name);
      } else {
        dev.log(logStr0.toString(), name: name);
      }
    } else {
      _logPrint(logStr0, color: color, name: name);
    }
  }

  String _logTime() {
    var now = DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;
    var hour = now.hour;
    var minute = now.minute;
    var second = now.second;
    return '${[day, month, year].join('-')} ${[hour, minute, second].join(':')}';
  }

  void _logPrint(
    Object? object, {
    StrColor? color,
    String? name,
  }) async {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    var chunks = pattern.allMatches(object.toString());
    var time = _logTime();
    debugPrint('[$time] '.addColor(StrColor.white));
    for (var e in chunks) {
      var group = e.group(0);
      var logName = (name != null ? '[$name] ' : '').addColor(StrColor.white);
      if (color != null) {
        debugPrint(logName + group.addColor(color));
      } else {
        debugPrint(logName + group.toString());
      }
    }
  }

  logError(Object? error, [Object? stackTrace, String? name]) {
    log(error, color: StrColor.red, name: name ?? 'LogError');
    if (stackTrace != null) {
      log(stackTrace, color: StrColor.red, name: name ?? 'LogError');
    }
  }
  logEventLeak(Object? error, {String? name}) {
    log(error, color: StrColor.magenta, name: name ?? 'LogEventLeak');
  }
}

var logger = Logger();

enum StrColor {
  black, //   \x1B[30m
  red, //     \x1B[31m
  green, //   \x1B[32m
  yellow, //  \x1B[33m
  blue, //    \x1B[34m
  magenta, // \x1B[35m
  cyan, //    \x1B[36m
  white, //   \x1B[37m
  reset, //   \x1B[0m
  darkRed,
  emitSocket,
  onSocket,
}

extension ObjectExt on Object {
  String toColoredString(StrColor color) => toString().addColor(color);

  String toErrorString() => toColoredString(StrColor.red);

  bool get isStringNullOrEmpty => toString().isBlank;

  bool stringCompareWith(Object b) =>
      _toCompareString() == b._toCompareString();

  String _toCompareString() => toString().trim().toLowerCase();

  // List get flattenObject {
  //   if (this is! Iterable)
  //     return [this];
  //   else
  //     return (this as Iterable).toList().flatten;
  // }
}
extension NullableStringExt on String? {
  String addColor(StrColor color) {
    String str;
    switch (color) {
      case StrColor.black: //   \x1B[30m
        str = '\x1B[30m';
        break;
      case StrColor.red: //     \x1B[31m
        str = '\x1B[31m';
        break;
      case StrColor.green: //   \x1B[32m
        str = '\x1B[32m';
        break;
      case StrColor.yellow: //  \x1B[33m
        str = '\x1B[33m';
        break;
      case StrColor.blue: //    \x1B[34m
        str = '\x1B[34m';
        break;
      case StrColor.magenta: // \x1B[35m
        str = '\x1B[35m';
        break;
      case StrColor.cyan: //    \x1B[36m
        str = '\x1B[36m';
        break;
      case StrColor.white: //   \x1B[37m
        str = '\x1B[37m';
        break;
      case StrColor.reset: //   \x1B[0m
        str = '\x1B[0m';
        break;
      case StrColor.darkRed:
        str = '\x1B[38;5;166m';
        break;
      default:
        str = '';
    }
    return '$str$this\x1B[m';
  }

  bool get isBlank => this == null || this!.trim().isEmpty;

  String valueIfNull(String value) => isBlank ? value : this!;

  String? cut(int maxLength) => isBlank
      ? this
      : this!.length < maxLength
          ? this!.substring(0, this!.length)
          : ('${this!.substring(0, maxLength)}...');
}
