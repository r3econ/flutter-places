import '/repositories/places_repository.dart';
import 'package:flutter/material.dart';
import '/models/place.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlacesRepository repository = PlacesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold))),
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

  void _addPlace() {
    setState(() {
      repository.places.add(
        Place("Realp", 46.583333, 8.166667, 1538),
      );
    });
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