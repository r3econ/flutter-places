import 'package:flutter/material.dart';
import 'configuration/app_configuration.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfiguration.appName,
      theme: AppConfiguration.theme,
      home: const HomePage(title: AppConfiguration.appName),
    );
  }
}
