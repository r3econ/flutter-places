class Place {
  String name;
  String description = 'Lorem ipsum';
  double latitude;
  double longitude;
  int altitude;

  Place(this.name, this.latitude, this.longitude, this.altitude);
  String altitudeDescription() => '$altitude m';
}
