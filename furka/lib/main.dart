import 'package:flutter/material.dart';
import 'package:furka/pages/places_map_page.dart';
import 'configuration/app_configuration.dart';
import 'pages/places_list_page.dart';
import 'pages/profile_page.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => PlatformTheme(
        themeMode: ThemeMode.system,
        materialLightTheme: AppConfiguration.lightMaterialTheme,
        materialDarkTheme: AppConfiguration.darkMaterialTheme,
        cupertinoLightTheme: AppConfiguration.lightCupertinoTheme,
        cupertinoDarkTheme: AppConfiguration.darkCupertinoTheme,
        builder: (context) =>
            PlatformApp(title: AppConfiguration.appName, home: MainTabBar()),
      ),
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
      body: [PlacesListPage(), PlacesMapPage(), ProfilePage()][_selectedPageIndex],
      bottomNavBar: PlatformNavBar(
        currentIndex: _selectedPageIndex,
        cupertino: (context, platform) => CupertinoTabBarData(
          iconSize: 24,
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
            activeIcon: Icon(context.platformIcons.favoriteSolid),
            icon: Icon(context.platformIcons.favoriteOutline),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(context.platformIcons.personSolid),
            icon: Icon(context.platformIcons.person),
            label: 'Map',
          ),
        ],
      ),
      iosContentPadding: false,
      iosContentBottomPadding: false,
    );
  }
}
