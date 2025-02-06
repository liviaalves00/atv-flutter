class Contact {
  int? id;
  String name;
  String phone;
  double lat;
  double lng;

  Contact(
      {this.id,
      required this.name,
      required this.phone,
      required this.lat,
      required this.lng});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'lat': lat,
      'lng': lng,
    };
  }
}
