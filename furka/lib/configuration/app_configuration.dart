import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppConfiguration {
  static final String appName = "Places";
  // Style source: https://api3.geo.admin.ch/services/sdiservices.html#getstyle
  static final String mapStyle =
      "https://vectortiles.geo.admin.ch/styles/ch.swisstopo.basemap.vt/style.json";
  static final lightMaterialTheme = ThemeData.light();
  static final darkMaterialTheme = ThemeData.dark();
  static final lightCupertinoTheme = CupertinoThemeData(
    brightness: Brightness.light,
  );
  static final darkCupertinoTheme = CupertinoThemeData(
    brightness: Brightness.dark,
  );
}
