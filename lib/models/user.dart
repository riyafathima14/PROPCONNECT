class User {
  final int id;
  final String name;
  final String contact;

  User({
    required this.id,
    required this.name,
    required this.contact,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['owner_name'],
      contact: json['owner_contact'],
      id: json['id']
    );
  }
}
