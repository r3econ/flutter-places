class Place {
  String name;
  String description;
  double latitude;
  double longitude;
  int altitude;

  Place(this.name, this.latitude, this.longitude, this.altitude, this.description);
  String altitudeDescription() => '$altitude m';
}
