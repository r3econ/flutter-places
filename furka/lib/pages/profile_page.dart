import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '/repositories/places_repository.dart';
import '/models/place.dart';
import 'place_details_page.dart';
import '/views/place_list_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PlacesRepository repository = PlacesRepository();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Profile'),
        cupertino: (context, platform) =>
            CupertinoNavigationBarData(automaticBackgroundVisibility: false),
      ),
      body: Center(
        child: Text(  
          'User Profile Page\n\nThis is a placeholder for user profile information.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _navigateToPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PlaceDetailsPage(place: place)),
    );
  }

  Widget _buildFavoritePlacesList() {
    return ListView.separated(
          itemCount: repository.places.length,
          itemBuilder: (context, index) {
            Place place = repository.places[index];
            PlaceListItem item = PlaceListItem(
              place.name,
              place.altitudeDescription(),
            );
            return PlatformListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              trailing: Icon(context.platformIcons.rightChevron),
              onTap: () => _navigateToPlaceDetails(context, place),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
  }
}