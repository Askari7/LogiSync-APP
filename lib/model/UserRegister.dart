class User {
  final String fullname;
  final String email;
  final String password;
  final String phone;
  final String role;

  User({
    required this.fullname,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
    };
  }
}
