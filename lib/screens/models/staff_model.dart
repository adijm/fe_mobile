class StaffModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String role;

  StaffModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
