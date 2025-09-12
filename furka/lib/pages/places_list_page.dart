import '/repositories/places_repository.dart';
import 'package:flutter/material.dart';
import '/models/place.dart';
import '/views/place_list_item.dart';
import 'place_details_page.dart';

class PlacesListPage extends StatefulWidget {
  const PlacesListPage({super.key, required this.title});
  final String title;

  @override
  State<PlacesListPage> createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  PlacesRepository repository = PlacesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: repository.places.length,
          itemBuilder: (context, index) {
            Place place = repository.places[index];
            PlaceListItem item = PlaceListItem(
              place.name,
              place.altitudeDescription(),
            );
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              trailing: Icon(Icons.chevron_right_rounded),
              onTap: () => _navigateToPlaceDetails(context, place),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlace,
        tooltip: 'Add Place',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PlaceDetailsPage(place: place)),
    );
  }

  void _addPlace() {
    setState(() {
      repository.places.add(Place("Realp", 46.583333, 8.166667, 1538));
    });
  }
}
