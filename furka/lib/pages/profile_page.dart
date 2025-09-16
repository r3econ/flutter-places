import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as auth_ui;
import '/repositories/places_repository.dart';
import '/models/place.dart';
import 'place_details_page.dart';

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
          if (FirebaseAuth.instance.currentUser == null) {
            return _buildLoggedOutStateUI();
          } else {
            return _buildLoggedInStateUI();
          }
        },
      ),
    );
  }

  void _navigateToPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PlaceDetailsPage(place: place)),
    );
  }

Widget _buildLoggedOutStateUI() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0), // side padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Please log in to view your profile and favorite places.',
            textAlign: TextAlign.center),
          const SizedBox(height: 16),
          PlatformElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlatformScaffold(
                    appBar: PlatformAppBar(),
                    body: auth_ui.SignInScreen(
                      providers: [auth_ui.EmailAuthProvider()],
                      actions: [
                        auth_ui.AuthStateChangeAction<auth_ui.SignedIn>((context, state) {
                          Navigator.of(context).pop();
                        }),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildLoggedInStateUI() {
    final email = FirebaseAuth.instance.currentUser?.email ?? 'Anonymous';

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Logged in as',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(email, style: Theme.of(context).textTheme.bodyLarge),
                    PlatformTextButton(
                      child: const Text('Logout'),
                      onPressed: () async =>
                          await FirebaseAuth.instance.signOut(),
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  'Favorite Places',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final place = repository.places[index];
              return PlatformListTile(
                title: Text(place.name),
                subtitle: Text(place.altitudeDescription()),
                trailing: Icon(context.platformIcons.rightChevron),
                onTap: () => _navigateToPlaceDetails(context, place),
              );
            }, childCount: repository.places.length),
          ),
        ],
      ),
    );
  }
}
