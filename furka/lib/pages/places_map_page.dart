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
  final PlacesRepository _repository = PlacesRepository();
  final Completer<MapLibreMapController> _mapController =
      Completer<MapLibreMapController>();
  bool _canInteractWithMap = false;

  CameraPosition get _initialCameraPosition => const CameraPosition(
        target: LatLng(46.57250, 8.41500), // Furka Pass coordinates
        zoom: 12.0,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Map',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: _canInteractWithMap
          ? FloatingActionButton(
              onPressed: _moveCameraToPlacesBounds,
              mini: true,
              child: const Icon(Icons.zoom_out_map),
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

  Future<void> _moveCameraToPlacesBounds() async {
    final controller = await _mapController.future;
    final bounds = _getBoundsForPlaces();
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, left: 50, top: 50, right: 50, bottom: 50),
    );
  }

  Future<void> _addAnnotations(MapLibreMapController controller) async {
    for (Place place in _repository.places) {
      await controller.addCircle(
        CircleOptions(
          geometry: LatLng(place.latitude, place.longitude),
          circleColor:
              AppConfiguration.theme.colorScheme.surfaceTint.toHexStringRGB(),
          circleStrokeColor:
              AppConfiguration.theme.colorScheme.primary.toHexStringRGB(),
          circleStrokeWidth: 2.0,
          circleRadius: 5.0,
          circleOpacity: 0.9,
        ),
      );
    }
  }

    LatLngBounds _getBoundsForPlaces() {
    final places = _repository.places;
    if (places.isEmpty) {
      return LatLngBounds(
        southwest: _initialCameraPosition.target,
        northeast: _initialCameraPosition.target,
      );
    }

    double minLat = places.first.latitude;
    double maxLat = places.first.latitude;
    double minLng = places.first.longitude;
    double maxLng = places.first.longitude;

    for (final place in places) {
      if (place.latitude < minLat) minLat = place.latitude;
      if (place.latitude > maxLat) maxLat = place.latitude;
      if (place.longitude < minLng) minLng = place.longitude;
      if (place.longitude > maxLng) maxLng = place.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}