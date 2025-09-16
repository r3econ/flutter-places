import '/repositories/places_repository.dart';
import 'package:flutter/material.dart';
import '/models/place.dart';
import 'place_details_page.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlacesListPage extends StatefulWidget {
  const PlacesListPage({super.key});
  @override
  State<PlacesListPage> createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  PlacesRepository repository = PlacesRepository();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Places'),
        cupertino: (context, platform) =>
            CupertinoNavigationBarData(automaticBackgroundVisibility: false),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: repository.places.length,
          itemBuilder: (context, index) {
            Place place = repository.places[index];
            return PlatformListTile(
              title: Text(place.name),
              subtitle: Text(place.altitudeDescription()),
              trailing: Icon(context.platformIcons.rightChevron),
              onTap: () => _navigateToPlaceDetails(context, place),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }

  void _navigateToPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PlaceDetailsPage(place: place)),
    );
  }
}
