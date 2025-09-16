import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as auth_ui;
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
  final PlacesRepository repository = PlacesRepository();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Profile'),
        cupertino: (context, platform) =>
            CupertinoNavigationBarData(automaticBackgroundVisibility: false),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;

          if (user == null) {
            return Center(
              child: PlatformElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlatformScaffold(
                        appBar: PlatformAppBar(),
                        body: auth_ui.SignInScreen(
                          providers: [auth_ui.EmailAuthProvider()],
                          actions: [
                            auth_ui.AuthStateChangeAction<auth_ui.SignedIn>((
                              context,
                              state,
                            ) {
                              Navigator.of(
                                context,
                              ).pop(); // ✅ close after login
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Login'),
              ),
            );
          } else {
            final email = user.email ?? 'Anonymous';
            return Center(
              child: PlatformTextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('Log out ($email)'),
              ),
            );
          }

          // ✅ Logged in → show profile info + logout + places
          // return Column(
          //   children: [
          //     Text(user.email ?? 'Anonymous'),
          //     PlatformElevatedButton(
          //       child: const Text('Logout'),
          //       onPressed: () async {
          //         await FirebaseAuth.instance.signOut();
          //       },
          //     ),
          //     const Divider(),
          //     // Expanded(child: _buildFavoritePlacesList()),
          //   ],
          // );
        },
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
        final place = repository.places[index];
        final item = PlaceListItem(place.name, place.altitudeDescription());
        return PlatformListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
          trailing: Icon(context.platformIcons.rightChevron),
          onTap: () => _navigateToPlaceDetails(context, place),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
