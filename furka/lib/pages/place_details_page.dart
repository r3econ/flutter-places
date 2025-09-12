import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '/models/place.dart';
import 'dart:async';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key, required this.place});

  final Place place;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  final Completer<MapLibreMapController> mapController = Completer();
  bool canInteractWithMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.place.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: canInteractWithMap
          ? FloatingActionButton(
              onPressed: _moveCameraToPlaceLocation,
              mini: true,
              child: const Icon(Icons.restore),
            )
          : null,
      body: MapLibreMap(
        styleString: "https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json",
        onMapCreated: (controller) => _moveCameraToPlaceLocation(),
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.place.latitude, widget.place.longitude),
          zoom: 14.0,
        ),
        onStyleLoadedCallback: () => setState(() => canInteractWithMap = true),
      ),
    );
  }

  void _moveCameraToPlaceLocation() => mapController.future.then(
    (c) => c.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.place.latitude, widget.place.longitude),
          zoom: 14.0,
        ),
      ),
    ),
  );
}
