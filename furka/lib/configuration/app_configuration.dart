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
    // Style source: https://api3.geo.admin.ch/services/sdiservices.html#getstyle
  static final String mapStyle =
      "https://vectortiles.geo.admin.ch/styles/ch.swisstopo.basemap.vt/style.json";
}
