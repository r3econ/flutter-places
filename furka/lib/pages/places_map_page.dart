import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '/models/place.dart';
import 'dart:async';
import '/configuration/app_configuration.dart';
import '/repositories/places_repository.dart';

class PlacesMapPage extends StatefulWidget {
  const PlacesMapPage({super.key});

  @override
  State<PlacesMapPage> createState() => _PlacesMapPageState();
}

class _PlacesMapPageState extends State<PlacesMapPage> {
  PlacesRepository _repository = PlacesRepository();
  final Completer<MapLibreMapController> _mapController =
      Completer<MapLibreMapController>();
  bool _canInteractWithMap = false;
  CameraPosition get _initialCameraPosition => CameraPosition(
    target: LatLng(46.57250, 8.41500), // Furka Pass coordinates
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Map', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: _canInteractWithMap
          ? FloatingActionButton(
              onPressed: _moveCameraToPlaceLocation,
              mini: true,
              child: const Icon(Icons.restore),
            )
          : null,
      body: MapLibreMap(
        styleString: AppConfiguration.mapStyle,
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialCameraPosition,
        onStyleLoadedCallback: _onStyleLoaded,
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  Future<void> _onStyleLoaded() async {
    setState(() => _canInteractWithMap = true);
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
    await _addAnnotations(controller);
  }

  Future<void> _moveCameraToPlaceLocation() async {
    final c = await _mapController.future;
    await c.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
  }

  Future<void> _addAnnotations(MapLibreMapController controller) async {
    for (Place place in _repository.places) {
      await controller.addCircle(
        CircleOptions(
          geometry: LatLng(place.latitude, place.longitude),
          circleColor: AppConfiguration.theme.colorScheme.surfaceTint
              .toHexStringRGB(),
          circleStrokeColor: AppConfiguration.theme.colorScheme.primary
              .toHexStringRGB(),
          circleStrokeWidth: 2.0,
          circleRadius: 5.0,
          circleOpacity: 0.9,
        ),
      );
    }
  }
}
