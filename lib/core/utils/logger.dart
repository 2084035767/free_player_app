import 'dart:developer' as developer;

import 'package:free_play_app/core/constants.dart';

class Logger {
  static void info(String message, {String? tag, DateTime? time}) {
    final actualTag = tag ?? appName;
    final timestamp = time ?? DateTime.now();
    developer.log(
      message,
      name: actualTag,
      level: 500, // INFO level
      time: timestamp,
    );
  }

  static void error(
    String message, {
    String? tag,
    DateTime? time,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    final actualTag = tag ?? appName;
    final timestamp = time ?? DateTime.now();
    developer.log(
      message,
      name: actualTag,
      level: 1000, // ERROR level
      time: timestamp,
      error: exception,
      stackTrace: stackTrace,
    );
  }

  static void debug(String message, {String? tag, DateTime? time}) {
    final actualTag = tag ?? appName;
    final timestamp = time ?? DateTime.now();
    developer.log(
      message,
      name: actualTag,
      level: 300, // DEBUG level
      time: timestamp,
    );

  }

  static void warning(String message, {String? tag, DateTime? time}) {
    final actualTag = tag ?? appName;
    final timestamp = time ?? DateTime.now();
    developer.log(
      message,
      name: actualTag,
      level: 700, // WARNING level
      time: timestamp,
    );
  }
}
