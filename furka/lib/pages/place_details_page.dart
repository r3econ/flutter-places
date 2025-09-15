import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '/models/place.dart';
import 'dart:async';
import '/configuration/app_configuration.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key, required this.place});
  final Place place;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  final Completer<MapLibreMapController> _mapController =
      Completer<MapLibreMapController>();
  CameraPosition get _initialCameraPosition => CameraPosition(
    target: LatLng(widget.place.latitude, widget.place.longitude),
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.place.name),
        cupertino: (context, platform) =>
            CupertinoNavigationBarData(automaticBackgroundVisibility: false),
      ),
      body: Column(
        children: <Widget>[
          // Place details (below map)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  width:
                      double.infinity, // forces full width so textAlign works
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // left align
                    children: <Widget>[
                      // Map (50% of screen height)
                      SizedBox(
                        height: screenHeight * 0.5,
                        child: MapLibreMap(
                          styleString: AppConfiguration.mapStyle,
                          onMapCreated: _onMapCreated,
                          dragEnabled: false,
                          zoomGesturesEnabled: false,
                          rotateGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          initialCameraPosition: _initialCameraPosition,
                          onStyleLoadedCallback: _onStyleLoaded,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        "Altitude: ${widget.place.altitudeDescription()}",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),

                      const SizedBox(height: 12),
                      Text(
                        widget.place.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  Future<void> _onStyleLoaded() async {
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
  }
}
