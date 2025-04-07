class PropertyBasic {
  final int id;
  final String title;
  final String location;
  final double price;
  final double rating;
  final List<String> imgURL;

  PropertyBasic({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.imgURL,
  });

  factory PropertyBasic.fromJson(Map<String, dynamic> json) {
    return PropertyBasic(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      imgURL: List<String>.from(json['imgURL']),
    );
  }
}

class PropertyDetails extends PropertyBasic {
  final String description;
  final String status;
  final String type;
  final double size;
  final int ownerId;
  final String ownerName;
  final String ownerContact;
  final String propertyType;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  PropertyDetails({
    required super.id,
    required super.title,
    required super.location,
    required super.price,
    required super.rating,
    required super.imgURL,
    required this.description,
    required this.status,
    required this.type,
    required this.size,
    required this.ownerId,
    required this.ownerName,
    required this.ownerContact,
    this.latitude,
    this.longitude,
    required this.propertyType,
    required this.createdAt,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
  return PropertyDetails(
    id: json['id'],
    title: json['title'] ?? '',
    location: json['location'] ?? '',
    price: (json['price'] != null) ? json['price'].toDouble() : 0.0,
    rating: (json['rating'] != null) ? json['rating'].toDouble() : 0.0,
    imgURL: (json['imgURL'] != null) ? List<String>.from(json['imgURL']) : [],
    description: json['description'] ?? '',
    status: json['status'] ?? '',
    type: json['type'] ?? '',
    size: (json['size'] != null) ? json['size'].toDouble() : 0.0,
    ownerId: json['owner_id'] ?? 0,
    ownerName: json['owner_name'] ?? '',
    ownerContact: json['owner_contact'] ?? '',
    propertyType: json['property_type'] ?? '',
    latitude: (json['latitude'] != null) ? json['latitude'].toDouble() : null,
    longitude: (json['longitude'] != null) ? json['longitude'].toDouble() : null,
    createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
  );
}

}
