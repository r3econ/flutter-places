import 'package:flutter/material.dart';
import 'list_item.dart';

class PlaceListItem implements ListItem {
  final String title;
  final String subtitle;

  PlaceListItem(this.title, this.subtitle);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text(subtitle, style: Theme.of(context).textTheme.bodyLarge);
  }
}

