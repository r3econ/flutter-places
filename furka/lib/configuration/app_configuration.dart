import 'package:flutter/material.dart';

class AppConfiguration {
  static final String appName = "Furka";
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 255, 255),
      primary: const Color.fromARGB(255, 255, 255, 255),
      surfaceTint: const Color(0xFF5AC8FA),
    ),
  );
}
