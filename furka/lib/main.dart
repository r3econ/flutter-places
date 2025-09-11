import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 238, 0),
          primary: const Color.fromARGB(255, 255, 238, 0),
        ),
      ),
      home: const HomePage(title: 'Furka'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class Place {
  String name;
  double latitude;
  double longitude;
  int altitude;

  Place(this.name, this.latitude, this.longitude, this.altitude) {}
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  PlacesRepository repository = PlacesRepository();

  void _addPlace() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: repository.places.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(repository.places[index].name),
              subtitle: Text('${repository.places[index].altitude} m'),
              onTap: () {
                // Go to the next screen with Navigator.push
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlace,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class PlaceItem implements ListItem {
  final String title;
  final String subtitle;

  PlaceItem(this.title, this.subtitle);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildSubtitle(BuildContext context) => Text(subtitle);
}

class PlacesRepository {
  var places = [
    Place("Galenstock", 46.61263, 8.41712, 3586),
    Place("Klein Furkahorn", 46.58573, 8.40629, 3026),
    Place("Gross Furkahorn", 46.59661, 8.41030, 3169),
    Place("Sidelenhorn", 46.60085, 8.40974, 3215),
    Place("Chli Bielenhorn", 46.59891, 8.43489, 2940),
    Place("Gross Bielenhorn", 46.60360, 8.42859, 3210),
    Place("Gletschhorn", 46.61803, 8.44086, 3305),
    Place("Winterstock", 46.61778, 8.45467, 3203),
    Place("Tiefenstock", 46.64000, 8.42000, 3515),
  ];
}