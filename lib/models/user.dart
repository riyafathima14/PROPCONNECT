class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String userName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userName,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userName: json['user_name'],
      phone: json['owner_contact'],
      id: json['id']
    );
  }
}
