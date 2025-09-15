import 'package:flutter/material.dart';
import 'package:furka/pages/places_map_page.dart';
import 'configuration/app_configuration.dart';
import 'pages/places_list_page.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfiguration.appName,
      theme: AppConfiguration.theme,
      home: MainTabBar(),
    );
  }
}

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PlatformScaffold(
      body: [
        /// Home page
        PlacesListPage(title: AppConfiguration.appName),
        PlacesMapPage(),
      ][_selectedPageIndex],
      bottomNavBar: PlatformNavBar(
        currentIndex: _selectedPageIndex,
        cupertino: (context, platform) => CupertinoTabBarData(
          iconSize: 24,
          backgroundColor: theme.colorScheme.primary,
          activeColor: theme.colorScheme.inverseSurface,
        ),
        itemChanged: (index) => setState(() {
          _selectedPageIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(context.platformIcons.collectionsSolid),
            icon: Icon(context.platformIcons.collections),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(context.platformIcons.locationSolid),
            icon: Icon(context.platformIcons.location),
            label: 'Map',
          ),
        ],
      ),
      iosContentPadding: false,
      iosContentBottomPadding: false,
    );
  }
}
