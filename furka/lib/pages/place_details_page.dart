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
          style: const TextStyle(fontWeight: FontWeight.bold),
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
        styleString:
            "https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json",
        onMapCreated: _onMapCreated,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.place.latitude, widget.place.longitude),
          zoom: 14.0,
        ),
        // call _onStyleLoaded when the style finished loading
        onStyleLoadedCallback: _onStyleLoaded,
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }
  }

  Future<void> _onStyleLoaded() async {
    setState(() => canInteractWithMap = true);
    final controller = await mapController.future;

    // move camera (optional)
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.place.latitude, widget.place.longitude),
          zoom: 14.0,
        ),
      ),
    );

    // add the circle
    await _addCircle(controller);
  }

  Future<void> _moveCameraToPlaceLocation() async {
    final c = await mapController.future;
    await c.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.place.latitude, widget.place.longitude),
          zoom: 14.0,
        ),
      ),
    );
  }

  Future<void> _addCircle(MapLibreMapController controller) async {
    await controller.addCircle(
      CircleOptions(
        geometry: LatLng(widget.place.latitude, widget.place.longitude),
        circleRadius: 6.0,
        circleColor: '#5AC8FA', // string hex is accepted
        circleStrokeWidth: 2.0,
        circleStrokeColor: '#ffffff',
        circleOpacity: 0.9,
      ),
    );
  }
}