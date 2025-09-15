import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '/models/place.dart';
import 'dart:async';
import '/configuration/app_configuration.dart';
import '/repositories/places_repository.dart';
import 'place_details_page.dart'; // Make sure you have this page
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  final Map<String, Place> _circleIdToPlace = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Map'),
        cupertino: (context, platform) =>
            CupertinoNavigationBarData(automaticBackgroundVisibility: false),
      ),
      body: MapLibreMap(
        styleString: AppConfiguration.mapStyle,
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialCameraPosition(),
        onStyleLoadedCallback:() {
          _onStyleLoaded(theme);
        },
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  Future<void> _onStyleLoaded(ThemeData theme) async {
    setState(() => _canInteractWithMap = true);
    await _addAnnotations(theme);
    await _moveCameraToPlacesBounds();
  }

  Future<void> _moveCameraToPlacesBounds() async {
    final controller = await _mapController.future;
    final bounds = _getBoundsForPlaces();
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        left: 50,
        top: 50,
        right: 50,
        bottom: 50,
      ),
    );
  }

  Future<void> _addAnnotations(ThemeData theme) async {
    final controller = await _mapController.future;
    for (Place place in _repository.places) {
      final circle = await controller.addCircle(
        CircleOptions(
          geometry: LatLng(place.latitude, place.longitude),
          circleColor: theme.colorScheme.onPrimary
              .toHexStringRGB(),
          circleStrokeColor: theme.colorScheme.primary
              .toHexStringRGB(),
          circleStrokeWidth: 2.0,
          circleRadius: 5.0,
          circleOpacity: 0.9,
        ),
      );
      _circleIdToPlace[circle.id] = place;
    }
    controller.onCircleTapped.add(_onCircleTapped);
  }

  void _onCircleTapped(Circle circle) async {
    final place = _circleIdToPlace[circle.id];
    if (place == null) return;

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlaceDetailsPage(place: place)));
  }

  CameraPosition _initialCameraPosition() => CameraPosition(
    target: _getBoundsCenter(_getBoundsForPlaces()),
    zoom: 12.0,
  );

  LatLngBounds _getBoundsForPlaces() {
    final places = _repository.places;

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

  LatLng _getBoundsCenter(LatLngBounds bounds) {
    final double centerLat =
        (bounds.southwest.latitude + bounds.northeast.latitude) / 2;
    final double centerLng =
        (bounds.southwest.longitude + bounds.northeast.longitude) / 2;
    return LatLng(centerLat, centerLng);
  }
}
