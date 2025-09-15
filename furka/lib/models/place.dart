class Place {
  String name;
  String description;
  double latitude;
  double longitude;
  int altitude;
  String? imageUrl;
  String? imageNote;

  Place(this.name, this.latitude, this.longitude, this.altitude, this.description, this.imageUrl, this.imageNote);
  String altitudeDescription() => '$altitude m';
}
