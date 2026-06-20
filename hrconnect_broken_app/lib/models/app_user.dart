class AppUser {
  final String id;
  final String employeeId;
  final String fullName;
  final String email;
  final String password;
  final String role;

  const AppUser({
    required this.id,
    required this.employeeId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );
  }

  bool get isHr => role.toLowerCase() == 'hr';
}
