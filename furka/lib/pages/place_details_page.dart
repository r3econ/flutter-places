import '/repositories/places_repository.dart';
import 'package:flutter/material.dart';
import '/models/place.dart';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key, required this.place});

  final Place place;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  PlacesRepository repository = PlacesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.place.name,
        style: TextStyle(
          fontWeight: FontWeight.bold))),
      body: Center(

      )
    );
  }
}
