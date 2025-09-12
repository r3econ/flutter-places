import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '/models/place.dart';
import 'dart:async';
import '/configuration/app_configuration.dart';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key, required this.place});
  final Place place;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  final Completer<MapLibreMapController> _mapController = Completer();
  bool _canInteractWithMap = false;
  // Style source: https://api3.geo.admin.ch/services/sdiservices.html#getstyle
  final String _mapStyle =
      "https://vectortiles.geo.admin.ch/styles/ch.swisstopo.basemap.vt/style.json";
  CameraPosition get _initialCameraPosition => CameraPosition(
    target: LatLng(widget.place.latitude, widget.place.longitude),
    zoom: 14.0,
  );

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
      floatingActionButton: _canInteractWithMap
          ? FloatingActionButton(
              onPressed: _moveCameraToPlaceLocation,
              mini: true,
              child: const Icon(Icons.restore),
            )
          : null,
      body: MapLibreMap(
        styleString: _mapStyle,
        onMapCreated: _onMapCreated,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: true,
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
    await _addPlaceAnnotation(controller);
  }

  Future<void> _moveCameraToPlaceLocation() async {
    final c = await _mapController.future;
    await c.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
  }

  Future<void> _addPlaceAnnotation(MapLibreMapController controller) async {
    await controller.addCircle(
      CircleOptions(
        geometry: _initialCameraPosition.target,
        circleColor: AppConfiguration.theme.colorScheme.surfaceTint
            .toHexStringRGB(),
        circleStrokeColor: AppConfiguration.theme.colorScheme.primary
            .toHexStringRGB(),
        circleStrokeWidth: 2.0,
        circleRadius: 6.0,
        circleOpacity: 0.9,
      ),
    );
  }
}
