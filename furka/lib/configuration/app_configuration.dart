import 'package:flutter/material.dart';

class AppConfiguration {
  static const String appName = "Furka";
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 245, 216, 64),
      primary: const Color.fromARGB(255, 245, 216, 64),
    ),
  );
}
