import 'package:flutter/material.dart';
import 'package:furka/pages/places_map_page.dart';
import 'configuration/app_configuration.dart';
import 'pages/places_list_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfiguration.appName,
      theme: AppConfiguration.theme,
      home: MainTabBar());
  }
}

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.colorScheme.onSecondary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            label: 'Places',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        PlacesListPage(title: AppConfiguration.appName),
        PlacesMapPage(),
      ][currentPageIndex],
    );
  }
}